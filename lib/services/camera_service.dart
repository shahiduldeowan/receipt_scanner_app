import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

typedef FrameCallback = void Function(CameraImage image);

@lazySingleton
class CameraService {
  CameraController? _controller;

  Future<CameraController?> initCamera({FrameCallback? onFrame}) async {
    try {
      final cameras = await availableCameras();
      final backCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      );
      _controller = CameraController(
        backCamera,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await _ensureCameraPermission();
      await _controller?.initialize();

      if (onFrame != null) {
        _controller?.startImageStream(onFrame);
      }

      return _controller;
    } on CameraException {
      print('Error: Camera initialization failed');
      return null;
    }
  }

  Future<void> _ensureCameraPermission() async {
    while (await _isCameraPermissionDenied()) {
      await _requestCameraPermission();
    }
  }

  Future<bool> _isCameraPermissionDenied() async {
    final status = await Permission.camera.status;
    return status.isDenied;
  }

  Future<void> _requestCameraPermission() async {
    final permissionStatus = await Permission.camera.request();
    if (permissionStatus.isDenied) {
      throw CameraException('Camera permission denied');
    }
  }

  CameraController? get controller => _controller;

  // void dispose() {
  //   // _controller?.dispose();
  //   _controller?.stopImageStream();
  // }
  void dispose() {
    if (_controller != null && _controller!.value.isInitialized) {
      try {
        _controller!.stopImageStream();
      } catch (_) {
        // Ignore stop errors if already disposed
      }
      _controller!.dispose();
    }
    _controller = null;
  }
}

class CameraException implements Exception {
  final String message;

  CameraException(this.message);

  @override
  String toString() => message;
}
