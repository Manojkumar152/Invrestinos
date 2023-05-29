import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:investions/Api/ApiCollections.dart';
import 'package:investions/Api/ApiMain.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:investions/Constant/ToastClass.dart';
import 'package:investions/Screen/P2P/P2Pbuy_sell.dart';

import 'Dialog/ConfirmDeleteWidget.dart';
import 'Setting/FeeSettingsWidget.dart';

class DownloadTradeReportWidget extends StatefulWidget {
  static const id = 'DownloadTradeReportWidget';

  @override
  State<DownloadTradeReportWidget> createState() =>_DownloadTradeReportWidgetState();
}

class _DownloadTradeReportWidgetState extends State<DownloadTradeReportWidget> {
  bool click=false;


  Future<void> RequestTrade()async{
    final paramDic={
      "":""
    };
    try{
      var response=await LBMAPIMainClass(ApiCollections.tradingreport, paramDic, "Get");
      var data=jsonDecode(response.body);
      if(data["status_code"] == "1"){
        setState(() {
          click=false;
        });
        Navigator.of(context).pop();
        ToastShowClass.toastShow(context,data["message"], Colors.blue);
      }else{
        setState(() {
          click=false;
        });
        ToastShowClass.toastShow(context,data["message"], Colors.blue);
      }
    }catch(e){
      setState(() {
        click=false;
      });
      ToastShowClass.toastShow(context,e.toString(), Colors.red);
    }
  }

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
                      Text("Download Trade Report",style: TextStyle(color: Colors.white),)
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
                                    height: size.height*0.5,
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
                                          child: Text( "Get Your Trade Report On Your Email.",
                                            style: TextStyle(color: Theme
                                                .of(context)
                                                .textTheme
                                                .headline2
                                                ?.color,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,),),
                                        ),

                                       SizedBox(height: 10,),
                                       DottedLine(dashColor: Theme.of(context).indicatorColor.withOpacity(0.6),),
                                        SizedBox(height: 20,),
                                        Padding(
                                          padding:  EdgeInsets.only(left:20.0,right: 10.0),
                                          child: Text( "Current Month ",
                                            style: TextStyle(color: Theme
                                                .of(context)
                                                .textTheme
                                                .headline2
                                                ?.color,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,),),
                                        ),
                                        SizedBox(height: 10,),
                                        // Center(
                                        //   child: Container(
                                        //     height: size.height*0.048,
                                        //     margin: EdgeInsets.only(left: 20,right: 2),
                                        //     //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                        //     decoration: BoxDecoration(
                                        //       borderRadius: BorderRadius.all(Radius.circular(4),),
                                        //       gradient: LinearGradient(
                                        //         colors: [Theme
                                        //             .of(context)
                                        //             .indicatorColor.withOpacity(0.6),
                                        //           Theme
                                        //               .of(context)
                                        //               .indicatorColor.withOpacity(0.6)
                                        //         ],
                                        //       ),
                                        //     ),
                                        //     child: Center(
                                        //       child: Row(
                                        //         mainAxisAlignment: MainAxisAlignment.end,
                                        //         children: [
                                        //           Container(
                                        //               height: 30,
                                        //               width: 30,
                                        //               margin: EdgeInsets.only(right: 2),
                                        //               child: Icon(Icons.keyboard_arrow_down_outlined,size: 20,))
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        // Padding(
                                        //   padding:  EdgeInsets.only(left:20.0,right: 10.0,top:16.0),
                                        //   child: Text( "From 01 April 2022 to 15 April,2022 ",
                                        //     style: TextStyle(color: Theme
                                        //         .of(context)
                                        //         .indicatorColor,
                                        //       fontSize: 10,
                                        //       fontWeight: FontWeight.w600,),),
                                        // ),
                                        Padding(
                                          padding:  EdgeInsets.only(left:20.0,right: 10.0,top:10.0),
                                          child: Text( "The Report Will Include ",
                                            style: TextStyle(color: Theme
                                                .of(context)
                                                .textTheme
                                                .headline2
                                                ?.color,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,),),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left:20.0,right: 10.0,top:8.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 13,
                                                height: 0.7,
                                                color: Theme.of(context).focusColor,
                                              ),
                                              SizedBox(width: 10,),
                                              Text( "Exchange Trades ",
                                                style: TextStyle(color: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline2
                                                    ?.color,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w400,),),
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding:  EdgeInsets.only(left:20.0,right: 10.0,top:6.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 13,
                                                height: 0.7,
                                                color: Theme.of(context).focusColor,
                                              ),
                                              SizedBox(width: 10,),
                                              Text( "P2P Trades ",
                                                style: TextStyle(color: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline2
                                                    ?.color,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w400,),),
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding:  EdgeInsets.only(left:20.0,right: 10.0,top:6.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 13,
                                                height: 0.7,
                                                color: Theme.of(context).focusColor,
                                              ),
                                              SizedBox(width: 10,),
                                              Text( "STF Trades ",
                                                style: TextStyle(color: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline2
                                                    ?.color,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w400,),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left:20.0,right: 10.0,top:6.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 13,
                                                height: 0.7,
                                                color: Theme.of(context).focusColor,
                                              ),
                                              SizedBox(width: 10,),
                                              Text( "Current Coin Balance ",
                                                style: TextStyle(color: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline2
                                                    ?.color,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w400,),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left:20.0,right: 10.0,top:6.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 13,
                                                height: 0.7,
                                                color: Theme.of(context).focusColor,
                                              ),
                                              SizedBox(width: 10,),
                                              Text( "Deposite And Withdrawals ",
                                                style: TextStyle(color: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline2
                                                    ?.color,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w400,),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left:20.0,right: 10.0,top:6.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 13,
                                                height: 0.7,
                                                color: Theme.of(context).focusColor,
                                              ),
                                              SizedBox(width: 10,),
                                              Text( "Ledger History ",
                                                style: TextStyle(color: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline2
                                                    ?.color,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w400,),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left:20.0,right: 10.0,top:6.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 13,
                                                height: 0.7,
                                                color: Theme.of(context).focusColor,
                                              ),
                                              SizedBox(width: 10,),
                                              Text( "Airdrops And Other Distributes ",
                                                style: TextStyle(color: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline2
                                                    ?.color,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w400,),),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 28),
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          click=true;
                                        });
                                        RequestTrade();
                                     //   ConfirmDeleteWidget
                                      },
                                      child: Center(
                                        child: Container(
                                          height: size.height*0.045,
                                          margin: EdgeInsets.only(left: 70,right: 70),
                                          //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(4),),
                                            gradient: LinearGradient(
                                              colors: [Theme
                                                  .of(context)
                                                  .focusColor,
                                                Theme
                                                    .of(context)
                                                    .focusColor
                                              ],
                                            ),
                                          ),
                                          child: Center(
                                            child:click?SizedBox(height: 15,width: 15,child: CircularProgressIndicator(color: Colors.white),): Text( "   Request Trading Report    ",
                                              style: TextStyle(color: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .headline1
                                                  ?.color,
                                                fontSize: 8,
                                                fontWeight: FontWeight.w600,),),
                                          ),
                                        ),
                                      ),
                                    ),
                                      ],
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
