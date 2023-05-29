import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:investions/Constant/Nodata.dart';
import 'package:investions/Screen/P2P/PeerToPeerOrderDetails.dart';
import 'package:investions/Screen/P2P/peerTopeerOrderBook.dart';
import 'package:provider/provider.dart';

import '../../Api/Provideclass.dart';
import '../../Constant/ColorsCollection.dart';
import '../../Constant/SharePerferarance.dart';

class PeerToPeer_Complete extends StatefulWidget {
  static const id = 'PeerToPeer_Complete';

  @override
  State<PeerToPeer_Complete> createState() => _PeerToPeer_CompleteState();
}

class _PeerToPeer_CompleteState extends State<PeerToPeer_Complete>with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int ind = 0;
  bool clicable = false;
  String status = '';
  @override
  void initState() {

    Provider.of<providerdata>(context,listen: false).getOpenOrder();
    _tabController = TabController(length: 2, vsync:this);
    _tabController.addListener(() {
      setState(() {
        ind = _tabController.index;
      });
    });
    getShareddata();
    super.initState();
  }

  getShareddata()async{
    status=await SharedPreferenceClass.GetSharedData("isLogin");
    setState(() {
      status=status;
    });
  }
  @override
  void didChangeDependencies() {
  //  Provider.of<providerdata>(context,listen: false).getOpenOrder();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
       // physics: NeverScrollableScrollPhysics(),
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
                          Text("Peer To Peer (P2P)",style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                    SizedBox(height: size.height*0.1,),
                    Container(
                      height: size.height * 0.050,
                      width: size.width,
                      margin: EdgeInsets.only(right: size.width*0.06),
                      decoration: BoxDecoration(
                        color:Theme.of(context).hintColor,
                      //  color: Colors.red,
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
                        labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w700,),
                        unselectedLabelStyle: TextStyle(
                          fontSize: 11,fontWeight: FontWeight.w700
                        ),
                        unselectedLabelColor:Theme.of(context).selectedRowColor,
                        tabs: [
                          SizedBox(
                            width: size.width * 0.36,
                            child: Text(
                              'Open Orders',
                              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            width:size.width * 0.36,
                            child: Text(
                              'Complete Orders',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin:EdgeInsets.only(top: size.height*0.250, left: 16.0, right: 16.0),
                elevation: 0.5,
                color: Theme.of(context).cardColor,
                 //color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    )),

                child: Container(
                  height: size.height*0.75,
                   // /color: Colors.red,
                  child:TabBarView(
                    physics: BouncingScrollPhysics(),
                    controller: _tabController,
                    children: [

                      OpenOrder(size),
                      CompleteOrder(size),
                    ],
                  )
                )
            )
          ],
        ),
      ),
    );
  }
  Widget CompleteOrder(Size size){
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: size.width*0.16,
                    child: Center(child: Text("  Currency",style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 10,fontWeight: FontWeight.w500),))),
                Container(
                    width: size.width*0.16,
                    child: Center(child: Text("Price/Qty",style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 10,fontWeight: FontWeight.w500),))),
                Container(
                    width: size.width*0.16,
                    child: Center(child: Text("Total",style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 10,fontWeight: FontWeight.w500),))),
                Container(
                    width: size.width*0.14,
                    child: Center(child: Text("XID",style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 10,fontWeight: FontWeight.w500),))),

                Container(
                    width: size.width*0.18,
                    child: Center(child: Text("Status",style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 10,fontWeight: FontWeight.w500),))),

                Container(
                    width: size.width*0.1,
                    child: Center(child: Text(""))),
              ],
            ),
          ),
          SizedBox(height:5,),
          Divider(color: Theme.of(context).indicatorColor.withOpacity(0.8),thickness: 0.3,height: 1,),
        //  SizedBox(height: 5,),
          Consumer<providerdata>(
            builder: (context,snapshot,child){
              List openorder=[];
              openorder=snapshot.getComplateOrder();
              return openorder.contains("UnAuthenticated")?Nodata2("UnAuthenticated\nPlease Login again"):openorder.contains("No Data") || openorder.contains("Error")?Nodata2("NO Order"):openorder.length<=0?
              SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator()):ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: openorder.length,
                  itemBuilder: (BuildContext context,int index){
                    return Column(
                      children: [
                        Container(
                          width: size.width,
                          height: 40,
                          color: openorder[index]["status"].toString()=='cancelled'?ColorsCollectionsDark.markitlistgreen.withOpacity(0.7):Colors.red.withOpacity(0.7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(height: 5,width: 5,),
                              Row(
                                children: [
                                  Text(  openorder[index]["currency"].toString(),style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w500),),
                                  Text("/ ",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 8,fontWeight: FontWeight.w500),),
                                  Text(openorder[index]["with_currency"].toString(),style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 9,fontWeight: FontWeight.w300),)
                                ],
                              ),
                              Container(
                                width: size.width*0.14,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(openorder[index]["price"].toString().split(".").first,style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 9,fontWeight: FontWeight.w500),),
                                   // SizedBox(width: size.width*0.1,child:Divider(color: Theme.of(context).indicatorColor.withOpacity(0.8),thickness: 0.7,height: 3,),),
                                    Text("/ ",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 8,fontWeight: FontWeight.w500),),
                                    Text(openorder[index]["quantity"].toString().split(".").first.toString(),style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w500),),

                                  ],
                                ),
                              ),
                              Container(
                                width: size.width*0.18,
                                child: Center(child: Text(openorder[index]["total_price"].toString().split(".").first.toString(),style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w500),)),

                              ),
                              Container(
                                width: size.width*0.18,
                                child: Center(child: Text(openorder[index]["user_xid"].toString(),style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w500),)),
                              ),
                              Container(
                                width: size.width*0.16,
                                child: Center(child: Text(openorder[index]["status"].toString(),style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w500),)),
                              ),
                              GestureDetector(
                                onTap: (){
                                  showAnimatedDialog(
                                      animationType: DialogTransitionType.slideFromBottom,
                                      curve: Curves.easeOut,
                                      barrierDismissible:true,
                                      context: context, builder: (BuildContext context){
                                    return PeerToPeerOrderDetails(id:openorder[index]["id"].toString(),);
                                  }).then((value) =>  Provider.of<providerdata>(context,listen: false).getOpenOrder());
                                },
                                child: Container(
                                  width: size.width*0.1,
                                  child: Align(
                                      alignment:Alignment.center,
                                      child:Icon(FontAwesomeIcons.circleChevronRight,size: 14,color: Theme.of(context).textTheme.headline1?.color,)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 0,),
                        Divider(
                            color: Theme.of(context).indicatorColor.withOpacity(0.8),thickness: 0.3,height: 1,),
                      ],
                    );
                  });
            }
          )
        ],
      ),
    );
  }
  Widget OpenOrder(Size size){
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: size.width*0.16,
                    child: Center(child: Text("  Currency",style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 10,fontWeight: FontWeight.w500),))),
                Container(
                    width: size.width*0.16,
                    child: Center(child: Text("Price",style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 10,fontWeight: FontWeight.w500),))),

                Container(
                    width: size.width*0.14,
                    child: Center(child: Text("Qty",style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 10,fontWeight: FontWeight.w500),))),

                Container(
                    width: size.width*0.16,
                    child: Center(child: Text("Total",style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 10,fontWeight: FontWeight.w500),))),
                Container(
                    width: size.width*0.18,
                    child: Center(child: Text("Type",style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 10,fontWeight: FontWeight.w500),))),

                Container(
                    width: size.width*0.1,
                    child: Center(child: Text(""))),
              ],
            ),
          ),
          SizedBox(height:5,),
          Divider(color: Theme.of(context).indicatorColor.withOpacity(0.8),thickness: 0.3,),
          SizedBox(height: 5,),
          Consumer<providerdata>(
              builder: (context,snapshot,child){
                List openorder=[];
                openorder=snapshot.getOpenOrderList();
               print("---------"+openorder.toString());
               return openorder.contains("UnAuthenticated")?Nodata2("UnAuthenticated\nPlease Login again"):openorder.contains("No Data") || openorder.contains("Error")?Nodata2("No Order"):openorder.length<=0?
                SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator()):ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: openorder.length,
                    itemBuilder: (BuildContext context,int index){
                      return Column(
                        children: [
                          Container(
                            width: size.width,
                            height: 40,
                            color: openorder[index]["status"].toString()=='cancelled'?ColorsCollectionsDark.markitlistgreen.withOpacity(0.7):Colors.red.withOpacity(0.7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(height: 5,width: 5,),
                                Row(
                                  children: [
                                    Text(  openorder[index]["currency"].toString(),style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w500),),
                                    Text("/ ",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 8,fontWeight: FontWeight.w500),),
                                    Text(openorder[index]["with_currency"].toString(),style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 9,fontWeight: FontWeight.w300),)
                                  ],
                                ),
                                Container(
                                  width: size.width*0.14,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(double.parse(openorder[index]["price"].toString()).toStringAsFixed(4),style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w500),),
                                      // SizedBox(width: size.width*0.1,child:Divider(color: Theme.of(context).indicatorColor.withOpacity(0.8),thickness: 0.7,height: 3,),),
                                     // Text("/ ",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 8,fontWeight: FontWeight.w500),),

                                    ],
                                  ),
                                ),
                                Container(
                                  width: size.width*0.18,
                                  child: Center(child: Text(double.parse(openorder[index]["quantity"].toString()).toStringAsFixed(4),style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w500),)),
                                ),
                                Container(
                                  width: size.width*0.18,
                                  child: Center(child: Text(double.parse(openorder[index]["total_price"].toString()).toStringAsFixed(4),style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w500),)),

                                ),

                                Container(
                                  width: size.width*0.16,
                                  child: Center(child: Text(openorder[index]["order_type"].toString(),style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w500),)),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    // showAnimatedDialog(
                                    //     animationType: DialogTransitionType.slideFromBottom,
                                    //     curve: Curves.easeOut,
                                    //     barrierDismissible:true,
                                    //     context: context, builder: (BuildContext context){
                                    //   return PeerToPeerOrderDetails(id:openorder[index]["id"].toString(),);
                                    // });
                                    Navigator.pushNamed(context, "/P2PMatchingDetails",arguments: openorder[index]["id"].toString()).then((value) =>  Provider.of<providerdata>(context,listen: false).getOpenOrder());
                                  },
                                  child: Container(
                                    width: size.width*0.1,
                                    child: Align(
                                        alignment:Alignment.center,
                                        child:Icon(FontAwesomeIcons.circleChevronRight,size: 14,color: Theme.of(context).textTheme.headline1?.color,)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 0,),
                          Divider(
                            color: Theme.of(context).indicatorColor.withOpacity(0.8),thickness: 0.3,height: 1,),
                        ],
                      );
                    });
              }
          )
        ],
      ),
    );
  }
}
