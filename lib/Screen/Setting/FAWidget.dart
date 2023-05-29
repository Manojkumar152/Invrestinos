import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:investions/Api/ApiCollections.dart';
import 'package:investions/Api/ApiMain.dart';
import 'package:investions/Constant/ToastClass.dart';
class FAWidget extends StatefulWidget {
   static const id = '2FAWidget';
  @override
  _FAWidgetState createState() => _FAWidgetState();
}

class _FAWidgetState extends State<FAWidget> {

bool isCheckedwhite = false,isCheckDark = false,click=false;
int val = -1;
int groupValue2 = 2;
int groupValue3 = 3;
int? fA=-1,fetchvalue ;
 @override
  void initState() {
   get2FA();
    super.initState();
  }

  Future<void> get2FA()async{
   final paramDic={
     "":""
   };
   try{
     var response=await LBMAPIMainClass(ApiCollections.TwoFAuth, paramDic,"Get");
     var data=jsonDecode(response.body);
     print(data.toString());
     if(data["status_code"] == "1"){
         fA=data["data"]["_2fa"];
         if(fA==0){
           setState(() {
             val=2;
             fetchvalue=val;
           });
         }else if(fA==2){
           setState(() {
             val=1;
             fetchvalue=val;
           });
         }
     }else{
       print("error");
     }
   }catch(e){
     print(e.toString());
   }
  }

