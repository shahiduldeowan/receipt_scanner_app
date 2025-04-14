import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@lazySingleton
class CameraService {
  CameraController? _controller;

  Future<CameraController?> initCamera() async {
    try {
      final cameras = await availableCameras();
      final backCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      );
      _controller = CameraController(
        backCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await _ensureCameraPermission();
      await _controller?.initialize();
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

  void dispose() {
    _controller?.dispose();
  }
}

class CameraException implements Exception {
  final String message;

  CameraException(this.message);

  @override
  String toString() => message;
}
