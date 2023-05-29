import 'package:flutter/material.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:investions/Constant/SharedPreferenceClass.dart';
import 'package:provider/provider.dart';

class ThemeNotifier with ChangeNotifier{
 final darkTheme=ThemeData(
   primaryColorDark: Colors.black,
  iconTheme: IconThemeData(color: Colors.white),
  backgroundColor: Colors.black,
  primaryColor: Colors.white,
  brightness: Brightness.dark,
  fontFamily: 'Poppins',
  appBarTheme: AppBarTheme(color: Colors.black,titleTextStyle: TextStyle(color: Colors.white),iconTheme: IconThemeData(color: Colors.white)),
  cardColor: ColorsCollectionsDark.cardcolors,
  buttonColor: ColorsCollectionsDark.buttoncolors,
  hoverColor: ColorsCollectionsDark.cartButtonColor,
  hintColor: ColorsCollectionsDark.buttoncolorsMostTrade,
  highlightColor: ColorsCollectionsDark.listcolors,
  bottomAppBarColor: ColorsCollectionsDark.listcolorsButton,
  canvasColor: ColorsCollectionsDark.underlineColor,
  focusColor: ColorsCollectionsDark.blueColor,
  dividerColor: ColorsCollectionsDark.tabsColor,
  indicatorColor: ColorsCollectionsDark.greyColor,
  shadowColor: ColorsCollectionsDark.greenlightColor,
  errorColor:  ColorsCollectionsDark.bottomColor,
  selectedRowColor: ColorsCollectionsDark.whiteColor,
     accentColor:ColorsCollectionsDark.cardcolors,
     dialogBackgroundColor:ColorsCollectionsDark.blueDarkColor,
     toggleableActiveColor: ColorsCollectionsDark.lightBluegGreyColor,
  textTheme: TextTheme(
    headline1: TextStyle(color: Colors.white),
    headline2: TextStyle(color: Colors.white.withOpacity(1)),
    headline3: TextStyle(color: Colors.white),
    headline4: TextStyle(color: ColorsCollectionsDark.tabColor),
    headline5: TextStyle(color: ColorsCollectionsDark.TextfieldColor),

  )
 );
 final lightTheme=ThemeData(
  iconTheme: IconThemeData(color: Colors.white),
  backgroundColor: Colors.white,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  fontFamily: 'Poppins',
  appBarTheme: AppBarTheme(backgroundColor: Colors.white,titleTextStyle: TextStyle(color: Colors.black),iconTheme: IconThemeData(color: Colors.black)),
     cardColor: ColorsCollectionlight.cardcolors,
     buttonColor: ColorsCollectionlight.buttoncolors,
     hintColor: ColorsCollectionlight.buttoncolorsMostTrade,
     highlightColor: ColorsCollectionlight.listcolors,
     bottomAppBarColor: ColorsCollectionlight.listcolorsButton,
     hoverColor: ColorsCollectionlight.cartButtonColor,
     canvasColor: ColorsCollectionlight.underlineColor,
     focusColor: ColorsCollectionlight.blueColor,
     dividerColor: ColorsCollectionlight.tabsColor,
     indicatorColor: ColorsCollectionlight.greyColor,
     shadowColor: ColorsCollectionlight.greenlightColor,
     errorColor:  ColorsCollectionlight.bottomColor,
selectedRowColor: ColorsCollectionlight.whiteColor,
     accentColor:ColorsCollectionlight.lightblueColor,
     dialogBackgroundColor:ColorsCollectionlight.blueDarkColor,
     toggleableActiveColor: ColorsCollectionlight.lightBluegGreyColor,
     textTheme: TextTheme(
       headline1: TextStyle(color: Colors.white),
       headline2: TextStyle(color: Colors.black87),
       headline3: TextStyle(color: Colors.black54),
       headline4: TextStyle(color:ColorsCollectionlight.tabColor),
       headline5: TextStyle(color: ColorsCollectionlight.TextfieldColor),
     )
 );



 ThemeData? themeData;
 ThemeData? getTheme() => themeData;

 ThemeNotifier(){
   SharedPreferenceClass.GetSharedData("themeMode").then((value) {
     var mode=value??"dark";
     if(mode.toString()=="null"){
       themeData=darkTheme;
     } else {
       mode.toString() == "light" ? themeData = lightTheme : themeData = darkTheme;
     }
     notifyListeners();
   });
 }
 void setDarkMode() async {
  themeData = darkTheme;
  notifyListeners();
 }
 void setLightMode() async {
  themeData = lightTheme;
  notifyListeners();
 }
 // bool _selectProduct=false;
 // bool get selectProduct=>_selectProduct;
 // notification(bool hit) {
 //   _selectProduct= hit;
 //   print("hit>>"+ _selectProduct.toString());
 //   notifyListeners();
 // }
}