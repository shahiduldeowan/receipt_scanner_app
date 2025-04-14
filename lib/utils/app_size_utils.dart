import 'package:flutter/material.dart';

enum AppDesignDimensions {
  width(375),
  height(812),
  statusBar(0);

  const AppDesignDimensions(this._value);

  final num _value;

  num get get => _value;
}

enum DeviceType { mobile, tablet, desktop }

typedef ResPonsiveBuilder =
    Widget Function(
      BuildContext ctx,
      Orientation orientation,
      DeviceType deviceType,
    );

class AppSizer extends StatelessWidget {
  const AppSizer({super.key, required this.builder});

  final ResPonsiveBuilder builder;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraint) {
      return OrientationBuilder(
        builder: (context, orientation) {
          AppSizeUtils.setScreenSize(constraint);
          return builder(context, orientation, AppSizeUtils.deviceType);
        },
      );
    },
  );
}

class AppSizeUtils {
  AppSizeUtils._();

  static double width = AppDesignDimensions.width.get.toDouble();
  static double height = AppDesignDimensions.height.get.toDouble();
  static bool initialized = false;
  static DeviceType deviceType = DeviceType.mobile;

  static void setScreenSize(BoxConstraints constraints) {
    if (!initialized) {
      width = constraints.maxWidth;
      height = constraints.maxHeight;
      initialized = true;
    }

    // Fix for mobile view
    deviceType = DeviceType.mobile;
  }
}
