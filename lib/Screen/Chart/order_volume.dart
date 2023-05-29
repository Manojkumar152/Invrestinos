import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:investions/Api/MarketPageProvider.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:investions/Constant/Themedata.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../Constant/IntenetError.dart';
import '../../Constant/MarketDeath_Moadal.dart';

String SYMBOL = "";

class OrderVolumeTab extends StatefulWidget {
  String symbol;
  String familyCoin;
  String pairCoin;
  double rate;
  OrderVolumeTab(
      {required this.symbol,
      required this.familyCoin,
      required this.pairCoin,
      required this.rate});

  @override
  State<OrderVolumeTab> createState() => _OrderVolumeTabState();
}

class _OrderVolumeTabState extends State<OrderVolumeTab>
    with AutomaticKeepAliveClientMixin {
  int firsttimeordervol = 0;
  @override
  void initState() {
   // connectToServer();
    if (widget.symbol.contains('ξ')) {
      widget.symbol = 'ETH';
      SYMBOL = widget.symbol.toLowerCase();
    } else {
      SYMBOL = widget.symbol.toLowerCase();
      //print("check syu 2 " + SYMBOL.toString());
    }
    super.initState();
  }

  static NumberFormat Cr = new NumberFormat("###0.0000", "en_US");
  static NumberFormat Crone = new NumberFormat("###0.0", "en_US");

  var item;
  WebSocketChannel channel_usdt = IOWebSocketChannel.connect(
    Uri.parse('wss://stream.binance.com:9443/ws/stream?'),
  );

  Future<void> connectToServer() async {
    var jsonString;
    if (widget.familyCoin == "INR") {
      jsonString = json.encode({
        'method': "SUBSCRIBE",
        'params': [
          widget.symbol.toLowerCase() + 'usdt@depth20@1000ms',
        ],
        'id': 3,
      });
      //print("jsjhs"+jsonString.toString());
    } else {
      jsonString = json.encode({
        'method': "SUBSCRIBE",
        'params': [
          widget.pairCoin.toLowerCase() +'@depth20@1000ms',
        ],
        'id': 3,
      });
      //print("MPOT"+jsonString.toString());
    }

    channel_usdt.sink.add(jsonString);
  }

  @override
  void dispose() {
    // firsttimeordervol = 0;
    channel_usdt.sink.close();
    super.dispose();
  }
  Widget _loadingData(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: 12,
        itemBuilder: (ctx, i) {
          return loadingCard(ctx, i);
        },
      ),
    );
  }

  Widget loadingCard(BuildContext ctx, int i) {
    return Padding(
      padding: const EdgeInsets.only(top: 7.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 2.4,
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: buyAmountList.length,
          itemBuilder: (BuildContext ctx, int i) {
            return _buyAmount(
                MediaQuery.of(context).size.width / 2.4, buyAmountList[i]);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double mediaQuery = MediaQuery.of(context).size.width / 2.4;
    return Container(
      //color:  day==false?Color(0xff191d26):Colors.white,
      color: Theme.of(context).cardColor,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Divider(color:  day==false?Colors.white38:Colors.black45,),
            Container(
             color: Theme.of(context).hintColor.withOpacity(0.9),
              margin: EdgeInsets.only(top: 4),
              height: 30,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Buy Amount",
                      style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 12,fontWeight: FontWeight.w600,fontFamily: 'IBM Plex Sans')
                    ),
                    Text(
                      "Price",
                      style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 12,fontWeight: FontWeight.w600,fontFamily: 'IBM Plex Sans'),
                    ),
                    Text(
                      "Amount Sell",
                      style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 12,fontWeight: FontWeight.w600,fontFamily: 'IBM Plex Sans')
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
//             StreamBuilder(
//                 stream: channel_usdt.stream,
//                 builder: (context, snapshot) {
//                  // print("data>>"+snapshot.data.toString());
//                   if (snapshot.connectionState == ConnectionState.waiting && firsttimeordervol == 0) {
//                     return Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Container(
//                           // height: 300.0,
//                           width: mediaQuery,
//                           child: ListView.builder(
//                             shrinkWrap: true,
//                             primary: false,
//                             padding: EdgeInsets.zero,
//                             itemCount: buyAmountList.length,
//                             itemBuilder: (BuildContext ctx, int i) {
//                               //print("checklength"+buyAmountList[i].percent.toString());
//                               return _buyAmount(mediaQuery, buyAmountList[i]);
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Container(
//                           // height: 300.0,
//                           width: mediaQuery,
//                           child: ListView.builder(
//                             shrinkWrap: true,
//                             primary: false,
//                             padding: EdgeInsets.zero,
//                             itemCount: amountSellList.length,
//                             itemBuilder: (BuildContext ctx, int i) {
//                               //print("checklength"+amountSellList.length.toString());
//                               return _amountSell(mediaQuery, amountSellList[i]);
//                             },
//                           ),
//                         ),
//                       ],
//                     );
//                   } else if (snapshot.connectionState == ConnectionState.waiting && firsttimeordervol == 1) {
//                     return Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Container(
//                           // height: 300.0,
//                           width: mediaQuery,
//                           child: ListView.builder(
//                             shrinkWrap: true,
//                             primary: false,
//                             padding: EdgeInsets.zero,
//                             itemCount: buyAmountList.length,
//                             itemBuilder: (BuildContext ctx, int i) {
//                               //print("checklength"+buyAmountList[i].percent.toString());
//                               return _buyAmount(mediaQuery, buyAmountList[i]);
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Container(
//                           // height: 300.0,
//                           width: mediaQuery,
//                           child: ListView.builder(
//                             shrinkWrap: true,
//                             primary: false,
//                             padding: EdgeInsets.zero,
//                             itemCount: amountSellList.length,
//                             itemBuilder: (BuildContext ctx, int i) {
//                               //print("checklength"+amountSellList.length.toString());
//                               return _amountSell(mediaQuery, amountSellList[i]);
//                             },
//                           ),
//                         ),
//                       ],
//                     );
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text(snapshot.error.toString()));
//                   } else if (snapshot.connectionState == ConnectionState.active && !snapshot.data.toString().contains("result")) {
//                     firsttimeordervol = 1;
//                     //item = json.decode(snapshot.hasData ? snapshot.data : '');
//                     item = json.decode(snapshot.data as String);
//                     //print("=-=-=-"+item.toString());
//
    //                 List<double> buys = [];
      //               List<double> asks = [];
//
//                     if (item.length > 0) {
//                       double large_value = 0.0;
//                       //try {
// //buy
//                       for (int i = 0; i < 10; i++) {
//                         //print("Data has  "+item['asks'].toString());
//                         //print("checkdata---" + large_value.toString());
//                         buyAmountList[i].price = Cr.format(double.parse(item['bids'][i][0])).toString();
//                         //print("checkdata---" + buyAmountList[i].price.toString());
//                         buyAmountList[i].value = Cr.format(double.parse(item['bids'][i][1].toString())).toString();
//                         // print("checkdata---" + buyAmountList[i].value.toString());
//                         amountSellList[i].price = Cr.format(double.parse(item['asks'][i][0].toString())).toString();
//                         //print("checkdata---" + amountSellList[i].price.toString());
//                         amountSellList[i].value = Cr.format(double.parse(item['asks'][i][1].toString())).toString();
//                         //print("checkdata---" + amountSellList[i].value.toString());
//
//                         buys.add(double.parse(item['bids'][i][1]));
//                         asks.add(double.parse(item['asks'][i][1]));
                 //        large_value = buys.reduce(max) > asks.reduce(max) ? buys.reduce(max) : asks.reduce(max);
//                         //print("buyAmountList[i].percent" + large_value.toString());
//                         buyAmountList[i].percent = Cr.format(double.parse(buyAmountList[i].value) / large_value).toString();
//                         //print("buyAmountList[i].percent"+buyAmountList[i].percent.toString());
//                         amountSellList[i].percent = Cr.format(double.parse(amountSellList[i].value) / large_value).toString();
//                         //print("sellAmountList[i].percent" + amountSellList[i].percent.toString());
//                         //print("check6");
//                       }
//                       return Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Container(
//                             // height: 300.0,
//                             width: mediaQuery,
//                             child: ListView.builder(
//                               shrinkWrap: true,
//                               primary: false,
//                               padding: EdgeInsets.zero,
//                               itemCount: buyAmountList.length,
//                               itemBuilder: (BuildContext ctx, int i) {
//                                 //print("checklength"+buyAmountList[i].percent.toString());
//                                 return _buyAmount(mediaQuery, buyAmountList[i]);
//                               },
//                             ),
//                           ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           Container(
//                             // height: 300.0,
//                             width: mediaQuery,
//                             child: ListView.builder(
//                               shrinkWrap: true,
//                               primary: false,
//                               padding: EdgeInsets.zero,
//                               itemCount: amountSellList.length,
//                               itemBuilder: (BuildContext ctx, int i) {
//                                 //print("checklength"+amountSellList.length.toString());
//                                 return _amountSell(mediaQuery, amountSellList[i]);
//                               },
//                             ),
//                           ),
//                         ],
//                       );
//                     } else {
//                       return InternetError();
//                     }
//                   }
//                   return _loadingData(context);
//                 }),
            Consumer<market>(
                builder:(context,snapshot,child){
              List<buyAmount> buyAmountList=[];
              List<amountSell> amountSellList=[];
              buyAmountList =snapshot.getbuyList();
              amountSellList =snapshot.getsellList();
              List<double> buys = [];
              List<double> asks = [];
              double large_value = 0.0;
              for(int i=0;i<buyAmountList.length;i++){
                buys.add(double.parse(buyAmountList[i].value1));
                asks.add(double.parse(amountSellList[i].valume1));
                large_value = buys.reduce(max) > asks.reduce(max) ? buys.reduce(max) : asks.reduce(max);
                buyAmountList[i].percent=Cr.format(double.parse(buyAmountList[i].value1) / large_value).toString();
                amountSellList[i].percent=Cr.format(double.parse(amountSellList[i].valume1) / large_value).toString();
              }
              print("Done,.,...");
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    // height: 300.0,
                    width: mediaQuery,
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
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
                    // height: 300.0,
                    width: mediaQuery,
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.zero,
                      itemCount: amountSellList.length,
                      itemBuilder: (BuildContext ctx, int i) {
                        return _amountSell(mediaQuery, amountSellList[i]);
                      },
                    ),
                  ),
                ],
              );
            }),

          ]),
    );
  }

  Widget _buyAmount(double _width, buyAmount item) {
    double price = double.parse(item.price) * widget.rate;

    return Padding(
      padding: const EdgeInsets.only(left: 00, bottom: 0.0),
      child: Stack(
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
            width: _width,
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.value1.toString(),
                  style: TextStyle(fontSize: 12.0, color: Theme.of(context).indicatorColor),
                ),
                Text(
                  widget.familyCoin == "INR" ? Cr.format(price).toString() : item.price.toString(),
                  style: TextStyle(color: Theme.of(context).textTheme.headline2?.color, fontWeight: FontWeight.w500, fontSize: 11.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _amountSell(double _width, amountSell item) {
    double price = double.parse(item.price) * widget.rate;

    return Padding(
      padding: const EdgeInsets.only(right: 00, bottom: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: _width,
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
                      fontWeight: FontWeight.w700,
                      fontFamily: "Popins",
                      fontSize: 12.0),
                ),
                Text(
                  item.valume1.toString(),
                  style: TextStyle(
                      fontSize: 12.0,
                      //color: day==false?Colors.white:Colors.black),
                      color: Theme.of(context).indicatorColor),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.redAccent.withOpacity(0.2),
            width: _width *
                double.parse(Crone.format(double.parse(item
                    .percent))), // here you can define your percentage of progress, 0.2 = 20%, 0.3 = 30 % .....
            height: 25,
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
