import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:investions/Api/MarketPageProvider.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../Api/ApiCollections.dart';
import '../../Constant/CommonClass.dart';
import '../../Constant/IntenetError.dart';
import '../../Constant/MarketDeath_Moadal.dart';
import 'package:http/http.dart' as http;

import '../../Constant/Themedata.dart';

String SYMBOL = "";

class MarketDepth extends StatefulWidget {

  String symbol;
  String familyCoin;
  String pairCoin;
  String listed;
  String shortname;
  double rate;
  MarketDepth(
      {required this.symbol,
      required this.familyCoin,
      required this.pairCoin,
      required this.rate,
      required this.listed,
      required this.shortname});

  @override
  State<MarketDepth> createState() => _MarketDepthState();
}

class _MarketDepthState extends State<MarketDepth> with AutomaticKeepAliveClientMixin {
  int firsttimemarketDepth = 0;
  List<buyAmount> buyAmountList1=[];
  List<amountSell> amountSellList1=[];
  List datalist=[];
  List asklist=[];

  @override
  void initState() {
    // if(widget.listed.toString()=="true"){
    //   getorderBook2();
    // }else{
    //   getorderBook();
    // }
    if (widget.symbol.contains('ξ')) {
      widget.symbol = 'ETH';
      setState(() {
        SYMBOL = widget.symbol.toLowerCase();
      });
    } else {
      setState(() {
        SYMBOL = widget.symbol.toLowerCase();
      });
    }
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
    //    connectToServer();
    // });
    super.initState();
  }

  static NumberFormat Cr = NumberFormat("##0.0", "en_US");
  static NumberFormat Crone = NumberFormat("###0.0", "en_US");
  var item;
  WebSocketChannel channel_usdt = IOWebSocketChannel.connect(
    Uri.parse('wss://stream.binance.com:9443/ws/stream?'),
  );
  Future<void> connectToServer() async {
    //print("SYM "+widget.familyCoin.toString());
    if(widget.listed.toString() == "true"){
      if(channel_usdt !=null)channel_usdt.sink.close();
      channel_usdt = WebSocketChannel.connect(Uri.parse('wss://server.zonox.io'),);
      channel_usdt.sink.add(
        jsonEncode(
          {
            "method": "ADD",
            "params": [
              "fnxusdt@depth"
            ],
            'id': 3,
          },
        ),
      );
    }else {
      var jsonString;
      if (widget.familyCoin == "INR") {
        jsonString = json.encode({
          'method': "SUBSCRIBE",
          'params': [
            widget.shortname.toLowerCase() + 'usdt@depth10@1000ms',
          ],
          'id': 3,
        });
        //print("SYM "+jsonString.toString());
      } else {
        jsonString = json.encode({
          'method': "SUBSCRIBE",
          'params': [
            widget.pairCoin.toLowerCase() + '@depth10@1000ms',
          ],
          'id': 3,
        });
      }
      print(jsonString.toString());
      channel_usdt.sink.add(jsonString);
    }
  }

  @override
  void dispose() {
    channel_usdt.sink.close();
    // firsttimemarketDepth=0;
    super.dispose();
  }


