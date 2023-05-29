
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:investions/Api/ApiCollections.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:investions/Constant/CommonClass.dart';
import 'package:investions/Constant/SharedPreferenceClass.dart';
import 'package:investions/Constant/ToastClass.dart';

import '../../Api/ApiMain.dart';
import '../P2P/P2Pbuy_sell.dart';
import '../Quicky_buy.dart';

class P2PCancelDialogWidget extends StatefulWidget {
 String? id;
 P2PCancelDialogWidget({this.id});

  @override
  State<P2PCancelDialogWidget> createState() => _P2PCancelDialogWidgetState();
}

class _P2PCancelDialogWidgetState extends State<P2PCancelDialogWidget> {


bool progressbar = true;
  @override
  void initState() {
    super.initState();
  }

  Future<void>p2pcancel_order()async{
    final paramDic = {
      "id": widget.id.toString(),
    };
    try{
      var response=await APIMainClass(ApiCollections.p2pcancel_order+widget.id.toString(), paramDic,"Post");
      var data=jsonDecode(response.body);
      if(data["status_code"]=="1"){
        setState(() {
          progressbar = true;
        });
        ToastShowClass.toastShow(context, data["message"], Colors.blue);
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, P2Pbuy_sell.id,arguments: p2pdata(3,3));
      }else{
        setState(() {
          progressbar = true;
        });
        ToastShowClass.toastShowerror(context, data["message"], Colors.red);
      }
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Dialog(
        elevation: 0.223,
        backgroundColor: Theme.of(context).hintColor,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Container(
            height: size.height*0.223,
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left:6.0,right: 6.0,top:10.0,bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:6),
                            child: Text("Cancel order ",style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 14,fontWeight: FontWeight.w600),),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.cancel,size: 22,),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.white,),
                    SizedBox(height: 14,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Are you sure to cancel your order?",
                          style: TextStyle(color: Theme
                              .of(context)
                              .textTheme.headline2?.color,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,),),
                      ],
                    ),
                    SizedBox(height: 24,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              progressbar = false;
                            });
                            p2pcancel_order();
                          },
                          child:progressbar==false?SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator()): Text("Yes",
                            style: TextStyle(color: Theme
                                .of(context)
                                .textTheme.headline2?.color,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,),),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text("No",
                            style: TextStyle(color: Theme
                                .of(context)
                                .textTheme.headline2?.color,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,),),
                        ),
                      ],
                    ),
                    // Container(height: 1, color: Theme
                    //     .of(context)
                    //     .canvasColor,)
                  ],
                )
              ),
    )
    );
  }
}
