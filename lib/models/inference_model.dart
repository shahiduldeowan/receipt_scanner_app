import 'dart:isolate' show SendPort;

import 'package:camera/camera.dart' show CameraImage;
import 'package:image/image.dart' as img;

/// Isolate data container
class InferenceModel {
  CameraImage? cameraImage;
  img.Image? image;
  int interpreterAddress;
  List<String> labels;
  List<int> inputShape;
  List<int> outputShape;
  late SendPort responsePort;

  InferenceModel({
    required this.cameraImage,
    required this.interpreterAddress,
    required this.labels,
    required this.inputShape,
    required this.outputShape,
  });

  bool isValidCameraFrame() {
    if (cameraImage == null) {
      return false;
    }
    return cameraImage?.planes.isNotEmpty ?? false;
  }
}
