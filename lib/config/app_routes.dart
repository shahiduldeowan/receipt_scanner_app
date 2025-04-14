import 'package:flutter/material.dart';
import 'package:receipt_scanner_app/views/camera_view.dart';
import 'package:receipt_scanner_app/views/home_page.dart';

class AppRoutes {
  static const initialRoute = '/';
  static const cameraViewRoute = '/camera_view';

  static Route? onGenerateRoute(RouteSettings settings) {
    return switch (settings.name) {
      initialRoute => MaterialPageRoute(builder: (_) => const HomePage()),
      cameraViewRoute => MaterialPageRoute(builder: (_) => const CameraView()),
      _ => null,
    };
  }
}
