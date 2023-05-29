import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:investions/Constant/Nodata.dart';
import 'package:investions/Screen/P2P/P2Pbuy_sell.dart';

import '../../Api/ApiCollections.dart';
import '../../Api/ApiMain.dart';
import '../../Constant/ToastClass.dart';
import '../CLaimCouponsWidget.dart';
import '../Dialog/P2PCancelDialogWidget.dart';
import '../Dialog/PeerTopeerCreateYour_xidWidgetDialog.dart';

class P2PMatchingDetails extends StatefulWidget {
  String id = '';
  P2PMatchingDetails({required this.id});

  @override
  State<P2PMatchingDetails> createState() => _P2PMatchingDetailsState();
}

class _P2PMatchingDetailsState extends State<P2PMatchingDetails> {


  List userdata = [];
  bool progrssbar = false;
  @override
  void initState() {
    getOrderDetails().whenComplete(() => getOrderShowMatching().whenComplete(() => getMatchingOrder()));
   // getOrderShowMatching();
   // getMatchingOrder();
    super.initState();
  }

  Future<void>getOrderDetails()async{
    final paramDic = {
      "": "",
    };
    try{
      var response=await APIMainClass(ApiCollections.p2pOrderDetails+widget.id.toString(), paramDic,"Get");
      var data=jsonDecode(response.body);
      userdata.clear();
      if(data["status_code"]=="1"){
        setState(() {
          progrssbar = true;
        });
        userdata.add(data['data']);
        log("message"+userdata.toString());
      }else{
        setState(() {
          progrssbar = true;
        });
        ToastShowClass.toastShowerror(context, data["message"], Colors.red);
      }
    }catch(e){
      print(e.toString());
    }
  }
  Future<void>getOrderShowMatching()async{
    final paramDic = {
      "": "",
    };
    try{
      var response=await APIMainClass(ApiCollections.p2pshow_matching+widget.id.toString(), paramDic,"Get");
      var data=jsonDecode(response.body);
      if(data["status_code"]=="1"){
        setState(() {
          progrssbar = true;
        });
      }else{
        setState(() {
          progrssbar = true;
        });
     //   ToastShowClass.toastShowerror(context, data["message"], Colors.red);
      }
    }catch(e){
      print(e.toString());
    }
  }
  Future<void>getMatchingOrder()async{
    final paramDic = {
      "": "",
    };
    try{
      var response=await APIMainClass(ApiCollections.p2pmatching_orders+widget.id.toString(), paramDic,"Get");
      var data=jsonDecode(response.body);
      if(data["status_code"]=="1"){
        setState(() {
          progrssbar = true;
        });
      }else{
        setState(() {
          progrssbar = true;
        });
      //  ToastShowClass.toastShowerror(context, data["message"], Colors.red);
      }
    }catch(e){
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        primary:false,
        child: Stack(
          children: [
            Container(
              height: size.height*0.4,
              width: size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/dashboard_headerImage.png'),
                    fit: BoxFit.fill,
                  )
              ),
              child:Padding(
                padding: EdgeInsets.only(top: size.height*0.07,left: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Icon(FontAwesomeIcons.arrowLeft,color:Colors.white,)),
                      SizedBox(width: 13,),
                      Text("Back",style: TextStyle(color:Colors.white,fontWeight: FontWeight.w500,fontSize: 13,letterSpacing: 0.1),)
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

                          child:progrssbar==false?Center(
                            child: SizedBox(
                              height: 20,
                                width: 20,
                                child: CircularProgressIndicator()),
                          ): Column(
                            children: [

                              InkWell(
                                onTap:(){

                                },
                                child: Padding(
                                  padding:  EdgeInsets.only(left:8.0,right:8.0,top:10,bottom: 2.0),
                                  child:
                                  Container(
                                    height: size.height*0.556,
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
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            height:30 ,
                                            margin: EdgeInsets.only(right: 10),
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
                                                borderRadius: BorderRadius.circular(4),
                                                border: Border.all(width: 0.5,color: Colors.redAccent)
                                            ),

                                            child: InkWell(
                                              onTap: (){
                                                showAnimatedDialog(
                                                    animationType: DialogTransitionType.slideFromBottom,
                                                    curve: Curves.easeOut,
                                                    barrierDismissible:true,
                                                    context: context, builder: (BuildContext context){
                                                  return P2PCancelDialogWidget(id:widget.id.toString(),);
                                                });
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text("CANCEL ORDER",textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Theme.of(context).textTheme.headline2?.color,
                                                        fontSize: 10.0,fontWeight: FontWeight.w600
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 60,),
                                        Text( "MATCHING WITH DIRECT",
                                          style: TextStyle(color: Theme
                                              .of(context)
                                              .textTheme
                                              .headline2
                                              ?.color,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,),),

                                        Text( userdata[0]['order_type'].toString()=="buy"?"Buyer's":"Seller",
                                          style: TextStyle(color: Theme
                                              .of(context)
                                              .textTheme
                                              .headline3
                                              ?.color,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,),),
                                        SizedBox(height: 0,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                          child: Divider(color: Theme
                                              .of(context)
                                              .indicatorColor,),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text( "We will email you whenyour order is matched. ",
                                              style: TextStyle(color: Theme
                                                  .of(context)
                                                  .textTheme.headline2?.color,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,),),
                                          ],
                                        ),
                                        SizedBox(height: 6,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(userdata[0]['order_type'].toString()+"order",
                                              style: TextStyle(color: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .headline2
                                                  ?.color,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,),),
                                            Text( userdata[0]['quantity'].toString() +userdata[0]['currency'] +"@"+"Price"+"'\u{20B9}'"+userdata[0]['price'].toString(),
                                              style: TextStyle(color: Theme
                                                  .of(context)
                                                  .indicatorColor,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,),),
                                          ],
                                        ),

                                        SizedBox(height: 12,),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                           SizedBox(
                                             height: 20,
                                             width: 20,
                                             child: CircularProgressIndicator(),
                                           )
                                          ],
                                        ),
                                        SizedBox(height: 12,),
                                        Text( "Time taken depends on current demand & you price. ",
                                          style: TextStyle(color: Theme
                                              .of(context)
                                              .textTheme
                                              .headline2
                                              ?.color,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,),),

                                        Text( "Placed on  "+DateFormat("dd-MMM-yyyy hh:mm:ss").format(DateTime.parse(userdata[0]['expires_at'].toString())),
                                          style: TextStyle(color: Theme
                                              .of(context)
                                              .textTheme
                                              .headline2
                                              ?.color,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,),),
                                        SizedBox(height: 10,),
                                        Text( "Order ID: "+userdata[0]['id'].toString(),
                                          style: TextStyle(color: Theme
                                              .of(context)
                                              .textTheme
                                              .headline2
                                              ?.color,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,),),
                                        SizedBox(height: 12,),


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
