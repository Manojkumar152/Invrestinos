
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:investions/Api/ApiCollections.dart';
import 'package:investions/Api/ApiMain.dart';
import 'package:investions/Screen/Dialog/ChangePassword.dart';
import 'package:investions/Screen/Setting/AboutUsWidget.dart';
import 'package:investions/Screen/Setting/ActivityLogsWidget.dart';
import 'package:investions/Screen/Setting/AppearanceWidget.dart';
import 'package:investions/Screen/DownloadTradeReportWidget.dart';
import 'package:investions/Screen/Setting/FeeSettingsWidget.dart';
import 'package:investions/Screen/Dialog/FollowUsOnWidget.dart';
import 'package:investions/Screen/Setting/HelpAndSupportWidget.dart';
import 'package:investions/Screen/InviteAndEarnWidget.dart';
import 'package:investions/Screen/Setting/NotificationsWidget.dart';
import 'package:investions/Screen/Dialog/PleaseConfirmWidget.dart';
import 'package:investions/Screen/Setting/SecurityWidget.dart';
import 'package:investions/Screen/Setting/TradeSettingWidget.dart';

import '../../Constant/SharePerferarance.dart';
import '../Account/VerifyAccountWidget2.dart';
import '../Exchange/ExchangesWidget.dart';
import '../Credential Screen/ForgotPassword.dart';
import 'LanguageWidget.dart';
import '../Credential Screen/LoginWidget.dart';
import '../Account/VerifyAccountWidget.dart';


class SettingWidget extends StatefulWidget {
  static const id = 'SettingWidget';

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  String? name,Email,phonenumber,status;

  List<PopularCoinsList> popularList = [
    PopularCoinsList("assets/images/account.png", "KYC Setting","", Icon(Icons.arrow_forward_ios_outlined),),
    PopularCoinsList("assets/images/bank.png", "Banking & Payment Options","", Icon(Icons.arrow_forward_ios_outlined),),
    PopularCoinsList("assets/images/about_us.png", "Change Password","", Icon(Icons.arrow_forward_ios_outlined),),
    PopularCoinsList("assets/images/security.png", "Two Factor Authentication","", Icon(Icons.arrow_forward_ios_outlined),),
    PopularCoinsList("assets/images/fee_setting.png", "Fee Setting","", Icon(Icons.arrow_forward_ios_outlined),),
    PopularCoinsList("assets/images/activity.png", "Activity Logs","", Icon(Icons.arrow_forward_ios_outlined),),
 //   PopularCoinsList("assets/images/trade_setting.png", "Trade Settings","", Icon(Icons.arrow_forward_ios_outlined),),
    PopularCoinsList("assets/images/download.png", "Download Trade Report","", Icon(Icons.arrow_forward_ios_outlined),),
//    PopularCoinsList("assets/images/bell.png", "Notifications","", Icon(Icons.arrow_forward_ios_outlined),),
 //   PopularCoinsList("assets/images/language.png", "Language","", Icon(Icons.arrow_forward_ios_outlined),),
   // PopularCoinsList("assets/images/enable.png", "Enable Widget","", Icon(Icons.arrow_forward_ios_outlined),),
   // PopularCoinsList("assets/images/conver_crypto.png", "Convert Crypto Dust","", Icon(Icons.arrow_forward_ios_outlined),),
    //PopularCoinsList("assets/images/contest.png", "Contest","", Icon(Icons.arrow_forward_ios_outlined),),
    //PopularCoinsList("assets/images/follow_us.png", "Follow Us","", Icon(Icons.arrow_forward_ios_outlined),),
    //PopularCoinsList("assets/images/rate.png", "Rate Us","assets/images/star.png", Icon(Icons.arrow_forward_ios_outlined),),
    //PopularCoinsList("assets/images/fees.png", "Fees","", Icon(Icons.arrow_forward_ios_outlined),),
    PopularCoinsList("assets/images/support.png", "Help & Support","", Icon(Icons.arrow_forward_ios_outlined),),
    PopularCoinsList("assets/images/appearance.png", "Appearance","", Icon(Icons.arrow_forward_ios_outlined),),
    //PopularCoinsList("assets/images/about_us.png", "About Us","", Icon(Icons.arrow_forward_ios_outlined),),
    PopularCoinsList("assets/images/logout.png", "Logout","", Icon(Icons.arrow_forward_ios_outlined),),
  ];