  Widget loadingCard(BuildContext ctx, int i) {
    return Padding(
        padding: const EdgeInsets.only(top: 7.0),
        child: Shimmer.fromColors(
          baseColor: Color(0xFF3B4659),
          highlightColor: Color(0xFF606B78),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 15.0,
                                  width: 60.0,
                                  decoration: BoxDecoration(
                                      color: Theme.of(ctx).hintColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Container(
                                height: 12.0,
                                width: 25.0,
                                decoration: BoxDecoration(
                                    color: Theme.of(ctx).hintColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 15.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                color: Theme.of(ctx).hintColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Container(
                              height: 12.0,
                              width: 35.0,
                              decoration: BoxDecoration(
                                  color: Theme.of(ctx).hintColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Container(
                      height: 25.0,
                      width: 55.0,
                      decoration: BoxDecoration(
                          color: Theme.of(ctx).hintColor,
                          borderRadius: BorderRadius.all(Radius.circular(2.0))),
                    ),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 20.0, top: 6.0),
                child: Container(
                  width: double.infinity,
                  height: 0.5,
                  decoration: BoxDecoration(color: Colors.white12),
                ),
              )
            ],
          ),
        ));
  }

  Future<void>getorderBook()async{
    final uri = Uri.parse("https://"+ApiCollections.TradeUrl+"/list-crypto/market-data/"+widget.symbol.toString().toUpperCase());
    print("uri11"+uri.toString());
    final res = await http.get(uri);
    var data = jsonDecode(res.body);
    if(data["status_code"]=="1"){
      List bids=[];
      List asks=[];
      bids=data["data"]["bids"];
      asks=data["data"]["asks"];
      buyAmountList1.clear();
      amountSellList1.clear();
      double lastamount = 0.0;
      double lastamount1 = 0.0;
      double large_value = 0.0;
      for(int i=0;i<bids.length;i++){
        lastamount = lastamount + double.parse(bids[i][1].toString());
        lastamount1 = lastamount1 + double.parse(asks[i][1].toString());
        large_value = double.parse(lastamount1.toString()) > double.parse(lastamount.toString()) ? double.parse(lastamount1.toString()) : double.parse(lastamount.toString());
        setState(() {
          buyAmountList1.add(buyAmount(number:i.toString(), price:Cr.format(double.parse(bids[i][0].toString())).toString(), value:bids[i][1].toString(), percent:(lastamount/large_value).toString(),value1: "0"));
          amountSellList1.add(amountSell(number:i.toString(), price:asks[i][0].toString(), value: asks[i][1].toString(), percent:(lastamount1/large_value).toString(),valume1: "0"));
        });
        print("DOMNE");
      }
    }
  }

  Future<void>getorderBook2()async{
    final paramDic={
      "currency":widget.shortname.toString().toUpperCase(),
      "with_currency":widget.familyCoin.toString().toUpperCase(),
    };
    final uri = Uri.http(ApiCollections.NODELBM_BaseURL, "/orders/order-book", paramDic);
  // final uri = Uri.parse("https://"+ApiCollections.NODELBM_BaseURL+"/orders/order-book"+widget.symbol.toString().toUpperCase()+widget.pairCoin.toString().toUpperCase());
    print("uri"+uri.toString());
    final res = await http.get(uri);
    var data = jsonDecode(res.body);
    if(data["status_code"]=="1"){
      List bids=[];
      List asks=[];
      bids=data["data"]["bids"];
      asks=data["data"]["asks"];
      buyAmountList1.clear();
      amountSellList1.clear();
      double lastamount = 0.0;
      double lastamount1 = 0.0;
      double large_value = 5.0;
      for(int i=0;i<bids.length;i++){
        lastamount = lastamount + double.parse(bids[i][1].toString());
       // large_value = double.parse(lastamount1.toString()) > double.parse(lastamount.toString()) ? double.parse(lastamount1.toString()) : double.parse(lastamount.toString());
        setState(() {
          buyAmountList1.add(buyAmount(number:i.toString(), price:Cr.format(double.parse(bids[i][0].toString())).toString(), value:Cr.format(bids[i][1].toString()), percent:(lastamount1/large_value).toString(),value1: "0"));
         // amountSellList1.add(amountSell(number:i.toString(), price:asks[i][0].toString(), value: asks[i][1].toString(), percent:(lastamount1/large_value).toString()));
        });
      }for(int i=0;i<asks.length;i++){
         lastamount1 = lastamount1 + double.parse(asks[i][1].toString());
         setState(() {
            amountSellList1.add(amountSell(number:i.toString(), price:asks[i][0].toString(), value:asks[i][1].toString(), percent:(lastamount1/large_value).toString(), valume1: "0"));
         });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final mediaQuery = MediaQuery.of(context).size.width / 2.5;
    var screensize = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).cardColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 25,
            color: Theme.of(context).hintColor.withOpacity(0.9),
            margin: EdgeInsets.only(top: 5),
            child: Padding(
              padding:EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      "Volume",
                      style: TextStyle(fontSize: 11,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    "Price",
                    style:TextStyle(fontSize: 11,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      "Volume",
                      style: TextStyle(fontSize: 11,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
//           StreamBuilder(
//               stream: channel_usdt.stream,
//               builder: (context, snapshot) {
//               //  print(snapshot.data.toString());
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                      mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                          width: MediaQuery.of(context).size.width*0.41,
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           primary: false,
//                           padding: EdgeInsets.zero,
//                           itemCount: buyAmountList1.length,
//                           itemBuilder: (BuildContext ctx, int i) {
//                             int lth=buyAmountList1.length-1-i;
//                             return _buyAmount(mediaQuery, buyAmountList1[lth]);
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Container(
//                         //  height: screensize.height*buyAmountList.length,
//                 width: MediaQuery.of(context).size.width*0.41,
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                          // primary: false,
//                           padding: EdgeInsets.zero,
//                           itemCount: amountSellList1.length,
//                           itemBuilder: (BuildContext ctx, int i) {
//                             int lth=amountSellList1.length-1-i;
//                             return _amountSell(mediaQuery, amountSellList1[lth]);
//                           },
//                         ),
//                       ),
//                     ],
//                   );
//                   ;
//                 }
//                 else if (snapshot.hasError) {
//                   return Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                 width: MediaQuery.of(context).size.width*0.41,
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           primary: false,
//                           padding: EdgeInsets.zero,
//                           itemCount: buyAmountList1.length,
//                           itemBuilder: (BuildContext ctx, int i) {
//                             int lth=buyAmountList1.length-1-i;
//                             return _buyAmount(mediaQuery, buyAmountList1[lth]);
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Container(
//                         //  height: screensize.height*buyAmountList.length,
//                 width: MediaQuery.of(context).size.width*0.41,
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           // primary: false,
//                           padding: EdgeInsets.zero,
//                           itemCount: amountSellList1.length,
//                           itemBuilder: (BuildContext ctx, int i) {
//                             int lth=amountSellList1.length-1-i;
//                             return _amountSell(mediaQuery, amountSellList1[lth]);
//                           },
//                         ),
//                       ),
//                     ],
//                   );;
//                 }
//                  if (snapshot.connectionState == ConnectionState.active) {
//                   item = json.decode(snapshot.data as String);
//                  // print(item.toString());
//                   if (snapshot.hasData) {
// //                     try{
// //                       if(item['bids'].length>0) {
// //                      //   print("openOrderDetail" + item['bids'].toString());
// //                      //    buyAmountList1.clear();
// //                      //    amountSellList1.clear();
// //                         double lastamount = 0.0;
// //                         double lastamountasks = 0.0;
// //                         double large_value = 0.0;
// //
// // //buy
// //                         for (int i = 0; i < item['bids'].length; i++) {
// //                           buyAmountList1[i].price = Cr.format(double.parse(item['bids'][i][0].toString())).toString();
// //                           lastamount = lastamount + double.parse(item['bids'][i][1].toString());
// //                           buyAmountList1[i].value = Cr.format(lastamount).toString();
// //                           //print(buyAmountList1[i].value.toString() + "------------" + buyAmountList[i].price.toString());
// //                         }
// //
// // //sell
// //                         for (int i = 0; i < item['asks'].length; i++) {
// //                           amountSellList1[i].price = Cr.format(double.parse(item['asks'][i][0].toString())).toString();
// //                           lastamountasks = lastamountasks + double.parse(item['asks'][i][1].toString());
// //                           amountSellList1[i].value = Cr.format(lastamountasks).toString();
// //                          // print(amountSellList[i].value.toString() + "------------" + amountSellList[i].price.toString());
// //                         }
// //                         large_value = double.parse(amountSellList1[9].value) > double.parse(buyAmountList1[9].value) ? double.parse(amountSellList1[9].value) : double.parse(buyAmountList1[9].value);
// //
// //                         for (int i = 0; i < item['asks'].length; i++) {
// //                           buyAmountList1[i].percent = (double.parse(buyAmountList1[i].value) / large_value).toString();
// //                           amountSellList1[i].percent = (double.parse(amountSellList1[i].value) / large_value).toString();
// //                         }
// //                       }
// //                     }catch(Exception){
// //                       //  print(e.toString);
// //                     }
//                     try {
//                       if (item['bids'].length > 0) {
//                         double lastamount = 0.0;
//                         double lastamount1 = 0.0;
//                         double large_value = 0.0;
//                         double vallue1=0.0;
//                         double vallue2=0.0;
//                         buyAmountList1.clear();
//                         amountSellList1.clear();
//
//                         for (int i = 0; i < item['bids'].length; i++) {
//                           vallue1=vallue1+double.parse(item['bids'][i][1].toString());
//                           vallue2=vallue2+double.parse(item['asks'][i][1].toString());
//                             buyAmountList1.add(buyAmount(number:"0", price: double.parse(item['bids'][i][0].toString()).toString(), value: vallue1.toString(), percent:(vallue1/large_value).toString()));
//                             amountSellList1.add(amountSell(number: "0", price:double.parse(item['asks'][i][0].toString()).toString(), value:vallue2.toString(), percent:(vallue2/large_value).toString()));
//                         }
//                         large_value = double.parse(amountSellList1[9].value) > double.parse(buyAmountList1[9].value) ? double.parse(amountSellList1[9].value) : double.parse(buyAmountList1[9].value);
//
//                         for (int i = 0; i < item['asks'].length; i++) {
//                           buyAmountList1[i].percent = (double.parse(buyAmountList1[i].value) / large_value).toString();
//                           amountSellList1[i].percent = (double.parse(amountSellList1[i].value) / large_value).toString();
//                         }
//                       }
//                     } catch (Exception) {
//                       //  print(e.toString);
//                     }
//                   }
//                   return Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         //height: screensize.height*buyAmountList.length,
//                         width: MediaQuery.of(context).size.width*0.41,
//                         height:screensize.height,
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                         //  primary: false,
//                           padding: EdgeInsets.zero,
//                           itemCount: buyAmountList1.length,
//                           itemBuilder: (BuildContext ctx, int i) {
//                             int lth=datalist.length-1-i;
//                             return _buyAmount(mediaQuery, buyAmountList1[i]);
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Container(
//                           height:screensize.height,
//                         width: MediaQuery.of(context).size.width*0.41,
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                         //  primary: false,
//                           padding: EdgeInsets.zero,
//                           itemCount: amountSellList1.length,
//                           itemBuilder: (BuildContext ctx, int i) {
//                             int lth=asklist.length-1-i;
//                             return _amountSell(mediaQuery, amountSellList1[i]);
//                           },
//                         ),
//                       ),
//                     ],
//                   );
//                 }
//                 return Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Container(
//                       width: MediaQuery.of(context).size.width*0.41,
//                       height:screensize.height,
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         primary: false,
//                         padding: EdgeInsets.zero,
//                         itemCount: buyAmountList1.length,
//                         itemBuilder: (BuildContext ctx, int i) {
//                           int lth=buyAmountList1.length-1-i;
//                           return _buyAmount(mediaQuery, buyAmountList1[i]);
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Container(
//                       //  height: screensize.height*buyAmountList.length,
//                       width: MediaQuery.of(context).size.width*0.41,
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         // primary: false,
//                         padding: EdgeInsets.zero,
//                         itemCount: amountSellList1.length,
//                         itemBuilder: (BuildContext ctx, int i) {
//                           int lth=amountSellList1.length-1-i;
//                           return _amountSell(mediaQuery, amountSellList1[i]);
//                         },
//                       ),
//                     ),
//                   ],
//                 );;
//               }),
          Consumer<market>(
              builder:(context,snapshot,child){
                List<buyAmount> buyAmountList=[];
                List<amountSell>sellAmountList=[];
                buyAmountList=snapshot.getbuyList();
                sellAmountList=snapshot.getsellList();
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.41,
                  height:screensize.height,
                  child: ListView.builder(
                    shrinkWrap: true,
                    //  primary: false,
                    padding: EdgeInsets.zero,
                    itemCount: buyAmountList.length,
                    itemBuilder: (BuildContext ctx, int i) {
                      return _buyAmount(mediaQuery, buyAmountList[i]);
                    },
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height:screensize.height,
                  width: MediaQuery.of(context).size.width*0.41,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: sellAmountList.length,
                    itemBuilder: (BuildContext ctx, int i) {
                      return _amountSell(mediaQuery, sellAmountList[i]);
                    },
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buyAmount(double _width, buyAmount item) {
    double price = double.parse(item.price) * widget.rate;
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            color: ColorsCollectionsDark.markitlistgreen.withOpacity(0.3),
            width: _width * double.parse(Crone.format(double.parse(item.percent))), // here you can define your percentage of progress, 0.2 = 20%, 0.3 = 30 % .....
            height: 25,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.37,
          height: 25,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //           Padding(
              //   padding: const EdgeInsets.only(right: 8.0),
              //   child: Text(
              //     item.number,
              //     style: TextStyle(
              //         color: Theme.of(context).hintColor,
              //         fontFamily: "IBM Plex Sans",
              //         fontSize: 15.0),
              //   ),
              // ),

              Text(
                double.parse(item.value.toString()).toStringAsFixed(3),
                style: TextStyle(fontSize: 10,color: Theme.of(context).indicatorColor,fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Text(
                widget.familyCoin == "INR"
                    ? Cr.format(price).toString()
                    : item.price.toString(),
                style: TextStyle(fontSize: 11,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _amountSell(double _width, amountSell item) {
    double price = double.parse(item.price) * widget.rate;
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width*0.37,
          //color: Colors.lightBlueAccent,
          height: 25,
          child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.familyCoin == "INR"
                    ? Cr.format(price).toString()
                    : item.price.toString(),
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                    fontFamily: "IBM Plex Sans",
                    fontSize: 11.0),
              ),
              Spacer(),
              Text(
                double.parse(item.value.toString()).toStringAsFixed(3),
                style: TextStyle(
                  fontFamily: "IBM Plex Sans",
                  fontSize: 10.0,
                  color: Theme.of(context).indicatorColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 8.0),
              //   child: Text(
              //     item.number,
              //     style: TextStyle(
              //         color: Theme.of(context).hintColor,
              //         fontFamily: "IBM Plex Sans",
              //         fontSize: 15.0),
              //   ),
              // ),
            ],
          ),
        ),
        Container(
          color: Colors.redAccent.withOpacity(0.2),
          width:_width *
              double.parse(Crone.format(double.parse(item
                  .percent))), // here you can define your percentage of progress, 0.2 = 20%, 0.3 = 30 % .....
          height: 25,
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
