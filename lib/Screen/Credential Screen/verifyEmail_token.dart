import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:investions/Api/ApiMain.dart';
import 'package:investions/Screen/P2P/P2Pbuy_sell.dart';
import 'package:investions/Screen/Quicky_buy.dart';

import 'package:http/http.dart' as http;

import '../../Api/ApiCollections.dart';
import '../../Constant/SharePerferarance.dart';
import '../../Constant/ToastClass.dart';

class Verify_tokenEmail extends StatefulWidget {
  String email;


  Verify_tokenEmail(this.email);

  @override
  State<Verify_tokenEmail> createState() => _Verify_tokenEmailState();
}

class _Verify_tokenEmailState extends State<Verify_tokenEmail> {
  TextEditingController code=TextEditingController();
  bool click=false;

  Future<void> _phoneverify() async {
    final paramDic={
      "token":code.text.toString(),
    };
    var response = await LBMAPIMainClass(ApiCollections.LBM_verify, paramDic,"Post");
    var data = json.decode(response.body);
    print(data.toString());
    if(data["status_code"]=="1") {
      setState(() {
        click=false;
      });
      SharedPreferenceClass.SetSharedData("token", data['data']['token']);
      SharedPreferenceClass.SetSharedData("id", data['data']['user']['id'].toString());
      SharedPreferenceClass.SetSharedData("name", data['data']['user']['name']);
      SharedPreferenceClass.SetSharedData("email", data['data']['user']['email']);
      SharedPreferenceClass.SetSharedData("profile_image", data['data']['user']['profile_image']);
      SharedPreferenceClass.SetSharedData("isLogin", "true");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Quick_buy(p2pdata(0,0))),);
      ToastShowClass.toastShow(context, "Verification done", Colors.blue);
    }
    else{
      setState(() {
        click=false;
      });
      ToastShowClass.toastShowerror(context, "Verification failed", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Email Authentication",style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 14,fontWeight: FontWeight.w600,),),
          SizedBox(height: 50,),
          Text("Enter code send on your Email",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 12,fontWeight: FontWeight.w400),),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16),
            child: TextFormField(
              controller: code,
              decoration: InputDecoration(
                enabledBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(4),
                ),
                focusedErrorBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(4),
                ),
                border:OutlineInputBorder(
                  borderSide:BorderSide(color: Theme.of(context).indicatorColor.withOpacity(0.6)),
                  borderRadius: BorderRadius.circular(4),
                ),
                fillColor:Theme.of(context).cardColor,
                filled: true,
                focusedBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(4),
                ),
                errorBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Colors.red.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(4),
                ) ,
                contentPadding: EdgeInsets.only(left: 10),
                hintText: "Enter Code",
                hintStyle: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600,fontSize: 10),
                errorStyle: TextStyle(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w300),
              ),
              style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 100,),
          GestureDetector(
            onTap: (){
              setState(() {
                click=true;
              });
              _phoneverify();
            },
            child: Container(
              width: 150,
              height: size.height * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color:Theme.of(context).hoverColor,

              ),
              child: Center(child:click?SizedBox(height: 15,width: 15,child:CircularProgressIndicator(color: Colors.white),):Text("Verify",style: TextStyle(fontSize:12,color: Colors.white,fontWeight: FontWeight.w500),)),
            ),
          ),
        ],
      ),
    );
  }
}
