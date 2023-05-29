import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:investions/Screen/P2P/P2Pbuy_sell.dart';

import '../Setting/HelpAndSupportWidget.dart';
import '../P2P/P2PContinueToPay.dart';

class FollowUsOnWidget extends StatefulWidget {
  static const id = 'FollowUsOnWidget';

  @override
  State<FollowUsOnWidget> createState() => _FollowUsOnWidgetState();
}

class _FollowUsOnWidgetState extends State<FollowUsOnWidget> {
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Dialog(
      elevation: 1,
      backgroundColor: Theme
          .of(context)
          .cardColor.withOpacity(0.9),
      child: SingleChildScrollView(
        primary:false,
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Column(
              children: [
                InkWell(
                  onTap:(){
                  },
                  child: Container(
                    height: size.height*0.34,
                    //  margin: EdgeInsets.only(top: 0,bottom: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6),),
                      gradient: LinearGradient(
                        colors: [Theme
                            .of(context)
                            .hintColor.withOpacity(0.4),
                          Theme
                              .of(context)
                              .hintColor.withOpacity(0.4)
                        ],
                      ),
                      border: Border.all(color:Theme
                          .of(context)
                          .indicatorColor.withOpacity(0.4))
                    ),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Center(
                          child: Center(
                            child: Text( "Follow Us On ",
                              style: TextStyle(color: Theme
                                  .of(context)
                                  .textTheme
                                  .headline2
                                  ?.color,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,),),
                          ),
                        ),
                        SizedBox(height: 24),
                        InkWell(
                          onTap: (){

                          },
                          child: Center(
                            child: Container(
                              height: size.height*0.045,
                              width: size.width,
                              margin: EdgeInsets.only(left: 10,right: 10),
                              decoration: BoxDecoration(
                                color: Color(0Xff2086D6),
                                borderRadius: BorderRadius.all(Radius.circular(2),),
                                gradient: LinearGradient(
                                  colors: [Theme.of(context).focusColor.withOpacity(0.9),
                                    Theme.of(context).focusColor.withOpacity(0.9)
                                  ],
                                ),
                                // boxShadow: <BoxShadow>[
                                //  BoxShadow(
                                //      color: Colors.white,
                                //      offset: Offset(4,4),
                                //  )
                              //  ]
                              ),
                              child: Center(
                                child: Text( "Twitter ",
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
                        SizedBox(height: 20),
                        Center(
                          child: Container(
                            height: size.height*0.045,
                            width: size.width,
                            margin: EdgeInsets.only(left: 10,right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(2),),
                              gradient: LinearGradient(
                                colors: [Theme
                                    .of(context)
                                    .focusColor.withOpacity(0.9),
                                  Theme.of(context).focusColor.withOpacity(0.9)
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text( "Telegram ",
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
                        SizedBox(height: 20),
                        Center(
                          child: Container(
                            height: size.height*0.045,
                            width: size.width,
                            margin: EdgeInsets.only(left: 10,right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(2),),
                              gradient: LinearGradient(
                                colors: [Theme
                                    .of(context)
                                    .buttonColor.withOpacity(0.9),
                                  Theme.of(context).buttonColor.withOpacity(0.9)
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text( "Medium ",
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
                      ],
                    ),
                  ),
                ),


              ],
            )
          ],
        ),
      ),
    );
  }
}
