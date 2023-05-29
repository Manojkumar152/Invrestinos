import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:getwidget/components/radio_list_tile/gf_radio_list_tile.dart';
import 'package:provider/provider.dart';

import '../../Constant/SharedPreferenceClass.dart';
import '../../Constant/Themedata.dart';
import '../MarketWidget.dart';
import '../Exchange/USDTWidget.dart';

class WalletWidget extends StatefulWidget {
   static const id = 'WalletWidget';
  @override
  _WalletWidgetState createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> with SingleTickerProviderStateMixin {


  List<CustomList> activityList = [
    CustomList("1", "Date:", '15th April 2022,15:08:49','132.167.987.89','Change 2FA Attempt'),
    CustomList("2", "Date:", '15th April 2022,15:08:49','132.167.987.89','Change 2FA Attempt'),
    CustomList("3", "Date:", '15th April 2022,15:08:49','132.167.987.89','Change 2FA Attempt'),
    CustomList("4", "Date:", '15th April 2022,15:08:49','132.167.987.89','Change 2FA Attempt'),
    CustomList("4", "Date:", '15th April 2022,15:08:49','132.167.987.89','Change 2FA Attempt'),
    CustomList("4", "Date:", '15th April 2022,15:08:49','132.167.987.89','Change 2FA Attempt'),
    CustomList("4", "Date:", '15th April 2022,15:08:49','132.167.987.89','Change 2FA Attempt'),
    CustomList("4", "Date:", '15th April 2022,15:08:49','132.167.987.89','Change 2FA Attempt'),
    CustomList("4", "Date:", '15th April 2022,15:08:49','132.167.987.89','Change 2FA Attempt'),

  ];
  late TabController _tabController;
  int ind = 0;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync:this);
    _tabController.addListener(() {
      setState(() {
        ind = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,

      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Container(
              height: size.height * 0.367,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/dashboard_headerImage.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding:  EdgeInsets.only(top:40.0,left: 23),
                child: Column(
                  children: [
                    Align(
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
                          Text("BTS Wallet",style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                    Text("GNO Wallet",
                        style: TextStyle(color: Theme
                            .of(context)
                            .textTheme
                            .headline1
                            ?.color,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2)),
                    SizedBox(height: 6,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.currency_rupee,size: 12,),
                        Text("0",
                            style: TextStyle(color: Theme
                                .of(context)
                                .textTheme
                                .headline1
                                ?.color,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.2)),
                      ],
                    ),
                    SizedBox(height: 6,),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height*0.245, left: 16.0, right: 16.0),
              child: Card(
                elevation: 10,
                // color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left:8.0,right: 8.0,top: 16),
                        child: Container(
                          height: size.height*0.099,
                          width:size.width*0.9,
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text( "AVAILABLE",
                                        style: TextStyle(color: Theme
                                            .of(context)
                                            .indicatorColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,),),
                                    ),
                                    Container(
                                      child: Text("0 BTS",
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text( "IN ORDER",
                                        style: TextStyle(color: Theme
                                            .of(context)
                                            .indicatorColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,),),
                                    ),
                                    Container(
                                      child: Text("0 BTS",
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
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24,),
                      Padding(
                        padding:  EdgeInsets.only(left:8.0,right: 8.0),
                        child: Container(
                          height: size.height * 0.050,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Theme.of(context).textTheme.headline4?.color,
                            //color: Colors.grey.shade300,
                            //border: Border.all(color: Colors.grey.shade700),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: TabBar(
                            physics: BouncingScrollPhysics(),
                            controller: _tabController,
                            isScrollable: true,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Theme.of(context).focusColor),
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor:Colors.white,
                            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            unselectedLabelStyle: TextStyle(
                              fontSize: 12,
                           ),
                            unselectedLabelColor:Theme.of(context).indicatorColor,
                            tabs: [
                              SizedBox(
                                width: size.width * 0.37,
                                child: Text(
                                  'Transactions',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                width:size.width * 0.39,
                                child: Text(
                                  'Markets',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: size.height*0.64,
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .cardColor
                                .withOpacity(0.9),
                            borderRadius: BorderRadius.circular(5)),
                        child: TabBarView(
                          physics: BouncingScrollPhysics(),
                          controller: _tabController,
                          children: [
                            Container(
                                height: size.height*0.75,
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
                                child: ActivityLogIsEmpty(context,size),
                                // ListView.builder(
                                //     padding: EdgeInsets.only(top: 8),
                                //     itemCount: 1,
                                //     shrinkWrap: true,
                                //     primary: false,
                                //     itemBuilder: (BuildContext context, int index) {
                                //       return ActivityLogIsEmpty(context, index,size);
                                //     })

                            ),
                            MarketWidget(),

                          ],
                        ),
                      )



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
    return Column(
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
                            child: Text( activityList[i].DateName,
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
                            child: Text(activityList[i].Date,
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
                            child: Text( activityList[i].IPAddress,
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
                            child: Text( activityList[i].Activity,
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
    );

  }
  Widget ActivityLogIsEmpty(BuildContext context,Size size) {
    return Center(
      child: Text( "YOU DO NOT HAVE BAL DEPOSITE/"+"\n"+"WITHDRWAL TRANSACTIONS!",
        style: TextStyle(color: Theme
            .of(context)
            .indicatorColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,),),
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

