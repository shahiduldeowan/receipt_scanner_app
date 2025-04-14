import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:receipt_scanner_app/config/app_theme.dart';
import 'package:receipt_scanner_app/di/injection.dart' show getIt;
import 'package:receipt_scanner_app/services/camera_service.dart'
    show CameraService;

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  final CameraService _cameraService = getIt<CameraService>();
  CameraController? _controller;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Take a picture here
        print("Take a picture");
      }
      print("[][ $status ][]");
    });
  }

  Future<void> _initCamera() async {
    final cameraController = await _cameraService.initCamera();
    if (cameraController != null) {
      setState(() {
        _controller = cameraController;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _controller!.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCameraController(_controller!.description);
    }
  }

  Future<void> _initializeCameraController(
    CameraDescription description,
  ) async {
    final cameraController = CameraController(
      description,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    await cameraController.initialize();
    setState(() {
      _controller = cameraController;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fontDarkColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_controller == null) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }

    return SafeArea(
      child: Stack(
        children: [
          SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: CameraPreview(_controller!),
          ),
          _buildAppBar(),
          _buildTakePictureButton(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IconButton.filled(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primaryContainerColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget _buildTakePictureButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (_animationController.status ==
                      AnimationStatus.completed) {
                    _animationController.reverse();
                  } else {
                    _animationController.forward();
                  }
                },
                icon: const Icon(Icons.photo_camera),
                label: const Text('Take Picture'),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    _cameraService.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
