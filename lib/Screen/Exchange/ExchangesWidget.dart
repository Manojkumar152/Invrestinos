import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:investions/Api/MarketPageProvider.dart';
import 'package:investions/Constant/CommonClass.dart';
import 'package:investions/Screen/P2P/P2P.dart';
import 'package:investions/Screen/P2P/p2p_BuySell_New.dart';
import 'package:investions/Screen/Setting/SettingWidget.dart';
import 'package:provider/provider.dart';
import '../../Constant/SharePerferarance.dart';
import '../../Constant/ToastClass.dart';
import '../CurrencyPerference.dart';
import 'package:http/http.dart' as http;
import 'USDTWidget.dart';
import 'Favriate.dart';

class ExchangesWidget extends StatefulWidget {
  static const id = "ExchangeWidget";

  @override
  _ExchangesWidgetState createState() => _ExchangesWidgetState();
}

class _ExchangesWidgetState extends State<ExchangesWidget>  with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<tabs> allCoinlist=[];
  String? login;
  @override
  void initState() {
    getShared();
    _tabController = TabController(
      length: CommonClass.allCoinlist.length,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        _tabController.index=_tabController.index;
      });
    });
    super.initState();
  }
  getShared()async{
    login=await SharedPreferenceClass.GetSharedData("isLogin");
    setState(() {
      login=login;
    });
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
              height: size.height*0.35,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/dashboard_headerImage.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 50, left: 12.0, right: 12.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size.width*0.5,
                        //color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap:(){
                                if(login.toString() == "true") {
                                  Navigator.pushNamed(context, SettingWidget.id);
                                }else{
                                  ToastShowClass.toastShowerror(context,"You are not Login.Please login..", Colors.red);
                                }
                             },
                              child: Icon(Icons.manage_accounts_rounded, color: Theme
                                  .of(context)
                                  .textTheme
                                  .headline1
                                  ?.color, size: 25,),
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/investinosName.png')
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // GestureDetector(
                          //   onTap: (){
                          //    // getdata();
                          //   },
                          //   child: Icon(FontAwesomeIcons.search, color: Theme
                          //       .of(context)
                          //       .textTheme
                          //       .headline1
                          //       ?.color, size: 20,),
                          // ),
                          SizedBox(width: 10,),
                          GestureDetector(
                            onTap: (){
                             //  if(login.toString() == "true") {
                             //    Navigator.pushNamed(context, Currency_Perference.id);
                             //  }else{
                             //    ToastShowClass.toastShow(context,"You are not Login.Please login..", Colors.red);
                             //  }
                              Provider.of<market>(context,listen: false).SocketStop();
                            },
                            child: Icon(FontAwesomeIcons.indianRupeeSign, color: Theme
                                .of(context)
                                .textTheme
                                .headline1
                                ?.color, size: 20,),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height*0.2, left: 16.0, right: 16.0),
              child: Container(
                height: size.height*0.75,
                child: Card(
                  elevation: 10,
                  //color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.070,
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
                              colors: [Theme.of(context).hintColor, Theme.of(context).hintColor
                              ],
                            ),
                          ),
                          child: Padding(
                            padding:  EdgeInsets.only(top:6.0,bottom: 6.0,left: 4),
                            child: TabBar(
                              automaticIndicatorColorAdjustment: true,
                              //  physics: BouncingScrollPhysics(),
                                controller: _tabController,
                                indicatorPadding: EdgeInsets.only(right:size.width*0.02),
                                labelPadding: EdgeInsets.only(right:size.width*0.02),
                                isScrollable: true,
                               indicator: BoxDecoration(
                                     borderRadius: BorderRadius.circular(2),
                               //     color: Theme.of(context).focusColor
                               ),
                                indicatorSize: TabBarIndicatorSize.tab,
                                labelColor: Colors.white,
                                padding: EdgeInsets.zero,
                                labelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                unselectedLabelStyle: TextStyle(fontSize: 12,),
                                unselectedLabelColor: Colors.grey,
                                tabs: List.generate(CommonClass.allCoinlist.length, (index) {
                                  return GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        _tabController.index=index;
                                      });
                                    },
                                    child: Container(
                                      height: 34,
                                      width: 45,
                                      decoration:  BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          color: _tabController.index == index?Theme.of(context).focusColor:Theme.of(context).dividerColor),
                                      child: Center(child: CommonClass.allCoinlist[index].name.toString()=="star"?Icon(Icons.star,color: Colors.amberAccent,size:20,):Text(
                                        CommonClass.allCoinlist[index].name.toString(),style: TextStyle(fontSize: 10,color: _tabController.index == index?Colors.white:Colors.white60,fontWeight: FontWeight.w600),)),
                                    ),
                                  );
                                })
                            ),
                          ),
                        ),
                        SizedBox(height: 2,),
                        Container(
                          height: size.height*0.64,
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(5)),
                          child: TabBarView(
                            physics: BouncingScrollPhysics(),
                            controller: _tabController,
                            children: List.generate(CommonClass.allCoinlist.length, (index){
                              if(index == 0){
                                return favorite();
                              }if(CommonClass.allCoinlist.length-1==index){
                                return P2p_Screen();
                              }
                              return USDTWidget(tabs(CommonClass.allCoinlist[index].name,CommonClass.allCoinlist[index].cointdata,CommonClass.allCoinlist[index].ticketlist));
                            }),
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

  }
}
 class TabNames{
  String tabName;
  TabNames(this.tabName);
}
class tabs{
  String? name;
  List<CoinsData> cointdata=[];
  List ticketlist=[];
  tabs(this.name, this.cointdata,this.ticketlist);
}