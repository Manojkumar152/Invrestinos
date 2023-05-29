import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:investions/Api/Provideclass.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:investions/Constant/MarketDeath_Moadal.dart';
import 'package:investions/Constant/Themedata.dart';
import 'package:investions/Screen/P2P/PeerToPeer_trade.dart';
import 'package:provider/provider.dart';

import '../../Constant/Nodata.dart';


class PeertoPeer_OrderBook extends StatefulWidget {
  static const id = 'PeertoPeer_OrderBook';

  @override
  State<PeertoPeer_OrderBook> createState() => _PeertoPeer_OrderBookState();
}

class _PeertoPeer_OrderBookState extends State<PeertoPeer_OrderBook>with TickerProviderStateMixin {
  late TabController _tabController;
  late TabController _tabController2;
  late TabController _tabController3;
  int ind = 0;
  int ind2=0;
  static NumberFormat Crone = NumberFormat("###0.0", "en_US");
  static NumberFormat Cr = new NumberFormat("###0.0000", "en_US");

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync:this);
    _tabController.addListener(() {
      setState(() {
        ind = _tabController.index;
      });
    });
    _tabController2 = TabController(length: 2, vsync:this);
    _tabController2.addListener(() {
      setState(() {
        ind2 = _tabController2.index;
      });
    }); _tabController3 = TabController(length: 2, vsync:this);
    _tabController3.addListener(() {
      setState(() {
        ind2 = _tabController3.index;
        print("dsfdsfdsfdsf"+ind2.toString());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var providerdata_list = Provider.of<providerdata>(context, listen: false);
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
                                Provider.of<providerdata>(context,listen: false).ScoketStop();
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back,color: Colors.white,)),
                          SizedBox(width: 10,),
                          Text("Peer to Peer (P2P)",style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                    // SizedBox(height: size.height*0.1,),
                  ],
                ),
              ),
            ),
            Card(
                margin:EdgeInsets.only(top: size.height*0.15, left: 16.0, right: 16.0),
                elevation: 10,
                color: Theme.of(context).cardColor,
                //color: Colors.green,
                shadowColor: Theme.of(context).backgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Container(
                    height: size.height,
                    child:SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:10,right: 6,top: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text("Order Book",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w400,fontSize: 12),),
                                    GestureDetector(
                                      onTap: (){
                                        //Navigator.pushNamed(context, PeerToPeer_MatchHistory.id);
                                      },
                                      child: Row(
                                        children: [
                                          Text(" (",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w400),),
                                          Text(" Read More ",style: TextStyle(color: ColorsCollectionsDark.greenlightColor,fontSize: 10,fontWeight: FontWeight.w400),),
                                          Icon(FontAwesomeIcons.arrowUpRightFromSquare,size: 11,color:ColorsCollectionsDark.greenlightColor ),
                                          Text(" )",style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w400),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  height: size.height * 0.04,
                                  width: size.width*0.38,
                                  margin: EdgeInsets.only(right: size.width*0.01,left: size.width*0.01),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).indicatorColor.withOpacity(0.2),
                                    //color: Colors.red,
                                    //border: Border.all(color: Colors.grey.shade700),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: TabBar(
                                    physics: BouncingScrollPhysics(),
                                    controller: _tabController,
                                    isScrollable: true,
                                    indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Theme.of(context).focusColor),
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    labelColor:Colors.white,
                                    labelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                    unselectedLabelStyle: TextStyle(
                                      fontSize: 10,
                                    ),
                                    unselectedLabelColor:Theme.of(context).selectedRowColor,
                                    tabs: [
                                      SizedBox(
                                        width: size.width * 0.11,
                                        height: size.height * 0.04,
                                        child: Center(
                                          child: Text(
                                            'ALL',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:size.width * 0.11,
                                        height: size.height * 0.04,
                                        child: Center(
                                          child: Text(
                                            'XID',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15,),
                          Container(
                            height: size.height,
                            child: TabBarView(
                              controller: _tabController,
                                children:[
                                  All(size),
                                  XID(size),
                                ]
                            ),
                          )
                        ],
                      ),
                    )
                )
            )
          ],
        ),
      ),
    );
  }
  Widget XID(Size size){
    return Column(
      children: [
        Container(
          height: size.height * 0.045,
          width: size.width,
          margin: EdgeInsets.only(right:size.width*0.025,left: size.width*0.025),
          decoration: BoxDecoration(
            color: Theme.of(context).indicatorColor.withOpacity(0.2),
            //color: Colors.red,
            //border: Border.all(color: Colors.grey.shade700),
            borderRadius: BorderRadius.circular(2),
          ),
          child: TabBar(
            physics: BouncingScrollPhysics(),
            controller: _tabController2,
            isScrollable: true,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Theme.of(context).focusColor),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor:Colors.white,
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            unselectedLabelStyle: TextStyle(
              fontSize: 12,
            ),
            unselectedLabelColor:Theme.of(context).selectedRowColor,
            tabs: [
              SizedBox(
                width: size.width * 0.35,
                child: Text(
                  'Buy',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                width:size.width * 0.36,
                child: Text(
                  'Sell',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Container(
          width: size.width,
          height: 35,
          color: Theme.of(context).hintColor.withOpacity(0.9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width*0.23,
                child: Center(child: Text(_tabController2.index == 0?"Buy Price":"Sell Price",style: TextStyle(fontSize: 11,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),)),
              ),
              Container(
                width: size.width*0.24,
                child: Center(child: Text("Volume",style: TextStyle(fontSize: 11,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),)),
              ),
              Container(
                width: size.width*0.23,
                child: Center(child: Text("XID",style: TextStyle(fontSize: 11,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),)),
              ),

            ],
          ),
        ),
        Container(
          height: size.height*0.6,
          color: Theme.of(context).cardColor,
          child: TabBarView(
            controller: _tabController2,
              children: [
                Consumer<providerdata>(
                  builder: (context,snapshot,child) {
                    List<buyAmount> providerdata_list=[];
                    providerdata_list=snapshot.getall();
                    return providerdata_list.length<=0?Center(child:Nodata2("You Have No Data At The Moment"),): ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: providerdata_list.length,
                        padding: EdgeInsets.only(bottom: 6),
                        itemBuilder: (BuildContext context,int index){
                          return Container(
                            margin: EdgeInsets.only(top:6,bottom: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: size.width*0.23,
                                  child: Center(child: Text(providerdata_list[index].price.toString(),style: TextStyle(fontSize: 10,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),)),
                                ),
                                Container(
                                  width: size.width*0.24,
                                  child: Center(child: Text(providerdata_list[index].value.toString(),style: TextStyle(fontSize: 10,color: ColorsCollectionsDark.markitlistgreen.withOpacity(0.4),fontWeight: FontWeight.w500),)),
                                ),
                                Container(
                                  width: size.width*0.23,
                                  child: Center(child: Text(providerdata_list[index].number.toString(),style: TextStyle(fontSize: 10,color:Theme.of(context).indicatorColor,fontWeight: FontWeight.w500),)),
                                ),
                              ],
                            ),
                          );
                        });
                  }
                ),
                Consumer<providerdata>(
                  builder: (context,snapshot,child){
                    List<amountSell> providerdata_list2=[];
                    providerdata_list2.clear();
                    providerdata_list2=snapshot.getall2();
                    return providerdata_list2.length<=0?Center(child:Nodata2("You Have No Data At The Moment"),):ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: providerdata_list2.length,
                        padding: EdgeInsets.only(bottom: 6),
                        itemBuilder: (BuildContext context,int index){
                      return Container(
                        margin: EdgeInsets.only(top:6,bottom: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width*0.23,
                              child: Center(child: Text(providerdata_list2[index].price.toString(),style: TextStyle(fontSize: 11,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),)),
                            ),
                            Container(
                              width: size.width*0.24,
                              child: Center(child: Text(providerdata_list2[index].value.toString(),style: TextStyle(fontSize: 11,color: ColorsCollectionsDark.greenlightColor,fontWeight: FontWeight.w500),)),
                            ),
                            Container(
                              width: size.width*0.23,
                              child: Center(child: Text(providerdata_list2[index].number.toString(),style: TextStyle(fontSize: 11,color: Theme.of(context).indicatorColor,fontWeight: FontWeight.w500),)),
                            ),
                          ],
                        ),
                      );
                    });
                  }
                )

          ]),
        )
      ],
    );
  }
  Widget All(Size size){
    return Column(
      children: [
        Container(
          height: size.height * 0.045,
          width: size.width,
          margin: EdgeInsets.only(right:size.width*0.025,left: size.width*0.025),
          decoration: BoxDecoration(
            color: Theme.of(context).indicatorColor.withOpacity(0.2),
            //color: Colors.red,
            //border: Border.all(color: Colors.grey.shade700),
            borderRadius: BorderRadius.circular(2),
          ),
          child: TabBar(
            physics: BouncingScrollPhysics(),
            controller: _tabController3,
            isScrollable: true,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Theme.of(context).focusColor),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor:Colors.white,
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            unselectedLabelStyle: TextStyle(
              fontSize: 12,
            ),
            unselectedLabelColor:Theme.of(context).indicatorColor,
            tabs: [
              SizedBox(
                width: size.width * 0.35,
                child: Text(
                  'Market Depth',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width:size.width * 0.36,
                child: Text(
                  'Order Depth',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Container(
          width: size.width,
          height: 35,
          color: Theme.of(context).hintColor.withOpacity(0.9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width*0.22,
                margin: EdgeInsets.only(left: 10),
                child: Align(alignment: Alignment.centerLeft,child: Text("VOLUME",style: TextStyle(fontSize: 11,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),)),
              ),
              Container(
                width: size.width*0.2,
                child: Center(child: Text("BUY PRICE",style: TextStyle(fontSize: 11,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),)),
              ),
              Container(
                width: size.width*0.2,
                child: Center(child: Text("SELL PRICE",style: TextStyle(fontSize: 11,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),)),
              ),
              Container(
                width: size.width*0.22,
                margin: EdgeInsets.only(right: 10),
                child: Align(alignment:Alignment.centerRight,child: Text("VOLUME",style: TextStyle(fontSize: 11,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),)),
              ),
            ],
          ),
        ),
        Container(
          height: size.height*0.6,
          child: TabBarView(
            controller: _tabController3,
            children: [
                 Consumer<providerdata>(
                   builder: (context, snapshot,child) {
                     List<buyMarketDepthAmount> providerdata_list=[];
                     List<sellMarketDepthAmount> providerdata_list2=[];
                     providerdata_list.clear();
                     providerdata_list2.clear();
                     providerdata_list =snapshot.getBuyMarketDepth();
                     providerdata_list2=snapshot.getSellMarketDepth();
                     return providerdata_list.length<=0 ?Center(child:Nodata2("You Have No Data At The Moment"),):
                     Row(
                       crossAxisAlignment:CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(
                           width: MediaQuery.of(context).size.width*0.4555,
                           child: ListView.builder(
                                 physics:NeverScrollableScrollPhysics(),
                                itemCount: providerdata_list.length,
                                shrinkWrap: true,
                                primary:false,
                                padding: EdgeInsets.only(bottom: 6),
                                itemBuilder: (BuildContext context,int index) {
                                  return Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          color: ColorsCollectionsDark.markitlistgreen.withOpacity(0.3),
                                          width:size.width,
                                          height: 25,
                                        ),
                                      ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                                width: size.width*0.22,
                                                margin: EdgeInsets.only(left: 10),
                                                child: Text(double.parse(providerdata_list[index].value.toString()).toStringAsFixed(3),style: TextStyle(fontSize: 10,color:Theme.of(context).selectedRowColor,fontWeight: FontWeight.w500),),
                                              ),
                                        Container(
                                          width: size.width*0.2,
                                          child: Center(child: Text(providerdata_list[index].price,style: TextStyle(fontSize: 10,color: Theme.of(context).selectedRowColor,fontWeight: FontWeight.w500),)),
                                        ),
                                      ],
                                    ),
                                    ],
                                  );
                            }),
                         ),
                         Container(
                           width: MediaQuery.of(context).size.width*0.4555,
                           child: ListView.builder(
                               physics:NeverScrollableScrollPhysics(),
                               shrinkWrap: true,
                               primary:false,
                               itemCount: providerdata_list2.length,
                               padding: EdgeInsets.only(bottom: 6),
                               itemBuilder: (BuildContext context,int index) {
                                // int lth=providerdata_list.length-1;
                                 return Stack(
                                   children: [
                                     Container(
                                       color: Colors.redAccent.withOpacity(0.2),
                                       width:size.width,
                                       height: 25,
                                     ),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Container(
                                           width: size.width*0.22,
                                           margin: EdgeInsets.only(left: 10),
                                           child: Text(providerdata_list2[index].price.toString(),style: TextStyle(fontSize: 10,color:Colors.redAccent,fontWeight: FontWeight.w500),),
                                         ),
                                         Container(
                                           width: size.width*0.2,
                                           child: Center(child: Text(double.parse(providerdata_list2[index].value.toString()).toStringAsFixed(3),style: TextStyle(fontSize: 10,color: Theme.of(context).selectedRowColor,fontWeight: FontWeight.w500),)),
                                         ),
                                       ],
                                     ),
                                   ],
                                 );
                               }),
                         ),
                       ],
                     );
                   }
                 ),
              Consumer<providerdata>(
                builder: (context, snapshot,child) {
                  List<buyMarketDepthAmount> providerdata_list=[];
                  List<sellMarketDepthAmount> providerdata_list2=[];
                  providerdata_list.clear();
                  providerdata_list2.clear();
                  providerdata_list =snapshot.getBuyMarketDepth();
                  providerdata_list2=snapshot.getSellMarketDepth();
                  print("sfsfsfds==============");
               /*   List<double> buys = [];
                  List<double> asks = [];
                  double large_value = 0.0;
                  buys.clear();
                  asks.clear();
                  for(int i=0;i<providerdata_list.length;i++){
                    buys.add(double.parse(providerdata_list[i].value));
                    providerdata_list2.length>0?asks.add(double.parse(providerdata_list2[i].value)):Container();
                    providerdata_list2.length>0?large_value = buys.reduce(max) > asks.reduce(max) ? buys.reduce(max) : asks.reduce(max):Container();
                    providerdata_list[i].percent=Cr.format(double.parse(providerdata_list[i].value) / large_value).toString();
                    providerdata_list2.length>0? providerdata_list2[i].percent=Cr.format(double.parse(providerdata_list2[i].value) / large_value).toString():Container();
                  }*/
                  print("Done,.,...");
                  return providerdata_list.length<=0?Center(child:Nodata2("No Data"),):
                  Row(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.4555,
                        child: ListView.builder(
                            physics:NeverScrollableScrollPhysics(),
                            itemCount: providerdata_list.length,
                            shrinkWrap: true,
                            primary:false,
                            padding: EdgeInsets.only(bottom: 6),
                            itemBuilder: (BuildContext context,int index) {
                              return Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      color: ColorsCollectionsDark.markitlistgreen.withOpacity(0.3),
                                      width:size.width,
                                      height: 25,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: size.width*0.22,
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(double.parse(providerdata_list[index].value.toString()).toStringAsFixed(3),style: TextStyle(fontSize: 10,color:Theme.of(context).selectedRowColor,fontWeight: FontWeight.w500),),
                                      ),
                                      Container(
                                        width: size.width*0.2,
                                        child: Center(child: Text(providerdata_list[index].price,style: TextStyle(fontSize: 10,color: Theme.of(context).selectedRowColor,fontWeight: FontWeight.w500),)),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.4555,
                        child: ListView.builder(
                            physics:NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            primary:false,
                            itemCount: providerdata_list2.length,
                            padding: EdgeInsets.only(bottom: 6),
                            itemBuilder: (BuildContext context,int index) {
                              // int lth=providerdata_list.length-1;
                              return Stack(
                                children: [
                                  Container(
                                    color: Colors.redAccent.withOpacity(0.2),
                                    width:size.width,
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: size.width*0.22,
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(providerdata_list2[index].price.toString(),style: TextStyle(fontSize: 10,color:Colors.redAccent,fontWeight: FontWeight.w500),),
                                      ),
                                      Container(
                                        width: size.width*0.2,
                                        child: Center(child: Text(double.parse(providerdata_list2[index].value.toString()).toStringAsFixed(3),style: TextStyle(fontSize: 10,color: Theme.of(context).selectedRowColor,fontWeight: FontWeight.w500),)),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  );
                /*  Row(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.45,
                        child: ListView.builder(
                          // physics: ClampingScrollPhysics(),
                            physics:NeverScrollableScrollPhysics(),
                            itemCount: providerdata_list.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(bottom: 6),
                            itemBuilder: (BuildContext context,int index) {
                              return Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      color: ColorsCollectionsDark.markitlistgreen.withOpacity(0.3),
                                      width:size.width, // here you can define your percentage of progress, 0.2 = 20%, 0.3 = 30 % .....
                                      height: 25,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:4.0,bottom: 4.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: size.width*0.22,
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(double.parse(providerdata_list[index].value.toString()).toStringAsFixed(3),style: TextStyle(fontSize: 10,color:Theme.of(context).indicatorColor,fontWeight: FontWeight.w500),),
                                        ),
                                        Container(
                                          width: size.width*0.2,
                                          child: Center(child: Text(providerdata_list[index].price.toString(),style: TextStyle(fontSize: 10,color: Theme.of(context).selectedRowColor,fontWeight: FontWeight.w500),)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                      providerdata_list2.length<=0?Center(child:Nodata2("No Data"),):Container(
                        width: MediaQuery.of(context).size.width*0.45,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: providerdata_list2.length,
                            physics:NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(bottom: 6),
                            itemBuilder: (BuildContext context,int index) {
                             // int lth=providerdata_list.length-1;
                              return Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      color: Colors.redAccent.withOpacity(0.2),
                                      width:size.width, // here you can define your percentage of progress, 0.2 = 20%, 0.3 = 30 % .....
                                      height: 25,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: size.width*0.22,
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(providerdata_list2[index].price.toString(),style: TextStyle(fontSize: 10,color:Colors.redAccent,fontWeight: FontWeight.w500),),
                                      ),
                                      Container(
                                        width: size.width*0.2,
                                        child: Center(child: Text(double.parse(providerdata_list2[index].value.toString()).toStringAsFixed(3),style: TextStyle(fontSize: 10,color: Theme.of(context).selectedRowColor,fontWeight: FontWeight.w500),)),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  );*/
                }
              ),
            ],
          ),
        )
      ],
    );
  }
}
