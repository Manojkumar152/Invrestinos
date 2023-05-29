import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:investions/Api/ApiCollections.dart';
import 'package:investions/Api/ApiMain.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:investions/Constant/ToastClass.dart';
import 'package:investions/Screen/P2P/P2Pbuy_sell.dart';

import '../../Constant/SharePerferarance.dart';
import '../Credential Screen/LoginWidget.dart';
import 'ConfirmResetWidget.dart';
import '../Setting/SecurityWidget.dart';

class PleaseConfirmWidget extends StatefulWidget {
  static const id = 'PleaseConfirmWidget';

  @override
  State<PleaseConfirmWidget> createState() => _PleaseConfirmWidgetState();
}

class _PleaseConfirmWidgetState extends State<PleaseConfirmWidget> {
  bool logoutclick=false;
  bool clickAllOut=false;
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
                Container(
                  height: size.height*0.343,
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
                          width: size.width/3.2,
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
                            child: Text( "Please Confirm ",
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

                      SizedBox(height: 16,),
                      Center(
                        child: Padding(
                          padding:  EdgeInsets.only(left:10.0,right: 10.0),
                          child: Text( "Are You Sure You Want To \n Logout?",textAlign: TextAlign.center,
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
                         setState(() {
                           logoutclick=true;
                         });
                         Logout(ApiCollections.logout);
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
                              child:logoutclick?SizedBox(height: 15,width: 15,child: CircularProgressIndicator(color: Colors.white),): Text( "Logout From This Device ",
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
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              clickAllOut=true;
                            });
                            Logout(ApiCollections.hardlogout);
                          },
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
                              child:clickAllOut?SizedBox(height: 15,width: 15,child: CircularProgressIndicator(color: Colors.white),):Text( "Logout From All Device ",
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
                      ),

                      SizedBox(height: 16,),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context,true);
                        },
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
                      SizedBox(height: 10,),

                    ],
                  ),
                ),


              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> Logout(String url)async{
    final parammdic={
      "":"",
    };
    try{
      var response=await LBMAPIMainClass(url,parammdic,"Delete");
      var data=jsonDecode(response.body);
      if(data["status_code"]=="1"){
        SharedPreferenceClass.SetSharedData("isLogin","false");
        SharedPreferenceClass.SetSharedData("token","null");
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) =>LoginWidget()), (Route dynamic) => false);
        ToastShowClass.toastShow(context, "Logout", Colors.red);
        setState(() {
          logoutclick=false;
          clickAllOut=false;
        });
      }else{
        setState(() {
          logoutclick=false;
          clickAllOut=false;
        });
        ToastShowClass.toastShowerror(context, "Logout Error", Colors.red);
      }
    }catch(e){
      print(e.toString());
    }
  }
}
