import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../Dialog/FollowUsOnWidget.dart';

class FeeSettingsWidget extends StatefulWidget {
  static const id = 'FeeSettings';

  @override
  State<FeeSettingsWidget> createState() =>_FeeSettingsWidgetState();
}

class _FeeSettingsWidgetState extends State<FeeSettingsWidget> {



  bool status = false;

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        primary:false,
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Container(
              height: size.height * 0.4,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/dashboard_headerImage.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top:40.0,left: 23),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back,color: Colors.white,)),
                      SizedBox(width: 10,),
                      Text("Fee Settings",style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height*0.145, left: 16.0, right: 16.0),
              child: Card(
                  elevation: 10,
                  // color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: size.height,
                          width: size.width,
                          padding: EdgeInsets.only(top:4,bottom:4,),
                          decoration: BoxDecoration(
                            //  color: Theme.of(context).buttonColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                            ),
                            gradient: LinearGradient(
                              colors: [Theme
                                  .of(context)
                                  .cardColor,
                                Theme
                                    .of(context)
                                    .cardColor
                              ],
                            ),

                          ),
                          child: Column(
                            children: [
                              InkWell(
                                onTap:(){

                                },
                                child: Padding(
                                  padding:  EdgeInsets.only(left:8.0,right:8.0,top:6,bottom: 2.0),
                                  child:
                                  Container(
                                    height: size.height*0.28,
                                    //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(3),),
                                      gradient: LinearGradient(
                                        colors: [Theme
                                            .of(context)
                                            .hintColor.withOpacity(0.4),
                                          Theme
                                              .of(context)
                                              .hintColor.withOpacity(0.4)
                                        ],
                                      ),
                                    ),
                                    child:  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10,),
                                        Padding(
                                          padding:  EdgeInsets.only(left: 20.0,right: 10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text( "Skip Buy/Sell Confirmations",
                                                style: TextStyle(color: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline2
                                                    ?.color,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,),),
                                              FlutterSwitch(
                                                width: 40.0,
                                                height: 18.0,
                                                valueFontSize: 12.0,
                                                toggleSize: 18.0,
                                                padding: 1,
                                                value: status,
                                                onToggle: (val) {
                                                  setState(() {
                                                    status = val;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),

                                       SizedBox(height: 10,),
                                       DottedLine(
                                         dashColor: Theme.of(context).indicatorColor.withOpacity(0.6),),
                                        Padding(
                                          padding:  EdgeInsets.only(left:20.0,right: 10.0,top:10.0),
                                          child: Text( "Enable this options to pay trading fee withs: ",
                                            style: TextStyle(color: Theme
                                                .of(context)
                                                .indicatorColor,
                                              fontSize: 9,
                                              fontWeight: FontWeight.w600,),),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left:14.0,right: 10.0,top:6.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 12,
                                                height: 0.7,
                                                color: Theme.of(context).focusColor,
                                              ),
                                              SizedBox(width: 2,),
                                              Text( "Investinos you buy from the exchange ",
                                                style: TextStyle(color: Theme
                                                    .of(context)
                                                    .indicatorColor,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w400,),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left:14.0,right: 10.0,top:6.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 12,
                                                height: 0.7,
                                                color: Theme.of(context).focusColor,
                                              ),
                                              SizedBox(width: 2,),
                                              Text( "Unlocked Investinos balance reserved for trading fees ",
                                                style: TextStyle(color: Theme
                                                    .of(context)
                                                    .indicatorColor,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w400,),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left:14.0,right: 10.0,top:16.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  Text( "Note: ",textAlign: TextAlign.start,
                                                    style: TextStyle(color: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .headline2
                                                        ?.color,
                                                      fontSize: 9,
                                                      fontWeight: FontWeight.w400,),),
                                                  SizedBox(height: 2,),
                                                  Text( "With",
                                                    style: TextStyle(color: Theme
                                                        .of(context)
                                                        .indicatorColor,
                                                      fontSize: 9,
                                                      fontWeight: FontWeight.w400,),),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text( " Enabling This Feature Allow You To Pay Trading Fees",
                                                    style: TextStyle(color: Theme
                                                        .of(context)
                                                        .indicatorColor,
                                                      fontSize: 9,
                                                      fontWeight: FontWeight.w400,),),
                                                  SizedBox(height: 2,),
                                                  Text("Investinos is Only Usdt,Btc And Investinos Markets.",
                                                    style: TextStyle(color: Theme
                                                        .of(context)
                                                        .indicatorColor,
                                                      fontSize: 9,
                                                      fontWeight: FontWeight.w400,),),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),

                                ),
                              ),

                              Padding(
                                padding:  EdgeInsets.only(left:8.0,right:8.0,top:6,bottom: 2.0),
                                child:
                                Container(
                                  height: size.height*0.35,
                                  //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(3),),
                                    gradient: LinearGradient(
                                      colors: [Theme
                                          .of(context)
                                          .hintColor.withOpacity(0.4),
                                        Theme
                                            .of(context)
                                            .hintColor.withOpacity(0.4)
                                      ],
                                    ),
                                  ),
                                  child:  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10,),
                                      Padding(
                                        padding:  EdgeInsets.only(left:20.0,right: 6.0,top:10.0),
                                        child: Text( "BASED ON YOUR INVESTINOS HOLDING AT THE TIME TRADE, YOUR\n"
                                            "TRADING FEERATE WILL BE DETERMINED AS FOLLOW:",
                                          style: TextStyle(color: Theme
                                              .of(context)
                                              .indicatorColor,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w500,),),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.only(left:14.0,right: 10.0,top:20.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: size.width*0.3,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text( "Investinos Holdings ",
                                                    style: TextStyle(color: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .headline2
                                                        ?.color,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w600,),),
                                                  SizedBox(height: 10),
                                                  Text( "0-10 Investinos ",
                                                    style: TextStyle(color: Theme
                                                        .of(context)
                                                        .indicatorColor,
                                                      fontSize: 9,
                                                      fontWeight: FontWeight.w400,),),
                                                  SizedBox(height: 10),
                                                  Text( "10-200 Investinos ",
                                                    style: TextStyle(color: Theme
                                                        .of(context)
                                                        .indicatorColor,
                                                      fontSize: 9,
                                                      fontWeight: FontWeight.w400,),),
                                                  SizedBox(height: 10),
                                                  Text( "200-1000 Investinos ",
                                                    style: TextStyle(color: Theme
                                                        .of(context)
                                                        .indicatorColor,
                                                      fontSize: 9,
                                                      fontWeight: FontWeight.w400,),),
                                                  SizedBox(height: 10),
                                                  Text( "1000 Investinos ",
                                                    style: TextStyle(color: Theme
                                                        .of(context)
                                                        .indicatorColor,
                                                      fontSize: 9,
                                                      fontWeight: FontWeight.w400,),),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: size.width*0.4,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text( "Trading Fee Payable ",
                                                    style: TextStyle(color: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .headline2
                                                        ?.color,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w600,),),
                                                  SizedBox(height: 10),
                                                  Text( "0.2% ",
                                                    style: TextStyle(color: Theme
                                                        .of(context)
                                                        .indicatorColor,
                                                      fontSize: 9,
                                                      fontWeight: FontWeight.w400,),),
                                                  SizedBox(height: 10),
                                                  Text( "0.17% ",
                                                    style: TextStyle(color: Theme
                                                        .of(context)
                                                        .indicatorColor,
                                                      fontSize: 9,
                                                      fontWeight: FontWeight.w400,),),
                                                  SizedBox(height: 10),
                                                  Text( "0.15% ",
                                                    style: TextStyle(color: Theme
                                                        .of(context)
                                                        .indicatorColor,
                                                      fontSize: 9,
                                                      fontWeight: FontWeight.w400,),),
                                                  SizedBox(height: 10),
                                                  Text( "0.1% ",
                                                    style: TextStyle(color: Theme
                                                        .of(context)
                                                        .indicatorColor,
                                                      fontSize: 9,
                                                      fontWeight: FontWeight.w400,),),

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),

                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
