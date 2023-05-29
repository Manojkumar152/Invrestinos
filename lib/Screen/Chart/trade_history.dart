import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:investions/Api/ApiCollections.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:shimmer/shimmer.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../Constant/CommonClass.dart';
import '../../Constant/MarketDeath_Moadal.dart';

class TradeHistoryTab extends StatefulWidget {
  String symbol;
  String familyCoin;
  String pairCoin;
  double rate;
  String listed;
  TradeHistoryTab(
      {required this.symbol,
      required this.familyCoin,
      required this.pairCoin,
      required this.rate,
      required this.listed});

  @override
  State<TradeHistoryTab> createState() => _TradeHistoryTabState();
}

class _TradeHistoryTabState extends State<TradeHistoryTab>
    with AutomaticKeepAliveClientMixin {
  static NumberFormat Cr = new NumberFormat("#,##0.00", "en_US");
  static NumberFormat Crone = new NumberFormat("#,##0.0", "en_US");
  List<orderHistoryModel> listorderHistoryModel = [];
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
  //  gettrade();
    connectToServer();
    super.initState();
  }

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  var item;
  WebSocketChannel channel_usdt = IOWebSocketChannel.connect(
    Uri.parse('wss://stream.binance.com:9443/ws/stream?'),
  );

  Future<void> connectToServer() async {
    print("SYM " + widget.familyCoin.toString());
    var jsonString;
    if(widget.listed.toString() == "true"){
      channel_usdt.sink.close();
      channel_usdt = WebSocketChannel.connect(Uri.parse('wss://server.zonox.io'),);
      channel_usdt.sink.add(
        jsonEncode(
          {
            "method": "ADD",
            "params": [
              "fnxusdt@trade"
            ],
            'id': 3,
          },
        ),
      );
    }else {
      if (widget.familyCoin == "INR") {
        jsonString = json.encode({
          'method': "SUBSCRIBE",
          'params': [
            widget.symbol.toLowerCase() + 'usdt@trade',
          ],
          'id': 3,
        });
        print("SYM " + jsonString.toString());
      } else {
        jsonString = json.encode({
          'method': "SUBSCRIBE",
          'params': [
            widget.pairCoin.toLowerCase() + '@trade',
          ],
          'id': 3,
        });
        print("nor" + jsonString.toString());
      }
      channel_usdt.sink.add(jsonString);
    }
  }

  // Future<void> gettrade()async{
  //   final uri = Uri.parse("https://"+ApiCollections.TradeUrl+"/list-crypto/trade-history/"+widget.symbol.toString().toUpperCase());
  //   print("uri"+uri.toString());
  //   final res = await http.get(uri);
  //   var data = jsonDecode(res.body);
  //   if(data["status_code"] == "1"){
  //     List trade=data["data"];
  //     for(int i=0;i<trade.length;i++){
  //       listorderHistoryModel.add(orderHistoryModel(date: DateTime.fromMillisecondsSinceEpoch(trade[i]['T']).toString().split(' ')[1],
  //           price:Cr.format(double.parse(trade[i]['p'].toString())), amount:trade[i]['q'].toString(), type:trade[i]["m"].toString() == "true"?"Buy":"Sell"));
  //     }
  //     print("Done????");
  //   }
  // }
  @override
  void dispose() {
    channel_usdt.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).cardColor,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Theme.of(context).hintColor.withOpacity(0.9),
              margin: EdgeInsets.only(top: 4),
              height: 30,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: size.width*0.2,
                      child: Text("Time",
                        style: TextStyle(
                          //color: day==false?Colors.white:Colors.white,
                          color: Theme.of(context).textTheme.headline2?.color,fontSize: 11,fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    Container(
                      width: size.width*0.2,
                      child: Text(
                        "Type",
                        style: TextStyle(
                            //color: day==false?Colors.white:Colors.white
                            color: Theme.of(context).textTheme.headline2?.color,fontSize: 11,fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      width: size.width*0.2,
                      child: Text(
                        "Price",
                        style: TextStyle(
                          // color: day==false?Colors.white:Colors.white,
                          color: Theme.of(context).textTheme.headline2?.color,fontSize: 11,fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    Container(
                      width: size.width*0.2,
                      child: Text(
                        "Amount",textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.headline2?.color,fontSize: 11,fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            StreamBuilder(
                stream: channel_usdt.stream,
                builder: (context, snapshot) {
                  print(snapshot.data.toString());
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                          // height: 350.0,
                          child: ListView.builder(
                              controller: _scrollController,
                              shrinkWrap: true,
                              primary: false,
                              reverse: true,
                              padding: EdgeInsets.zero,
                              itemCount: CommonClass.listorderHistoryModel.length,
                              itemBuilder: (BuildContext ctx, int i) {
                                return _orderHistory(CommonClass.listorderHistoryModel[i],size);
                              })),
                    );
                  }
                  // else if(snapshot.connectionState == ConnectionState.waiting && firsttimetradehistory==1){
                  //   return Container(
                  //     // height: 350.0,
                  //       child: ListView.builder(
                  //           controller: _scrollController,
                  //           shrinkWrap: true,
                  //           primary: false,reverse: false,
                  //           itemCount: listorderHistoryModel.length,
                  //           itemBuilder: (BuildContext ctx, int i) {
                  //             return _orderHistory(listorderHistoryModel[i]);
                  //           }
                  //       ));
                  // }
                  else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.connectionState == ConnectionState.active) {
                    item = json.decode(snapshot.data as String);
                    if (item.length > 0) {
                      CommonClass.listorderHistoryModel.add(orderHistoryModel(date: item['T'] == null ? "" : DateTime.fromMillisecondsSinceEpoch(item['T']).toString().split(' ')[1],
                          type: item['m'] == true ? "Buy" : "Sell", price: item['p'] == null ? "" : Cr.format(double.parse(item['p'].toString())),
                          amount: item['q'] == null ? "" : item['q'].toString()));
                    }
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                            //  height: 350.0,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                controller: _scrollController,
                                shrinkWrap: true,
                                primary: false,
                                padding: EdgeInsets.zero,
                                reverse: true,
                                itemCount: CommonClass.listorderHistoryModel.length,
                                itemBuilder: (BuildContext ctx, int i) {
                                  return _orderHistory(CommonClass.listorderHistoryModel[i],size);
                                })),
                      );
                  }else{
                    return Container(
                      // height: 350.0,
                        child: ListView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            primary: false,
                            padding: EdgeInsets.zero,
                            reverse: true,
                            itemCount: CommonClass.listorderHistoryModel.length,
                            itemBuilder: (BuildContext ctx, int i) {
                              return _orderHistory(CommonClass.listorderHistoryModel[i],size);
                            }));
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget _orderHistory(orderHistoryModel item,Size size) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToBottom());

    return SingleChildScrollView(
        child: item.date != "" ? Container(
                color: item.type == "Buy" ? Colors.green.withOpacity(0.1) : Colors.redAccent.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: size.width*0.2,
                          child: Text(
                            item.date == null ? "00:00:00" : item.date.toString().split('.')[0],
                            style: TextStyle(
                                // color: day==false?Colors.white:Colors.black,
                                color: Theme.of(context).textTheme.headline2!.color,
                                fontSize: 11.0),
                          ),
                        ),
                        Container(
                          width: size.width*0.2,
                          child: Text(
                            item.type,
                            style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600,
                                color: item.type == 'Buy'
                                    ? ColorsCollectionsDark.markitlistgreen
                                    : Colors.redAccent),
                          ),
                        ),
                        Container(
                          width: size.width*0.2,
                          child: Text(
                            item.price,
                            style: TextStyle(
                                // color:day==false?Colors.white:Colors.black,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .color,
                                fontWeight: FontWeight.w600,
                                fontSize: 11.0),
                          ),
                        ),
                        Container(
                          width: size.width*0.2,
                          child: Text(
                            item.amount,
                            maxLines: 1,
                            style: TextStyle(
                                // color: day==false?Colors.white:Colors.black,
                                color: Theme.of(context).textTheme.bodyText1!.color,
                                fontWeight: FontWeight.w600,
                                fontSize: 11.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Container());
  }

  Widget _loadingData(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: 20,
        itemBuilder: (ctx, i) {
          return loadingCard(ctx, i);
        },
      ),
    );
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
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
              padding: const EdgeInsets.only(left: 10.0, right: 20.0, top: 6.0),
              child: Container(
                width: double.infinity,
                height: 0.5,
                decoration: BoxDecoration(color: Colors.white12),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
