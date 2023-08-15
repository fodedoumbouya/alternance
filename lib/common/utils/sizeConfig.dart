import 'package:flutter/widgets.dart';

class SizeConfig {
  late final MediaQueryData _mediaQueryData;
  late final double screenWidth;
  late final double screenHeight;
  late final double blockSizeHorizontal;
  late final double blockSizeVertical;

  late final double _safeAreaHorizontal;
  late final double _safeAreaVertical;
  late final double safeBlockHorizontal;
  late final double safeBlockVertical;

  SizeConfig({required BuildContext cxt, Size? widgetSize}) {
    init(context: cxt, widgetSize: widgetSize);
  }

  void init({required BuildContext context, Size? widgetSize}) {
    _mediaQueryData = MediaQuery.of(context);
    Size size = _mediaQueryData.size;
    if (widgetSize != null) {
      size = widgetSize;
    }
    screenWidth = size.width;
    screenHeight = size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}
