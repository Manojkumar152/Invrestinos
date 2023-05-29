import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:getwidget/components/radio_list_tile/gf_radio_list_tile.dart';
import 'package:investions/Screen/Setting/FAWidget.dart';
import 'package:provider/provider.dart';

import '../../Constant/SharedPreferenceClass.dart';
import '../../Constant/Themedata.dart';
import 'ActivityLogsWidget.dart';
import 'TradeSettingWidget.dart';

class SecurityWidget extends StatefulWidget {
   static const id = 'SecurityWidget';
  @override
  _SecurityWidgetState createState() => _SecurityWidgetState();
}

class _SecurityWidgetState extends State<SecurityWidget> {

  bool status = false;
 @override
  void initState() {
 //   getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                      Text("Security",style: TextStyle(color: Colors.white),)
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
                            Padding(
                              padding:  EdgeInsets.only(left:8.0,right:8.0,top:10,bottom: 2.0),
                              child:
                              Container(
                                height: size.height*0.0589,
                                width:size.width,
                                //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(2),),
                                  gradient: LinearGradient(
                                    colors: [Theme
                                        .of(context)
                                        .hintColor,
                                      Theme
                                          .of(context)
                                          .hintColor
                                    ],
                                  ),
                                ),
                                child:  Padding(
                                  padding:  EdgeInsets.only(left:20.0,right: 8.0),
                                  child: Align(
                                    alignment:Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text( "App Passcode ",
                                          style: TextStyle(color: Theme
                                              .of(context)
                                              .textTheme
                                              .headline2
                                              ?.color,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,),),

                                        FlutterSwitch(
                                          width: 35.0,
                                          height: 16.0,
                                          valueFontSize: 12.0,
                                          toggleSize: 14.0,
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
                                ),
                              ),
                            ),

                            Padding(
                              padding:  EdgeInsets.only(left:8.0,right:8.0,top:12,bottom: 2.0),
                              child:
                              Container(
                                height: size.height*0.0589,
                                width:size.width,
                                //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(2),),
                                  gradient: LinearGradient(
                                    colors: [Theme
                                        .of(context)
                                        .hintColor,
                                      Theme
                                          .of(context)
                                          .hintColor
                                    ],
                                  ),
                                ),
                                child:  InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, FAWidget.id);
                                  },
                                  child: Padding(
                                    padding:  EdgeInsets.only(left:20.0,right: 8.0),
                                    child: Align(
                                      alignment:Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text( "Two Factor Authentical ",
                                            style: TextStyle(color: Theme
                                                .of(context)
                                                .textTheme
                                                .headline2
                                                ?.color,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,),),

                                          Icon(Icons.arrow_forward_ios_outlined,size: 14,
                                              color: Theme.of(context).selectedRowColor,),

                                        ],
                                      ),
                                    ),
                                  ),
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

class CustomList {
  String id;
  String Name;

  CustomList(this.id ,this.Name);
}

