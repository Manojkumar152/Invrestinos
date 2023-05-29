import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:getwidget/components/radio_list_tile/gf_radio_list_tile.dart';
import 'package:investions/Api/ApiCollections.dart';
import 'package:investions/Api/ApiMain.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:provider/provider.dart';

import '../../Constant/SharedPreferenceClass.dart';
import '../../Constant/Themedata.dart';
import '../Wallet/WalletWidget.dart';

class ActivityLogsWidget extends StatefulWidget {
   static const id = 'ActivityLogsWidget';
  @override
  _ActivityLogsWidgetState createState() => _ActivityLogsWidgetState();
}

class _ActivityLogsWidgetState extends State<ActivityLogsWidget> {
  List ActiveLogdata=[];
  bool loading=true;
  List<CustomList> activityList = [
    CustomList("1", "Date:", '15th April 2022,15:08:49','132.167.987.89','Change 2FA Attempt'),
    CustomList("2", "Date:", '15th April 2022,15:08:49','132.167.987.89','Change 2FA Attempt'),
    CustomList("3", "Date:", '15th April 2022,15:08:49','132.167.987.89','Change 2FA Attempt'),
    CustomList("4", "Date:", '15th April 2022,15:08:49','132.167.987.89','Change 2FA Attempt'),

  ];
 @override
  void initState() {
   getLog("1");
    super.initState();
  }
  Future<void> getLog(String page)async{
   final paramDic={
     "page":page.toString(),
   };
   try{
     var response=await LBMAPIMainClass(ApiCollections.logGet, paramDic,"Get");
     var data=jsonDecode(response.body);
     if(data["status_code"] == "1"){
       ActiveLogdata.clear();
      setState(() {
        ActiveLogdata=data["data"]["data"];
        loading=false;
      });
     }else{
       setState(() {
         loading=false;
       });
     }
   }catch(e){
     setState(() {
       loading=false;
     });
   }
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,

      body: SingleChildScrollView(
        // primary:false,
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
                      Text("Activity Logs",style: TextStyle(color: Colors.white),)
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
                        child:  loading?Center(child: CircularProgressIndicator(color: ColorsCollectionsDark.greenlightColor),):ListView.builder(
                            padding: EdgeInsets.only(top: 8),
                            itemCount: ActiveLogdata.length,
                           // physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (BuildContext context, int index) {
                              return ActivityLogList(context, index,size);
                            })

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
  Widget ActivityLogList(BuildContext context, int i,Size size) {
    return InkWell(
      onTap: (){
      },
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(left:8.0,right:8.0,top:10,bottom: 2.0),
            child:
            Column(
              children: [
                Container(
                  height: size.height*0.146,
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
                    padding:  EdgeInsets.only(left:10.0,right: 6.0,top:4.0,bottom: 2.0),
                    child: Column(
                      children: [
                        SizedBox(height: 6,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width:50,
                              child: Text("Date",
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .indicatorColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,),),
                            ),
                            SizedBox(width: 1,),
                            Container(height:0.5,
                              width: size.width*0.270,
                              color: Theme
                                  .of(context)
                                  .indicatorColor,),
                            Spacer(),
                            Container(
                              width: size.width*0.343,
                              child: Text(ActiveLogdata[i]["created_at"].toString(),
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .textTheme
                                    .headline2
                                    ?.color,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,),),
                            ),

                          ],
                        ),
                        SizedBox(height: 6,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width:50,
                              child: Text( "IP:",
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .indicatorColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,),),
                            ),
                            SizedBox(width: 1,),
                            Container(height:0.5,
                              width: size.width*0.270,
                              color: Theme
                                  .of(context)
                                  .indicatorColor,),
                            Spacer(),
                            Container(
                              width: size.width*0.343,
                              child: Text( ActiveLogdata[i]["ip"].toString(),
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .textTheme
                                    .headline2
                                    ?.color,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,),),
                            ),

                          ],
                        ),
                        SizedBox(height: 16,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width:50,
                              child: Text( "Activity:",
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .indicatorColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,),),
                            ),
                            SizedBox(width: 1,),
                            Container(height:0.5,
                              width: size.width*0.270,
                              color: Theme
                                  .of(context)
                                  .indicatorColor,),
                            Spacer(),
                            Container(
                              width: size.width*0.343,
                              child: Text( ActiveLogdata[i]["type"].toString(),
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .focusColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,),),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
          Container(height: 1, color: Theme
              .of(context)
              .canvasColor,),

        ],
      ),
    );

  }
}



class CustomList {
  String id;
  String DateName;
  String  Date;
  String  IPAddress;
  String Activity;

  CustomList(this.id ,this.DateName,this.Date,this.IPAddress,this.Activity);
}

