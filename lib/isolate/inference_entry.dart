import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:image/image.dart' as img;

import 'package:receipt_scanner_app/models/inference_model.dart';
import 'package:receipt_scanner_app/utils/image_util.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class InferenceEntry {
  static const String _debugName = 'TFLITE_INFERENCE_ENTRY';
  static const int _rotationAngle = 90;

  final ReceivePort _receivePort = ReceivePort();
  late Isolate _isolate;
  late SendPort _sendPort;

  SendPort get sendPort => _sendPort;

  Future<void> init() async {
    _isolate = await Isolate.spawn<SendPort>(
      entryPoint,
      _receivePort.sendPort,
      debugName: _debugName,
    );
    _sendPort = await _receivePort.first;
  }

  static void entryPoint(SendPort sendPort) async {
    final ReceivePort receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    await for (final isolateModel in receivePort) {
      if (isolateModel is InferenceModel) {
        try {
          final image = _getImage(isolateModel);
          var imageInput = _resizeImage(image!, isolateModel.inputShape);
          if (Platform.isAndroid && isolateModel.isValidCameraFrame()) {
            imageInput = img.copyRotate(imageInput, angle: _rotationAngle);
          }
          final imageMatrix = _createImageMatrix(imageInput);

          final input = [imageMatrix];
          final output = [List<int>.filled(isolateModel.outputShape[1], 0)];
          Interpreter interpreter = Interpreter.fromAddress(
            isolateModel.interpreterAddress,
          );
          interpreter.run(input, output);
          final result = output.first;
          final classification = _createClassification(
            result,
            isolateModel.labels,
          );
          isolateModel.responsePort.send(classification);
        } catch (e) {
          log('Error: $e');
        }
      }
    }
  }

  static img.Image? _getImage(InferenceModel isolateModel) {
    img.Image? image;
    if (isolateModel.isValidCameraFrame()) {
      image = ImageUtil.convertCameraImage(isolateModel.cameraImage!);
    } else {
      image = isolateModel.image;
    }
    return image;
  }

  static img.Image _resizeImage(img.Image image, List<int> inputShape) {
    return img.copyResize(image, width: inputShape[1], height: inputShape[2]);
  }

  static List<List<List<int>>> _createImageMatrix(img.Image image) {
    return List.generate(
      image.height,
      (y) => List.generate(image.width, (x) {
        final pixel = image.getPixel(x, y);
        return [pixel.r.toInt(), pixel.g.toInt(), pixel.b.toInt()];
      }),
    );
  }

  static Map<String, double> _createClassification(
    List<int> result,
    List<String> labels,
  ) {
    int maxScore = result.reduce((a, b) => a + b);
    var classification = <String, double>{};
    for (var i = 0; i < result.length; i++) {
      if (result[i] != 0) {
        classification[labels[i]] = result[i].toDouble() / maxScore.toDouble();
      }
    }
    return classification;
  }

  void dispose() {
    _isolate.kill(priority: Isolate.immediate);
    _receivePort.close();
  }
}
