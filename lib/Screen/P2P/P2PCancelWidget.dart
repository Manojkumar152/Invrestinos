import 'package:flutter/material.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:investions/Screen/P2P/P2Pbuy_sell.dart';

import '../CLaimCouponsWidget.dart';

class P2PCancelWidget extends StatefulWidget {
  static const id = 'P2PCancelWidget';

  @override
  State<P2PCancelWidget> createState() => _P2p_ScreenState();
}

class _P2p_ScreenState extends State<P2PCancelWidget> {
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
                      Text("Peer To Peer (P2P)",style: TextStyle(color: Colors.white),)
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
                                  padding:  EdgeInsets.only(left:8.0,right:8.0,top:30,bottom: 2.0),
                                  child:
                                  Container(
                                    height: size.height*0.2,
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
                                        Text( "Boy Order Closed ",
                                          style: TextStyle(color: Theme
                                              .of(context)
                                              .textTheme
                                              .headline2
                                              ?.color,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,),),
                                       SizedBox(height: 20,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text( "Completed ",
                                              style: TextStyle(color: Theme
                                                  .of(context)
                                                  .indicatorColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,),),
                                            Text( "0.00 USDT Of 14.50 USDT ",
                                              style: TextStyle(color: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .headline2
                                                  ?.color,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,),),
                                          ],
                                        ),
                                        SizedBox(height: 6,),
                                        Text( "Placed On Apr 6,2022,4:57:53 Pm ",
                                          style: TextStyle(color: Theme
                                              .of(context)
                                              .indicatorColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding:  EdgeInsets.only(left:8.0,right:8.0,top:14,bottom: 2.0),
                                child:
                                Container(
                                  height: size.height*0.367,
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

                                      InkWell(
                                        onTap: (){
                                          Navigator.pushNamed(context, CLaimCouponsWidget.id);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:8,right:8,top:18.0,bottom: 8.0),
                                          child: Icon(Icons.cancel,color: Colors.redAccent,size: 45,),
                                        ),
                                      ),

                                      Text( "Cancelled ",
                                        style: TextStyle(color: Theme
                                            .of(context)
                                            .textTheme
                                            .headline2
                                            ?.color,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,),),
                                      SizedBox(height: 4,),
                                      Text( "Seller Has Not Received The Payment ",
                                        style: TextStyle(color: Theme
                                            .of(context)
                                            .textTheme
                                            .headline2
                                            ?.color,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,),),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),
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
