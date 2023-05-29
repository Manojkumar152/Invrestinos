import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:investions/Screen/P2P/P2Pbuy_sell.dart';

import '../CLaimCouponsWidget.dart';
import '../Dialog/PeerTopeerCreateYour_xidWidgetDialog.dart';

class P2PSellerMatchedMakePayment extends StatefulWidget {
  static const id = 'P2PSellerMatchedMakeaPyment';

  @override
  State<P2PSellerMatchedMakePayment> createState() => _P2PSellerMatchedMakePaymentState();
}

class _P2PSellerMatchedMakePaymentState extends State<P2PSellerMatchedMakePayment> {
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        primary:false,
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
                      Text("Peer To Peer (P2P)",style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height*0.145, left: 16.0, right: 16.0),
              child: Card(
                  elevation: 0,
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
                                  padding:  EdgeInsets.only(left:8.0,right:8.0,top:10,bottom: 2.0),
                                  child:
                                  Container(
                                    height: size.height*0.256,
                                    //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(3),),
                                      gradient: LinearGradient(
                                        colors: [Theme
                                            .of(context)
                                            .hintColor,
                                          Theme
                                              .of(context)
                                              .hintColor
                                        ],
                                      ),
                                      border: Border.all(width: 0.5,color: Theme.of(context).focusColor)
                                    ),
                                    child:  Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text( "Seller Matched ",
                                          style: TextStyle(color: Theme
                                              .of(context)
                                              .textTheme
                                              .headline2
                                              ?.color,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,),),

                                        Text( "Make Payment! ",
                                          style: TextStyle(color: Theme
                                              .of(context)
                                              .textTheme
                                              .headline2
                                              ?.color,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,),),
                                        SizedBox(height: 20,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text( "Completed ",
                                              style: TextStyle(color: Theme
                                                  .of(context)
                                                  .indicatorColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,),),
                                            Text( "0.00 USDT Of 14.50 USDT ",
                                              style: TextStyle(color: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .headline2
                                                  ?.color,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,),),
                                          ],
                                        ),
                                        SizedBox(height: 6,),
                                        Text( "Placed On Apr 6,2022,4:57:53 Pm ",
                                          style: TextStyle(color: Theme
                                              .of(context)
                                              .indicatorColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,),),

                                        SizedBox(height: 12,),

                                        Container(
                                          height:20 ,
                                          width: size.width*0.3,
                                          decoration: BoxDecoration(

                                              gradient: LinearGradient(
                                                colors: [Theme
                                                    .of(context)
                                                    .hintColor,
                                                  Theme.of(context)
                                                      .hintColor
                                                ],
                                              ),
                                              borderRadius: BorderRadius.circular(1),
                                              border: Border.all(width: 0.5,color: Colors.redAccent)
                                          ),

                                          child: InkWell(
                                            onTap: (){

                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("CANCEL ORDER",textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.redAccent,
                                                      fontSize: 8.0,fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding:  EdgeInsets.only(left:8.0,right:8.0,top:14,bottom: 2.0),
                                child:
                                Container(
                                  height: size.height*0.567,
                                  //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(3),),
                                      gradient: LinearGradient(
                                        colors: [Theme
                                            .of(context)
                                            .hintColor,
                                          Theme
                                              .of(context)
                                              .hintColor
                                        ],
                                      ),
                                      border: Border.all(width: 0.5,color: Theme.of(context).focusColor)
                                  ),
                                  child:  Column(
                                    //crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: size.height*0.110,
                                        width: MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.fromLTRB(10, 14, 10, 10),
                                        //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(2),),
                                          gradient: LinearGradient(
                                            colors: [Theme
                                                .of(context)
                                                .indicatorColor.withOpacity(0.6),
                                              Theme
                                                  .of(context)
                                                  .indicatorColor.withOpacity(0.6)
                                            ],
                                          ),

                                        ),
                                        child:  Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text( "Payment ",
                                                  style: TextStyle(color: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .headline2
                                                      ?.color,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,),),
                                                Text( "# 1 GFor 14.50 USDT ",
                                                  style: TextStyle(color: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .headline2
                                                      ?.color,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,),),
                                              ],
                                            ),
                                            SizedBox(height: 4,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text( "March On Apr 6,2022,4:59:59Pm ",
                                                  style: TextStyle(color: Theme
                                                      .of(context)
                                                      .indicatorColor,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,),),

                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding:  EdgeInsets.only(left:14,right: 10.0,top: 8.0,bottom: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                               Image.asset("assets/images/wall_clock.png",height: 42,width: 42,)
                                              ],
                                            ),
                                            SizedBox(width: 10,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text( "Select Payment Mode Within ",
                                                  style: TextStyle(color: Theme
                                                      .of(context)
                                                      .indicatorColor,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,),),
                                                Text( "9 Mins,43 Secs ",
                                                  style: TextStyle(color: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .headline2
                                                      ?.color,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,),),

                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 4,),
                                      GFProgressBar(
                                        percentage: 0.03,
                                        lineHeight: 10,
                                        type: GFProgressType.linear,
                                        circleWidth:5,
                                        //radius: 10,
                                        padding: EdgeInsets.zero,
                                        progressHeadType: GFProgressHeadType.circular,
                                        backgroundColor : Colors.white,
                                        progressBarColor: Colors.red,
                                        alignment: MainAxisAlignment.center,
                                        width: size.width*0.45,
                                      ),




                                      Container(
                                        height: size.height*0.244,
                                        width: MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.fromLTRB(10, 18, 10, 10),
                                        //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(2),),
                                          gradient: LinearGradient(
                                            colors: [Theme
                                                .of(context)
                                                .indicatorColor.withOpacity(0.6),
                                              Theme
                                                  .of(context)
                                                  .indicatorColor.withOpacity(0.6)
                                            ],
                                          ),

                                        ),
                                        child:  Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 6.0,),
                                            Text( "Pay Exactly ",
                                              style: TextStyle(color: Theme
                                                  .of(context)
                                                  .indicatorColor,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,),),
                                            SizedBox(height: 6.0,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text( "RS 1,142.60 ",
                                                  style: TextStyle(color: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .headline2
                                                      ?.color,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,),),

                                              ],
                                            ),
                                            SizedBox(height: 6.0,),
                                            Text( "(Do Not Round Off!) ",
                                              style: TextStyle(color: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .headline2
                                                  ?.color,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,),),
                                            SizedBox(height: 10.0,),
                                            Text( "Pay With ",
                                              style: TextStyle(color: Theme
                                                  .of(context)
                                                  .indicatorColor,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,),),
                                            SizedBox(height: 4,),
                                           Image.asset("assets/images/IMPS_new_logo.png"),
                                            SizedBox(height: 6.0,),
                                          ],
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 16,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text( "Order Id: ",
                                    style: TextStyle(color: Theme
                                        .of(context)
                                        .textTheme
                                        .headline2
                                        ?.color,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,),),
                                  Text( "Dle2Bcd-0886-4b9d-9a5f-5029c88e588a ",
                                    style: TextStyle(color: Theme
                                        .of(context)
                                        .textTheme
                                        .headline2
                                        ?.color,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,),),
                                ],
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