  getShared()async{
    name=await SharedPreferenceClass.GetSharedData("name");
    Email=await SharedPreferenceClass.GetSharedData("email");
    setState(() {
      name=name;
      Email=Email;
    });
  }
  @override
  void initState() {
    getShared();
    getdata();
    super.initState();
  }
Future<void> getdata()async{
    final paramDic={
      "":""
    };
    var response=await APIMainClassbinance(ApiCollections.getuser, paramDic,"Get");
    var data=jsonDecode(response.body);
    print(data.toString());
    if(data["status_code"]=="1"){
      setState(() {
        name=data["data"]["name"].toString();
        Email=data["data"]["email"].toString();
        phonenumber=data["data"]["mobile"].toString();
        status=data["data"]["status"].toString();
      });
    }else{
      print("Eroor");
    }
}
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
        body:SingleChildScrollView(
          primary: true,
          child: Stack(
            children: [
              Container(
                height: size.height*0.324,
                width: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/dashboard_headerImage.png'),
                    fit: BoxFit.fill,

                  ),

                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: size.height * 0.11,
                      width: size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/dashboard_headerImage.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:42.0,left: 13),
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
                              Text(" Settings",style: TextStyle(color: Colors.white),)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left:28.0,right: 28.0,top: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Name",
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .textTheme
                                    .headline1
                                    ?.color, fontSize: 10),),
                                  Text(name.toString(),
                                  style: TextStyle(color: Theme
                                  .of(context)
                                  .textTheme
                                  .headline1
                                  ?.color, fontSize: 10),),


                            ],
                          ),
                          SizedBox(height: 4,),
                          Container(height: 1, color: Theme
                              .of(context)
                              .indicatorColor,),
                        ],
                      ),
                    ),
                    SizedBox(height: 12,),
                    Padding(
                      padding:  EdgeInsets.only(left:28.0,right: 28.0,),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Email",
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .textTheme
                                    .headline1
                                    ?.color, fontSize: 10),),
                              Text(Email.toString(),
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .textTheme
                                    .headline1
                                    ?.color, fontSize: 10),),
                            ],
                          ),
                          SizedBox(height: 4,),
                          Container(height: 1, color: Theme
                              .of(context)
                              .indicatorColor,),
                        ],
                      ),
                    ),
                    SizedBox(height: 12,),
                    Padding(
                      padding:  EdgeInsets.only(left:28.0,right: 28.0,),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Mobile Number",
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .textTheme
                                    .headline1
                                    ?.color, fontSize: 10),),
                              Text("72832****54",
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .textTheme
                                    .headline1
                                    ?.color, fontSize: 10),),
                            ],
                          ),
                          SizedBox(height: 4,),
                          Container(height: 1, color: Theme.of(context).indicatorColor,),
                        ],
                      ),
                    ),
                    SizedBox(height: 12,),
                    Padding(
                      padding:  EdgeInsets.only(left:28.0,right: 28.0,),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Status",
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .textTheme
                                    .headline1
                                    ?.color, fontSize: 10),),
                              Text(status.toString()=="true"?"Active":"Non-Active",
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .textTheme
                                    .headline1
                                    ?.color, fontSize: 10),),
                            ],
                          ),
                          SizedBox(height: 4,),
                          Container(height: 1, color: Theme
                              .of(context)
                              .indicatorColor,),
                        ],
                      ),
                    ),
                    SizedBox(height: 14,),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height*.2899, left: 16.0, right: 16.0),
                child: Card(
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                      // bottomLeft: Radius.circular(0),
                      // bottomRight: Radius.circular(0),
                    ),),
                  child: Column(
                    children: [
                      Container(
                        width: size.width,
                        decoration: BoxDecoration(
                          //  color: Theme.of(context).buttonColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                          // gradient: LinearGradient(
                          //   colors: [Theme
                          //       .of(context)
                          //       .hintColor, Theme
                          //       .of(context)
                          //       .hintColor
                          //   ],
                          // ),

                        ),
                  ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0, right: 10.0,top: 10.0,bottom: 6.0),
                                child: Text("Other Settings-",textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Theme
                                        .of(context)
                                        .textTheme
                                        .headline2
                                        ?.color),),
                              ),
                            ),
                            ListView.builder(
                                padding: EdgeInsets.only(top: 2),
                                itemCount: popularList.length,
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (BuildContext context, int index) {
                                  return DashboardList(context, index,size);
                                }),

                      Container(
                        height: 2,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }

  Widget DashboardList(BuildContext context,int index,Size size) {
    return Column(
      children: [
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 6,bottom: 0),
          decoration: BoxDecoration(

            borderRadius: BorderRadius.all(Radius.circular(0),),
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
          child: Padding(
            padding: EdgeInsets.only(left: 10.0, right: 8.0),
            child: InkWell(
              onTap: (){
                print("--------"+index.toString());
                 if(index==0){
                   Navigator.pushNamed(context, VerifyAccountWidget2.id);
                  //Navigator.pushNamed(context, VerifyAccountWidget.id);
                } else if(index==2){
                 showDialog(context: context, builder:(BuildContext context){
                   return ChangePasswordDailog();
                 });
                }else if(index==3){
                   Navigator.pushNamed(context, SecurityWidget.id);
                } else if(index==5){
                  Navigator.pushNamed(context, ActivityLogsWidget.id);
                } else if(index==1){
                   Navigator.pushNamed(context,"/BankDetail");
                 } else if(index==4){
                  Navigator.pushNamed(context, FeeSettingsWidget.id);
                } else if(index==6){
                  Navigator.pushNamed(context, DownloadTradeReportWidget.id);
                } else if(index==8){
                  Navigator.pushNamed(context, AppearanceWidget.id);
                } else if(index==7){
                  Navigator.pushNamed(context, HelpAndSupportWidget.id);
                } else if(index==9){
                   showDialog(context: context, builder: (BuildContext context)=>PleaseConfirmWidget());
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height:24,
                        width: 24,
                        child: Image.asset(popularList[index].image),
                      ),
                      SizedBox(width: 6,),
                      Text(popularList[index].Name, style: TextStyle(color: Theme
                          .of(context)
                          .selectedRowColor, fontWeight: FontWeight.w700, fontSize: 10),),
                      SizedBox(width: 6,),
                      popularList[index].image2==""?Container():popularList[index].image2=="assets/images/star.png"?
                      RatingBarIndicator(
                        rating: 3.50,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 4,
                        itemSize: 12.0,
                        direction: Axis.horizontal,
                      ): Container(
          height:24,
          width: 24,
          child: Image.asset(popularList[index].image2,color:Theme.of(context).toggleableActiveColor ,),
        ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_forward_ios_outlined,size: 14,color: Theme.of(context).toggleableActiveColor.withOpacity(1),),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
        //Container(height: 1, color: Theme.of(context).canvasColor,),
      ],
    );

  }
}


class PopularCoinsList{
  String image ;
  String Name;
  String image2;
  Icon icon;

  PopularCoinsList(this.image, this.Name,this.image2,
      this.icon,);
}

class BottomImageIcons{
  String imageIcon;
  String imageName;

  BottomImageIcons(this.imageIcon, this.imageName);

}



