
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:investions/Constant/SharedPreferenceClass.dart';
import 'package:investions/Screen/Credential%20Screen/LoginWidget.dart';
import 'package:investions/Screen/P2P/P2Pbuy_sell.dart';

import '../../Api/ApiCollections.dart';
import '../../Api/ApiMain.dart';
import '../../Constant/CommonClass.dart';
import '../Quicky_buy.dart';


class SplashScreen extends StatefulWidget {
  static const id = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
String status='';
  @override
  void initState() {
    getApi();
    super.initState();
    Timer(Duration(seconds: 6), (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Quick_buy(p2pdata(0,0))));
    }
    );
  }
getApi()async{
  await getRequest();
  await getdata();
}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height:MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/splash.png'),
                      fit: BoxFit.fill)),
            ),
    );
  }
}
