import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:investions/Screen/P2P/P2Pbuy_sell.dart';

import 'ConfirmResetWidget.dart';

class ConfirmDeleteWidget extends StatefulWidget {
  static const id = 'ConfirmDeleteWidget';

  @override
  State<ConfirmDeleteWidget> createState() => _ConfirmDeleteWidgetState();
}

class _ConfirmDeleteWidgetState extends State<ConfirmDeleteWidget> {
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
                    height: size.height*0.3,
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
                          child: Container(
                            height: size.height*0.035,
                            width: size.width/3.5,
                            //  margin: EdgeInsets.only(top: 0,bottom: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(3),),
                              gradient: LinearGradient(
                                colors: [Theme
                                    .of(context)
                                    .cardColor.withOpacity(0.4),
                                  Theme
                                      .of(context)
                                      .cardColor.withOpacity(0.4)
                                ],
                              ),
                              border: Border.all(color:Theme
                                  .of(context)
                                  .hintColor.withOpacity(0.9),width: 1 )
                            ),
                            child: Center(
                              child: Text( "Confirm Delete ",
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .textTheme
                                    .headline2
                                    ?.color,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,),),
                            ),
                          ),
                        ),

                        SizedBox(height: 20,),
                        Center(
                          child: Padding(
                            padding:  EdgeInsets.only(left:10.0,right: 10.0),
                            child: Text( "Are You Sure You Want To Delete?",
                              style: TextStyle(color: Theme
                                  .of(context)
                                  .indicatorColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,),),
                          ),
                        ),

                        SizedBox(height: 24),
                        InkWell(
                          onTap: (){
                            showDialog(context: context, builder: (BuildContext context)=>ConfirmResetWidget());

                          },
                          child: Center(
                            child: Container(
                              height: size.height*0.045,
                              width: size.width,
                                margin: EdgeInsets.only(left: 20,right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(2),),
                                gradient: LinearGradient(
                                  colors: [Colors.redAccent,
                                    Colors.redAccent
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Text( "Delete ",
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
                        SizedBox(height: 10),
                        Center(
                          child: Container(
                            height: size.height*0.045,
                            width: size.width,
                            margin: EdgeInsets.only(left: 20,right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(2),),
                              gradient: LinearGradient(
                                colors: [Theme
                                    .of(context)
                                    .indicatorColor.withOpacity(0.5),
                                  Theme
                                      .of(context)
                                      .indicatorColor.withOpacity(0.5)
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text( "Cancel ",
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .textTheme
                                    .headline2
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
