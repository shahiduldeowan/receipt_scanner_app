import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipt_scanner_app/config/app_config.dart';
import 'package:receipt_scanner_app/config/app_routes.dart';
import 'package:receipt_scanner_app/config/app_theme.dart' show ThemeHelper;
import 'package:receipt_scanner_app/controllers/cubit/receipt_cubit_cubit.dart';
import 'package:receipt_scanner_app/di/injection.dart';
import 'package:receipt_scanner_app/utils/app_size_utils.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSizer(
      builder: (context, orientation, deviceType) {
        return BlocProvider(
          create: (context) => getIt<ReceiptCubit>(),
          child: MaterialApp(
            title: AppConfig.title,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!,
              );
            },
            debugShowCheckedModeBanner: AppConfig.debugShowCheckedModeBanner,
            themeMode: ThemeMode.dark,
            darkTheme: ThemeHelper.theme,
            initialRoute: AppRoutes.initialRoute,
            onGenerateRoute: AppRoutes.onGenerateRoute,
          ),
        );
      },
    );
  }
}
