
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:investions/Api/ApiCollections.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:investions/Constant/CommonClass.dart';
import 'package:investions/Constant/Nodata.dart';
import 'package:investions/Constant/SharedPreferenceClass.dart';
import 'package:investions/Constant/ToastClass.dart';

import '../../Api/ApiMain.dart';
import '../P2P/P2Pbuy_sell.dart';
import '../Quicky_buy.dart';

class PeerToPeerOrderDetails extends StatefulWidget {
  String? id;

  PeerToPeerOrderDetails({this.id,required});

  @override
  State<PeerToPeerOrderDetails> createState() => _PeerToPeerOrderDetailsState();
}

class _PeerToPeerOrderDetailsState extends State<PeerToPeerOrderDetails> {
  TextEditingController limitPriceController = TextEditingController();
  TextEditingController RupeesController = TextEditingController();
  TextEditingController CryptoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var payableAmount;
  bool isLimit = true,limitpadding=false,quantitypadding=false,cryptopadding=false,click=false;
  String currencyName = '';
  String currencyShortName = '';
  String currencyImage = '';
  String currencyPrice = '';
  String currencyFamily = '';
  String currencyPair = '',Balance='0',Dacimalpair='';
  String Name = '';
  List userdata=[];
  bool progrssbar = false;
  @override
  void initState() {
    print("========="+widget.id.toString());
    getOrderDetails().whenComplete(() =>getbuyOrderDetails(userdata[0]['user_xid'].toString()));
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
      }
    }catch(e){
      print(e.toString());
    }
  }

  Future<void>getbuyOrderDetails(String id)async{
    final paramDic = {
      "": "",
    };
    try{
      var response=await APIMainClass(ApiCollections.p2pbuyerDetails+widget.id.toString()+"/"+id, paramDic,"Get");
      var data=jsonDecode(response.body);
      if(data["status_code"]=="1"){
        setState(() {
          progrssbar = true;
        });
        log("message-----"+data.toString());

        Name =data['data']['name'];
      }else{
        setState(() {
          progrssbar = true;
        });
        Name = data['message'];
      }
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Dialog(
        elevation: 0.5,
        backgroundColor: Theme.of(context).hintColor,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Container(
            height: size.height*0.5,
            width: size.width,
            decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(6.0),),
            gradient: LinearGradient(
            colors: [Theme.of(context).hintColor, Theme.of(context).hintColor
            ],
              ),
              border: Border.all(width: 1,color: Theme.of(context).indicatorColor.withOpacity(0.6))
              ),
              child: progrssbar==false?SizedBox(
                height: 30,
                width: 20,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ):userdata[0]['status'].toString()=="cancelled"?Nodata2(Name):SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.only(left:6.0,right: 6.0,top:4.0,bottom: 8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back,size: 20,color: Theme.of(context).textTheme.headline2?.color,),
                            ),
                            SizedBox(width: 6,),
                            Text("Back ",
                              style: TextStyle(color: Theme
                                  .of(context)
                                  .indicatorColor.withOpacity(1),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(userdata[0]['order_type'].toString() + userdata[0]['currency'].toString(),
                              style: TextStyle(color: Theme
                                  .of(context)
                                  .textTheme
                                  .headline2
                                  ?.color,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,),),
                            SizedBox(width: 2,),
                            Container(
                                height:size.height*0.06,
                                width: size.width*0.10,
                                 //  color: Colors.red,
                                child: Image.asset("assets/images/p2p1.png",)
                            ),

                          ],
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          //  margin: EdgeInsets.only(top: 0,bottom: 6),
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Fiat Amount",
                                        style: TextStyle(color: Theme
                                            .of(context)
                                            .textTheme
                                            .headline2
                                            ?.color,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,),),
                                      Text('\u{20B9} '+userdata[0]['total_price'].toString(),
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

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8,),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          //  margin: EdgeInsets.only(top: 0,bottom: 6),
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Price",
                                        style: TextStyle(color: Theme
                                            .of(context)
                                            .textTheme
                                            .headline2
                                            ?.color,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,),),
                                      Text('\u{20B9} '+userdata[0]['price'].toString(),
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

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8,),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          //  margin: EdgeInsets.only(top: 0,bottom: 6),
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Crypto Amount",
                                        style: TextStyle(color: Theme
                                            .of(context)
                                            .textTheme
                                            .headline2
                                            ?.color,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,),),
                                      Text(userdata[0]['quantity'].toString() + userdata[0]['currency'].toString(),
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

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8,),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          //  margin: EdgeInsets.only(top: 0,bottom: 6),
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Status",
                                        style: TextStyle(color: Theme
                                            .of(context)
                                            .textTheme
                                            .headline2
                                            ?.color,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,),),
                                      Text(userdata[0]['status'].toString(),
                                        style: TextStyle(color: Theme
                                            .of(context)
                                            .textTheme
                                            .headline2
                                            ?.color,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,),),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8,),
                          Divider(color: Theme.of(context).indicatorColor,height: 0.5,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          //  margin: EdgeInsets.only(top: 0,bottom: 6),
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Order Number",
                                        style: TextStyle(color: Theme
                                            .of(context)
                                            .textTheme
                                            .headline2
                                            ?.color,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,),),
                                      Text(userdata[0]['id'].toString(),
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

                              ],
                            ),
                          ),
                        ),

                    SizedBox(height: 8,),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    //  margin: EdgeInsets.only(top: 0,bottom: 6),
                    child: Padding(
                      padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Created Time",
                                  style: TextStyle(color: Theme
                                      .of(context)
                                      .textTheme
                                      .headline2
                                      ?.color,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,),),
                                Text(DateFormat().format(DateTime.parse(userdata[0]['expires_at'].toString())),
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

                        ],
                      ),
                    ),
                  ),
                        SizedBox(height: 8,),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          //  margin: EdgeInsets.only(top: 0,bottom: 6),
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Buyer Nickname",
                                        style: TextStyle(color: Theme
                                            .of(context)
                                            .textTheme
                                            .headline2
                                            ?.color,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,),),
                                      Text(Name,
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

                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                )
              ),
    )
    );
  }
}
