import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:receipt_scanner_app/di/injection.dart'
    show configureDependencies;
import 'package:receipt_scanner_app/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
  ]).then((_) => configureDependencies().then((_) => runApp(const MyApp())));
}