  Future<void>Update2FA(String fa)async{
   final paramDic={
     "two_factor":fa.toString(),
   };
   var response=await LBMAPIMainClass(ApiCollections.TwoFAuthUpdate, paramDic, "Post");
   var data=jsonDecode(response.body);
   if(data["status_code"] == "1"){
     setState(() {
       click=false;
     });
     ToastShowClass.toastShow(context,data["message"],Colors.red);
     Navigator.of(context).pop();
   }else{
     setState(() {
       click=false;
     });
     ToastShowClass.toastShow(context,data["message"],Colors.red);
   }
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                      Text("2FA",style: TextStyle(color: Colors.white),)
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
                            // Padding(
                            //   padding:  EdgeInsets.only(left:8.0,right:8.0,top:24,bottom: 2.0),
                            //   child:
                            //   Container(
                            //     height: size.height*0.0689,
                            //     width:size.width,
                            //     //  margin: EdgeInsets.only(top: 0,bottom: 6),
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.all(Radius.circular(2),),
                            //       gradient: LinearGradient(
                            //         colors: [Theme
                            //             .of(context)
                            //             .hintColor,
                            //           Theme
                            //               .of(context)
                            //               .hintColor
                            //         ],
                            //       ),
                            //     ),
                            //     child:  Padding(
                            //       padding:  EdgeInsets.only(left:20.0,right: 8.0),
                            //       child: Align(
                            //         alignment:Alignment.centerLeft,
                            //         child: Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             Column(
                            //               mainAxisAlignment: MainAxisAlignment.center,
                            //               crossAxisAlignment: CrossAxisAlignment.start,
                            //               children: [
                            //                 Row(
                            //                  // mainAxisAlignment: MainAxisAlignment.start,
                            //                   children: [
                            //                     Text( "Authenticator App ",
                            //                       style: TextStyle(color: Theme
                            //                           .of(context)
                            //                           .textTheme
                            //                           .headline2
                            //                           ?.color,
                            //                         fontSize: 12,
                            //                         fontWeight: FontWeight.w600,),),
                            //                     Text( "Recommended ",
                            //                       style: TextStyle(color: Theme
                            //                           .of(context).shadowColor,
                            //                         fontSize: 8,
                            //                         fontWeight: FontWeight.w500,),),
                            //
                            //
                            //                   ],
                            //                 ),
                            //                 Text( "Highly Secure ",
                            //                   textAlign: TextAlign.left,
                            //                   style: TextStyle(color: Theme.of(context).indicatorColor,
                            //                     fontSize: 8,
                            //                     fontWeight: FontWeight.w500,),),
                            //               ],
                            //             ),
                            //             Column(
                            //               mainAxisAlignment: MainAxisAlignment.center,
                            //               children: [
                            //                 Radio(
                            //                   value: 1,
                            //                   groupValue: val,
                            //                   onChanged: (value) {
                            //                     setState(() {
                            //                       val = int.parse(value.toString());
                            //                     });
                            //                   },
                            //                   activeColor: Colors.green,
                            //                 ),
                            //               ],
                            //             )
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Container(height: 1, color: Theme
                            //     .of(context)
                            //     .canvasColor,),

                            Padding(
                              padding:  EdgeInsets.only(left:8.0,right:8.0,top:8,bottom: 2.0),
                              child:
                              Container(
                                height: size.height*0.0689,
                                width:size.width,
                                //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(2),),
                                  gradient: LinearGradient(
                                    colors: [Theme
                                        .of(context)
                                        .hintColor,
                                      Theme
                                          .of(context)
                                          .hintColor
                                    ],
                                  ),
                                ),
                                child:  Padding(
                                  padding:  EdgeInsets.only(left:20.0,right: 8.0),
                                  child: Align(
                                    alignment:Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text( "Two Factor Authentical ",
                                                  style: TextStyle(color: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .headline2
                                                      ?.color,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,),),
                                              ],
                                            ),
                                            Text( "Moderately Secure ",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(color: Theme.of(context).indicatorColor,
                                                fontSize: 8,
                                                fontWeight: FontWeight.w500,),),
                                            Text( "@FA Enable on 89******05 ",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(color: Theme.of(context).indicatorColor,
                                                fontSize: 8,
                                                fontWeight: FontWeight.w500,),),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Radio(
                                              value: 1,
                                              groupValue: val,
                                              onChanged: (value) {
                                                setState(() {
                                                  val = int.parse(value.toString());
                                                });
                                              },
                                              activeColor: Colors.green,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Container(height: 1, color: Theme
                            //     .of(context)
                            //     .canvasColor,),

                            Padding(
                              padding:  EdgeInsets.only(left:8.0,right:8.0,top:8,bottom: 2.0),
                              child:
                              Container(
                                height: size.height*0.0689,
                                width:size.width,
                                //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(2),),
                                  gradient: LinearGradient(
                                    colors: [Theme
                                        .of(context)
                                        .hintColor,
                                      Theme
                                          .of(context)
                                          .hintColor
                                    ],
                                  ),
                                ),
                                child:  Padding(
                                  padding:  EdgeInsets.only(left:20.0,right: 8.0),
                                  child: Align(
                                    alignment:Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text( "None ",
                                              style: TextStyle(color: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .headline2
                                                  ?.color,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,),),
                                            Text( "Not Secure ",
                                              style: TextStyle(color: Theme
                                                  .of(context).shadowColor,
                                                fontSize: 8,
                                                fontWeight: FontWeight.w500,),),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [

                                            Radio(
                                              value:2,
                                              groupValue: val,
                                              onChanged: (value) {
                                                setState(() {
                                                  val = int.parse(value.toString());
                                                  //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>AboutUsWidget()));

                                                });
                                              },
                                              activeColor: Colors.green,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left:26.0,right: 8.0,top: size.height*0.0232),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text( "Note: ",
                                          style: TextStyle(color: Theme
                                              .of(context)
                                              .textTheme
                                              .headline2
                                              ?.color,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,),),
                                      ),
                                      Container(
                                        width: size.width*0.6,
                                        child: Text( "If You Change Your 2FA Setting,You will Be ",
                                          maxLines: 1,
                                          style: TextStyle(color: Theme.of(context).indicatorColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,),),
                                      ),

                                    ],
                                  ),
                                  Container(
                                    width: size.width*0.7,
                                    child: Text( "Be Unable To Withdraw Anything, And Place P2P Sell Orders For 24 Hours As Security Measure. ",
                                      style: TextStyle(color: Theme.of(context).indicatorColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,),),
                                  )
                                ],
                              ),
                            ),
                            val!=fetchvalue? GestureDetector(
                              onTap: (){
                                if(val==1){
                                  Update2FA("2");
                                }else{
                                  Update2FA("0");
                                }
                                setState(() {
                                  click=true;
                                });
                              },
                              child: Container(
                                height:40,
                                margin: EdgeInsets.only(top: size.height*0.1),
                                width: size.width*0.5,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Theme
                                          .of(context)
                                          .hoverColor.withOpacity(0.9),
                                        Theme
                                            .of(context)
                                            .hoverColor.withOpacity(0.9)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(2)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    click==true?SizedBox(height: 15,width: 15,child: CircularProgressIndicator(color: Colors.white),):Text("Update",textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Theme.of(context).textTheme.headline1?.color,
                                          fontSize: 11.0,fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ):Container(),
                          ],
                        ),
                      ),


                    ],
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );

  }
}

class CustomList {
  String id;
  String Name;

  CustomList(this.id ,this.Name);
}

