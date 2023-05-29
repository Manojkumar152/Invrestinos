import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:investions/Screen/P2P/P2Pbuy_sell.dart';

import 'Dialog/ConfirmDeleteWidget.dart';

class CLaimCouponsWidget extends StatefulWidget {
  static const id = 'CLaimCouponsWidget';

  @override
  State<CLaimCouponsWidget> createState() => _CLaimCouponsWidgetState();
}

class _CLaimCouponsWidgetState extends State<CLaimCouponsWidget> {
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
                      Text("Claim Coupons",style: TextStyle(color: Colors.white),)
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
                                    height: size.height*0.33,
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
                                          padding:  EdgeInsets.only(left: 10.0,right: 10.0),
                                          child: Text( "Claim Your Coupon Rewards On Investinos ",
                                            style: TextStyle(color: Theme
                                                .of(context)
                                                .textTheme
                                                .headline2
                                                ?.color,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,),),
                                        ),
                                       SizedBox(height: 10,),
                                       DottedLine(dashColor: Theme.of(context).indicatorColor.withOpacity(0.6),),
                                        SizedBox(height: 10,),
                                        Padding(
                                          padding:  EdgeInsets.only(left:10.0,right: 10.0),
                                          child: Text( "Enter Your Coupon code Perform Thw Required Activity to Claim Your Rewards ",
                                            style: TextStyle(color: Theme
                                                .of(context)
                                                .indicatorColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,),),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left:10.0,right: 10.0,top: 10.0),
                                          child: Text( "Enter A Coupon Code ",
                                            style: TextStyle(color: Theme
                                                .of(context)
                                                .textTheme
                                                .headline2
                                                ?.color,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,),),
                                        ),
                                        SizedBox(height: 6,),
                                        Padding(
                                          padding:  EdgeInsets.only(left:10.0,right: 10.0,top: 10.0),
                                          child: Text( "Enter Code ",
                                            style: TextStyle(color: Theme
                                                .of(context)
                                                .textTheme
                                                .headline2
                                                ?.color,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,),),
                                        ),
                                        SizedBox(height: 14),
                                    InkWell(
                                      onTap: (){
                                     //   ConfirmDeleteWidget
                                        showDialog(context: context, builder: (BuildContext context)=>ConfirmDeleteWidget());
                                      },
                                      child: Center(
                                        child: Container(
                                          height: size.height*0.035,
                                          width: size.width/3.5,
                                          //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(3),),
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
                                            child: Text( "Apply ",
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
