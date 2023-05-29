
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:investions/Api/MarketPageProvider.dart';
import 'package:investions/Api/Provideclass.dart';
import 'package:provider/provider.dart';
import 'Constant/Error_Screen.dart';
import 'Constant/Themedata.dart';
import 'Screen/Credential Screen/splash_screen.dart';
import 'Util/RouteGenerator.dart';






void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState  extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (BuildContext context)=>ThemeNotifier()),
        ChangeNotifierProvider(create: (BuildContext context)=>providerdata()),
        ChangeNotifierProvider(create: (BuildContext context)=>market()),
    ],
        child:ChangeNotifierProvider<ThemeNotifier>(
          create: (_)=>ThemeNotifier(),
          child: Consumer<ThemeNotifier>(
            builder:(context,theme,child) => MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme:theme.getTheme(),
             // builder: (BuildContext context,Widget? widget){
             //    ErrorWidget.builder=(FlutterErrorDetails erroeDetails){
             //      print("eroor"+erroeDetails.toString());
             //      return CustomError(errorDetails: erroeDetails,);
             //    };
             //    return widget!;
             // },
             // home:Quick_buy(),
              home: SplashScreen(),
              onGenerateRoute: RouteGenerator.generateRoute,
            ),
          ),
        ),

    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  HttpClient createHttpClent(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

