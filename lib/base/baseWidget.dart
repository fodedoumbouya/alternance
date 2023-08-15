import 'package:flutter/material.dart';
import 'package:internship/common/network/network_util.dart';

import '../common/utils/myLog.dart';
import '../common/utils/sizeConfig.dart';

abstract class BaseWidget extends StatefulWidget {
  const BaseWidget({Key? key}) : super(key: key);

  @override
  BaseWidgetState createState() {
    return getState();
  }

  BaseWidgetState getState();
}

abstract class BaseWidgetState<T extends BaseWidget> extends State<T>
    with WidgetsBindingObserver {
  @override
  void initState() {
    pt(message: "main initState", d: true);
    super.initState();
  }

  Widget txtw(String t,
      {Color? color,
      FontWeight? fontWeight,
      double? size,
      FontStyle? fontStyle = FontStyle.normal,
      bool isPorjectX = false,
      int? maxLines,
      bool withOverflow = true}) {
    // color ??= const Color.fromRGBO(0, 0, 0, 0.392);
    TextOverflow? overflow = withOverflow ? TextOverflow.ellipsis : null;
    return Text(
      t,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: size,
        fontStyle: fontStyle,
        overflow: overflow,
      ),
    );
  }

  Widget c({
    Widget? child,
    double? h,
    double? w,
    double? allM,
    double allP = 0,
    double topM = 0,
    double bottomM = 0,
    double leftM = 0,
    double rightM = 0,
    double radius = 0,
    Alignment? alig,
    EdgeInsetsGeometry? padding,
    Color? color,
    String? image,
    BoxFit? fit = BoxFit.fill,
    Alignment decoAlignment = Alignment.topCenter,
    String imgType = "png",
    // Color c = Colors.transparent,
    List<BoxShadow>? boxShadow,
    BoxShape boxShape = BoxShape.rectangle,
    BorderRadius? borderRadius,
    BoxBorder? border,
    Rect? centerSlice,
    Key? key,
    Gradient? gradient,
  }) =>
      Container(
        key: key,
        alignment: alig,
        margin: allM == null
            ? EdgeInsets.only(
                left: leftM, right: rightM, bottom: bottomM, top: topM)
            : EdgeInsets.all(allM),
        padding: padding ?? EdgeInsets.all(allP),
        decoration: BoxDecoration(
          color: color,
          shape: boxShape,
          boxShadow: boxShadow,
          gradient: gradient,
          image: image == null
              ? null
              : DecorationImage(
                  image: AssetImage('images/$image.$imgType'),
                  scale: MediaQuery.of(context).devicePixelRatio,
                  centerSlice: centerSlice,
                  fit: fit,
                  alignment: decoAlignment),
          border: border,
          borderRadius: boxShape != BoxShape.rectangle
              ? null
              : borderRadius ?? BorderRadius.circular(radius),
        ),
        height: h,
        width: w,
        child: child,
      );

  pt(
      {required Object message,
      bool e = false,
      bool w = false,
      bool wtf = false,
      bool d = false,
      bool v = false}) {
    String msg = (w || e)
        ? "\n-----------------------------------------------------------------------\n\n$message \n-----------------------------------------------------------------------\n\n"
        : message.toString();
    if (e) {
      AppLog.e(msg);
    } else if (w) {
      AppLog.w(msg);
    } else if (wtf) {
      AppLog.wtf(msg);
    } else if (d) {
      AppLog.d(msg);
    } else if (v) {
      AppLog.v(msg);
    } else {
      AppLog.i(msg);
    }
  }

  Widget get sb => const SizedBox.shrink();
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
    } else if (state == AppLifecycleState.paused) {}
  }

  @override
  void didChangeDependencies() {
    pt(message: "didChangeDependencies\n", d: true);
    super.didChangeDependencies();
  }

  SizeConfig sizeConfig() {
    return SizeConfig(cxt: context);
  }

  double xx(double x, {Size? widgetSize}) {
    var sizeConf = sizeConfig();
    if (widgetSize != null) {
      sizeConf = SizeConfig(cxt: context, widgetSize: widgetSize);
    }
    return sizeConf.safeBlockHorizontal * x;
  }

  double yy(double y, {Size? widgetSize}) {
    var sizeConf = sizeConfig();
    if (widgetSize != null) {
      sizeConf = SizeConfig(cxt: context, widgetSize: widgetSize);
    }
    return sizeConf.safeBlockVertical * y;
    //sh() / 2220 * y;
  }

  Image imgw(
    String url, {
    BoxFit? fit,
    double? width,
    double? height,
    Color? color,
  }) {
    return Image.network(
      url,
      fit: fit,
      height: height,
      width: width,
      color: color,
    );
  }

  rebuidState() {
    if (mounted) {
      setState(() {});
    }
  }

  Color bp() {
    return Theme.of(context).primaryColor;
  }

  Color bcGrey() {
    return const Color.fromRGBO(98, 99, 102, 1);
  }

  @override
  Widget build(BuildContext context) {
    pt(message: "build\n", d: true);

    return Scaffold(
      body: baseBuild(context),
    );
  }

  baseBuild(BuildContext context) {}

  @override
  void dispose() {
    super.dispose();
  }

  //   postMap(
  //   String url,
  //   Map<String, dynamic> body,
  //   var callback,
  // ) async {
  //   var res = await globalRequest(path: url, isGet: false, body: body);
  //   callback(res);
  //   return res;
  // }
  getMap({required String searchName, var callback}) async {
    var res =
        await globalRequest(searchName: searchName, isGet: true, body: {});
    callback(res);
    return res;
  }
}
