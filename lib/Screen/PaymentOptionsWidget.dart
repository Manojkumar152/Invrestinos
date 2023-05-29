import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:investions/Screen/P2P/P2Pbuy_sell.dart';

import 'Dialog/ConfirmDeleteWidget.dart';
import 'DownloadTradeReportWidget.dart';

class PaymentOptionsWidget extends StatefulWidget {
  static const id = 'PaymentOptionsWidget';

  @override
  State<PaymentOptionsWidget> createState() =>_PaymentOptionsWidgetState();
}

class _PaymentOptionsWidgetState extends State<PaymentOptionsWidget> {
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
                      Text("Payment Options",style: TextStyle(color: Colors.white),)
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
                      borderRadius: BorderRadius.circular(8)),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 9,),
                        Row(
                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height:size.height*0.10,
                              width: size.width*0.22,
                              margin: EdgeInsets.only(left: 6,right: 6,top: 4),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).hintColor,
                                  borderRadius: BorderRadius.circular(2),

                              ),
                              child: InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, PaymentOptionsWidget.id);
                                },
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        height:size.height*0.06,
                                        width: size.width*0.18,
                                        //   color: Colors.red,
                                        child: Image.asset("assets/images/submit.png",)
                                    ),
                                    Center(
                                      child: Text('Submit',style: TextStyle(
                                        fontSize: 8,color: Theme.of(context).indicatorColor.withOpacity(1),fontWeight: FontWeight.w600,letterSpacing: 0.1,),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                height:size.height*0.01,
                                width: size.width*0.06,
                                //   color: Colors.red,
                                child: Image.asset("assets/images/blueline.png",)
                            ),
                            Container(
                              height:size.height*0.10,
                              width: size.width*0.22,
                              margin: EdgeInsets.only(left: 6,right: 6,top: 4),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).hintColor,
                                  borderRadius: BorderRadius.circular(2),

                              ),
                              child: InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, PaymentOptionsWidget.id);
                                },
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        height:size.height*0.06,
                                        width: size.width*0.18,
                                        //   color: Colors.red,
                                        child: Image.asset("assets/images/review.png",)
                                    ),
                                    Center(
                                      child: Text('Review',style: TextStyle(
                                        fontSize: 8,color: Theme.of(context).indicatorColor.withOpacity(1),fontWeight: FontWeight.w600,letterSpacing: 0.1,),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                height:size.height*0.01,
                                width: size.width*0.06,
                                //   color: Colors.red,
                                child: Image.asset("assets/images/blueline.png",)
                            ),
                            Container(
                              height:size.height*0.10,
                              width: size.width*0.22,
                              margin: EdgeInsets.only(left: 6,right: 6,top: 4),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).hintColor,
                                  borderRadius: BorderRadius.circular(2),
                                  border:Border.all(color: Theme.of(context).focusColor.withOpacity(0.2)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: ColorsCollectionsDark.lightblueColor.withOpacity(0.2)
                                    )
                                  ]
                              ),
                              child: InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, PaymentOptionsWidget.id);
                                },
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        height:size.height*0.06,
                                        width: size.width*0.18,
                                        //   color: Colors.red,
                                        child: Image.asset("assets/images/done.png",)
                                    ),
                                    Center(
                                      child: Text('Done',style: TextStyle(
                                        fontSize: 8,color: Theme.of(context).indicatorColor.withOpacity(1),fontWeight: FontWeight.w600,letterSpacing: 0.1,),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: size.height,
                          width: size.width,
                          padding: EdgeInsets.only(top:2,bottom:4,),
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
                                    height: size.height*0.62,
                                    //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).hintColor,
                                      borderRadius: BorderRadius.all(Radius.circular(3),),
                                        border:Border.all(color: Theme.of(context).focusColor.withOpacity(0.2)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: ColorsCollectionsDark.lightblueColor.withOpacity(0.2)
                                          )
                                        ]
                                    ),
                                    child:  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10,),
                                        Padding(
                                          padding:  EdgeInsets.only(left: 10.0,right: 10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text( "Please Complete Your Kyc",
                                                style: TextStyle(color: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline2
                                                    ?.color,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,),),
                                            ],
                                          ),
                                        ),
                                           SizedBox(height: 3,),
                                        Padding(
                                          padding:  EdgeInsets.only(left:10.0,right: 10.0),
                                          child: Text( "You haven't complete your kyc will be approved instantly \n"
                                              " if your documents are clearly visible,and your \n informations is correct.",
                                            style: TextStyle(color: Theme
                                                .of(context)
                                                .indicatorColor,
                                              fontSize: 8,
                                              fontWeight: FontWeight.w600,),),
                                        ),

                                        SizedBox(height: 26,),
                                        Center(
                                          child: Container(
                                            height: size.height*0.048,
                                            margin: EdgeInsets.only(left: 10,right: 10),
                                            //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(3),),
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
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: Text( "Here's What You Can Do: ",
                                                      style: TextStyle(color: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .headline1
                                                          ?.color,
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w600,),),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(height: 30,),
                                        Padding(
                                          padding:  EdgeInsets.only(left:10.0,right: 40.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text( "Deposite Crypto",
                                                style: TextStyle(color: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline2
                                                    ?.color,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w600,),),
                                              Container(
                                                width: size.width*0.4,
                                                child: DottedLine(
                                                     dashColor: Theme.of(context).indicatorColor.withOpacity(0.6),),
                                              ),
                                              Icon(Icons.check_circle,size: 14,color: Theme.of(context).shadowColor,),

                                            ],
                                          ),
                                        ),

                                        SizedBox(height: 10,),
                                        Padding(
                                          padding:  EdgeInsets.only(left:10.0,right: 40.0),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text( "Trade",
                                                style: TextStyle(color: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline2
                                                    ?.color,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w600,),),
                                              Container(
                                                width: size.width*0.53,
                                                child: DottedLine(
                                                  dashColor: Theme.of(context).indicatorColor.withOpacity(0.6),),
                                              ),
                                              Icon(Icons.check_circle,size: 14,color: Theme.of(context).shadowColor,),

                                            ],
                                          ),
                                        ),

                                        SizedBox(height: 10,),
                                        Padding(
                                          padding:  EdgeInsets.only(left:10.0,right: 40.0),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text( "Deposite INR",
                                                style: TextStyle(color: Theme
                                                    .of(context)
                                                    .indicatorColor,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w600,),),
                                              SizedBox(width: 6,),
                                              Container(
                                                width: size.width*0.466,
                                                child: DottedLine(
                                                  dashColor: Theme.of(context).indicatorColor.withOpacity(0.6),),
                                              ),
                                              SizedBox(width: 6,),
                                              Icon(Icons.cancel,size: 14,color: Theme.of(context).indicatorColor,),

                                            ],
                                          ),
                                        ),

                                        SizedBox(height: 10,),
                                        Padding(
                                          padding:  EdgeInsets.only(left:10.0,right: 40.0),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text( "Withdraw",
                                                style: TextStyle(color: Theme
                                                    .of(context)
                                                    .indicatorColor,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w600,),),
                                              SizedBox(width: 6,),
                                              Container(
                                                width: size.width*0.489,
                                                child: DottedLine(
                                                  dashColor: Theme.of(context).indicatorColor.withOpacity(0.6),),
                                              ),
                                              SizedBox(width: 6,),
                                              Icon(Icons.cancel,size: 14,color: Theme.of(context).indicatorColor,),

                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 60,),
                                    InkWell(
                                      onTap: (){
                                     //   ConfirmDeleteWidget
                                     //  Navigator.pushNamed(context, DownloadTradeReportWidget.id);
                                      },
                                      child: Center(
                                        child: Container(
                                          height: size.height*0.038,
                                          margin: EdgeInsets.only(left: 80,right: 80),
                                          //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(3),),
                                            gradient: LinearGradient(
                                              colors: [Theme
                                                  .of(context)
                                                  .focusColor.withOpacity(0.9),
                                                Theme
                                                    .of(context)
                                                    .focusColor
                                              ],
                                            ),
                                          ),
                                          child: Center(
                                            child: Text( "SUBMIT KYC ",
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
