import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorsCollectionsDark{
  static final Color topborder=Color(0Xff2e456d);
  static final Color cardcolors=Color(0Xff152541);
  static final Color buttoncolors=Color(0Xff91ca63);
  static final Color buttoncolorsMostTrade=Color(0Xff2e456d);
  static final Color listcolors=Color(0Xff182c4f);
  static final Color listcolorsButton=Color(0Xff152541);
  static final Color cartButtonColor=Color(0Xff2dbf5e);
  static final Color underlineColor=Color(0Xff152541);
  static final Color blueDarkColor=Color(0Xff027ebc);
  static final Color blueColor=Color(0Xff2086D6);
  static final Color tabsColor=Color(0Xff1e3866);
  static final Color whiteColor=Color(0XffFFFFFF);
  static final Color greyColor=Color(0Xff969bab);
  static final Color greenlightColor=Color(0Xff89bf61);
  static final Color bottomColor=Color(0Xff18315d);
  static final Color lightblueColor=Color(0Xff1f52bb);
  static final Color tabColor=Color(0Xff3d495f);
  static final Color TextfieldColor=Color(0Xff3e4f6c);
  static final Color peertopeerBorder=Color(0Xff182d52);
  static final Color markitlist=Color(0Xff651d2c);
  static final Color markitlistgreen=Color(0Xff2dbf5e);
  static final Color portfolioBorderColor=Color(0Xff3d495f);
  static final Color lightBluegGreyColor=Color(0Xffa6a4a4);
}


class ColorsCollectionlight{
  static final Color topborder=Color(0Xffdbe8ff);
  static final Color cardcolors=Color(0Xfffbfdff);
  static final Color buttoncolors=Color(0Xff91ca63);
  static final Color buttoncolorsMostTrade=Color(0Xffdbe8ff);
  static final Color listcolors=Color(0Xfffbfdff);
  static final Color listcolorsButton=Color(0Xff9cbdf6);
  static final Color cartButtonColor=Color(0Xff2dbf5e);
  static final Color underlineColor=Color(0Xffdddede);
  static final Color blueDarkColor=Color(0Xff89bf61);
  static final Color blueColor=Color(0Xff2086D6);
  static final Color tabsColor=Color(0Xff1e3866);
  static final Color whiteColor=Color(0Xff000000);
  static final Color greyColor=Color(0Xff969bab);
  static final Color greenlightColor=Color(0Xff89bf61);
  static final Color bottomColor=Color(0Xff0f153a);
  static final Color lightblueColor=Color(0Xffe7f0ff);
  static final Color tabColor=Colors.grey.shade600;
  static final Color TextfieldColor=Color(0Xffd5dff1);
  static final Color peertopeerBorder=Color(0Xff182d52);
  static final Color markitlist=Color(0Xff651d2c);
  static final Color markitlistgreen=Color(0Xff2dbf5e);
  static final Color portfolioBorderColor=Color(0Xff3d495f);
  static final Color lightBluegGreyColor=Color(0Xff88aee9);

}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}