import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:getwidget/components/radio_list_tile/gf_radio_list_tile.dart';
import 'package:investions/Screen/Setting/NotificationsWidget.dart';
import 'package:provider/provider.dart';

import '../Constant/ColorsCollection.dart';
import '../Constant/SharedPreferenceClass.dart';
import '../Constant/Themedata.dart';
import 'MarketWidget.dart';
import 'Exchange/USDTWidget.dart';

class InviteAndEarnWidget extends StatefulWidget {
   static const id = 'InviteAndEarnWidget';
  @override
  _InviteAndEarnWidgetState createState() => _InviteAndEarnWidgetState();
}

class _InviteAndEarnWidgetState extends State<InviteAndEarnWidget>  {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          Container(
            height: size.height * 0.367,
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/dashboard_headerImage.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding:  EdgeInsets.only(top:40.0,left: 23),
              child: Column(
                children: [
                  Align(
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
                        Text("Invite & Earn",style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Center(
                    child: Text("Investinos Refferral Program",style: TextStyle(fontSize:12,color: Theme
                        .of(context)
                        .textTheme
                        .headline1
                        ?.color),),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text("refer & earn 50 % trading fee paid by ypur friend as reward.\n be your own boss!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize:8,color: Theme
                        .of(context)
                        .textTheme
                        .headline1
                        ?.color),),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height*0.285, left: 16.0, right: 16.0),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: size.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                        },
                        child: Container(
                          height:size.height*0.15,
                          width: size.width,
                          margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).hintColor,
                              borderRadius: BorderRadius.circular(2),
                              border:Border.all(color: Theme.of(context).focusColor.withOpacity(0.4)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: ColorsCollectionsDark.lightblueColor.withOpacity(0.2)
                                )
                              ]
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height:size.height*0.07,
                                  width: size.width*0.18,
                                  //   color: Colors.red,
                                  child: Image.asset("assets/images/refferral.png",)
                              ),
                              Text( "Total Reffrral",
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .indicatorColor.withOpacity(0.8),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,),),
                              Text('0',style: TextStyle(
                                fontSize: 10,color: Theme.of(context).textTheme
                                  .headline2
                                  ?.color,fontWeight: FontWeight.w400,),)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8,),

                      Container(
                        height:size.height*0.15,
                        width: size.width,
                        margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                        decoration: BoxDecoration(
                            color: Theme.of(context).hintColor,
                            borderRadius: BorderRadius.circular(2),
                            border:Border.all(color: Theme.of(context).focusColor.withOpacity(0.4)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: ColorsCollectionsDark.lightblueColor.withOpacity(0.2)
                              )
                            ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height:size.height*0.07,
                                width: size.width*0.18,
                                //   color: Colors.red,
                                child: Image.asset("assets/images/totalrewards.png",)
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text( "Total Rewards",
                                  style: TextStyle(color: Theme
                                      .of(context)
                                      .indicatorColor.withOpacity(0.8),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,),),
                                SizedBox(width: 2,),
                                Icon(Icons.error_outline,size: 14,color: Theme
                                    .of(context)
                                    .indicatorColor.withOpacity(0.8),)
                              ],
                            ),
                            Text('0',style: TextStyle(
                              fontSize: 10,color: Theme.of(context).textTheme
                                .headline2
                                ?.color,fontWeight: FontWeight.w400,),)
                          ],
                        ),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        height:size.height*0.15,
                        width: size.width,
                        margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                        decoration: BoxDecoration(
                            color: Theme.of(context).hintColor,
                            borderRadius: BorderRadius.circular(2),
                            border:Border.all(color: Theme.of(context).focusColor.withOpacity(0.4)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: ColorsCollectionsDark.lightblueColor.withOpacity(0.2)
                              )
                            ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height:size.height*0.07,
                                width: size.width*0.18,
                                //   color: Colors.red,
                                child: Image.asset("assets/images/rate3.png",)
                            ),
                            Text( "Total Reward Rate",
                              style: TextStyle(color: Theme
                                  .of(context)
                                  .indicatorColor.withOpacity(0.8),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,),),
                            Text('50 %',style: TextStyle(
                              fontSize: 10,color: Theme.of(context).textTheme
                                .headline2
                                ?.color,fontWeight: FontWeight.w400,),)
                          ],
                        ),
                      ),

                      SizedBox(height: 45,),
                      Padding(
                        padding: EdgeInsets.only(left: 10,right: 10),
                        child: Center(
                          child: Text('Shared ypur link & earn more!',style: TextStyle(
                            fontSize: 12,color: Theme.of(context).indicatorColor,
                            fontWeight: FontWeight.w400,letterSpacing: 0.1,),),
                        ),
                      ),
                      SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height:size.height*0.07,
                              width: size.width*0.14,
                              //   color: Colors.red,
                              child: Image.asset("assets/images/facebook.png",)
                          ),
                          Container(
                              height:size.height*0.07,
                              width: size.width*0.14,
                              //   color: Colors.red,
                              child: Image.asset("assets/images/instagram.png",)
                          ),
                          Container(
                              height:size.height*0.07,
                              width: size.width*0.14,
                              //   color: Colors.red,
                              child: Image.asset("assets/images/linkedin.png",)
                          ),
                          Container(
                              height:size.height*0.07,
                              width: size.width*0.14,
                              //   color: Colors.red,
                              child: Image.asset("assets/images/youtube.png",)
                          ),
                          Container(
                              height:size.height*0.07,
                              width: size.width*0.14,
                              //   color: Colors.red,
                              child: Image.asset("assets/images/twitter.png",)
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ),
          )
        ],
      ),
    );

  }


}





