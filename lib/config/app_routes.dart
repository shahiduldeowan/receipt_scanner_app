import 'package:flutter/material.dart';
import 'package:receipt_scanner_app/views/home_page.dart';

class AppRoutes {
  static const initialRoute = '/';

  static Route? onGenerateRoute(RouteSettings settings) {
    return switch (settings.name) {
      initialRoute => MaterialPageRoute(builder: (_) => const HomePage()),
      _ => null,
    };
  }
}
