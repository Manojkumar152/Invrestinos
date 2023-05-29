import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:investions/Api/ApiMain.dart';
import 'package:investions/Api/Network%20Service.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../Constant/MarketDeath_Moadal.dart';

class providerdata extends ChangeNotifier{
   NetworkService networkService=NetworkService();
  List<buyAmount> p2pbuyAmountList=[];
   List<amountSell> p2pamountSellList=[];
  List<orderHistoryModel> listorderHistoryModel=[];
  List openOrderP2p=[];
  List CompleteOrder=[];

   List<buyMarketDepthAmount> p2pbuyMarketDepthList=[];
   List<sellMarketDepthAmount> p2psellMarketDepthList=[];
  static NumberFormat Cr = new NumberFormat("#,##0.00", "en_US");


  WebSocketChannel channel_usdt = IOWebSocketChannel.connect(
    Uri.parse('wss://stream.binance.com:9443/ws/stream?'),
  );
  WebSocketChannel trade_channel = IOWebSocketChannel.connect(
    Uri.parse('wss://stream.binance.com:9443/ws/stream?'),
  );

  List<buyAmount>getall(){
    return p2pbuyAmountList.toList();
  }
  List<amountSell>getall2(){
    return p2pamountSellList;
  }


   List<buyMarketDepthAmount>getBuyMarketDepth(){
     return p2pbuyMarketDepthList.toList();
   }
   List<sellMarketDepthAmount>getSellMarketDepth(){
     return p2psellMarketDepthList.toList();
   }

  List<dynamic> getOpenOrderList(){
    return openOrderP2p;
  }
   List<dynamic> getComplateOrder(){
     return CompleteOrder;
   }


  Future<void> getmatket()async{
    List datalist=[];
   /* var jsonString = json.encode({
      'method': "SUBSCRIBE",
      'params': [
        "btcusdt"+'@depth20@1000ms',
      ],
      'id': 3,
    });
    print("paramDic????"+jsonString.toString());*/
    await getBuyorder();
    // channel_usdt.sink.add(jsonString);
    // channel_usdt.stream.forEach((element) {
    //   var item=jsonDecode(element);
    //   if(item.toString().contains("result")){
    //     print("item"+item.toString());
    //   }
    //   else {
    //    // print(item["bids"].toString());
    //     double large_value = 0.0;
    //     double vallue1=0.0;
    //     double vallue2=0.0;
    //     p2pbuyAmountList.clear();
    //     p2pamountSellList.clear();
    //     for (int i = 0; i < item['bids'].length; i++) {
    //       vallue1=vallue1+double.parse(item['bids'][i][1].toString());
    //       vallue2=vallue2+double.parse(item['asks'][i][1].toString());
    //       p2pbuyAmountList.add(buyAmount(number:"0", price: double.parse(item['bids'][i][0].toString()).toString(), value: vallue1.toString(), percent:(vallue1/large_value).toString()));
    //       p2pamountSellList.add(amountSell(number:"0", price: double.parse(item['asks'][i][0].toString()).toString(), value: vallue2.toString(), percent:(vallue2/large_value).toString()));
    //      // print(vallue1.toString());
    //     }
    //     large_value = double.parse(p2pamountSellList[9].value) > double.parse(p2pbuyAmountList[9].value) ? double.parse(p2pamountSellList[9].value) : double.parse(p2pbuyAmountList[9].value);
    //     for (int i = 0; i < item['asks'].length; i++) {
    //       p2pbuyAmountList[i].percent = (double.parse(p2pbuyAmountList[i].value) / large_value).toString();
    //       p2pamountSellList[i].percent = (double.parse(p2pamountSellList[i].value) / large_value).toString();
    //     }
    //     notifyListeners();
    //   }
    // });
  }

  Future<void> gettradeChannel()async{
    listorderHistoryModel.clear();
    var jsonString = json.encode({
      'method': "SUBSCRIBE",
      'params': [
        'btcusdt'+'@trade',
      ],
      'id': 3,
    });
    print("nor" + jsonString.toString());
    final parmdic={
      "":"",
    };
    var response=await APIMainClass("/backend/public/api/p2p/get_trade_history/USDT", parmdic,"Get");
    var data=jsonDecode(response.body);
    if(data["status_code"]=="1"){
      if(data["data"].length>0){
        for(int i=0;i<data["data"].length;i++){
          listorderHistoryModel.add(orderHistoryModel(type:data["data"][i]["order_type"], price: data["data"][i]["price"].toString(),
              amount: data["data"][i]["quantity"].toString().split(".").first.toString(), date: DateFormat('MM/dd/yyyy').add_jms().format(DateTime.parse(data["data"][i]["created_at"],).toLocal(),).toString()
              ));
        }
        notifyListeners();
        // trade_channel.sink.add(jsonString);
        // trade_channel.stream.forEach((element) {
        //   var item=jsonDecode(element);
        //   print("trade>>"+item.toString());
        //   if(item.toString().contains("result")){
        //   }
        //   else{
        //     listorderHistoryModel.add(orderHistoryModel(date: item['T'] == null ? "" : DateTime.fromMillisecondsSinceEpoch(item['T']).toString().split(' ')[1],
        //         type: item['m'] == true ? "Buy":"Sell", price: item['p'] == null ? "" : Cr.format(double.parse(item['p'].toString())),
        //         amount: item['q'] == null ? "" : item['q'].toString()));
        //     notifyListeners();
        //   }
        // });
      }else{
        listorderHistoryModel.add(orderHistoryModel(type: "nodata", price: "price", amount: "amount", date: "date"));
        notifyListeners();
      }
    }else{
      listorderHistoryModel.add(orderHistoryModel(type: "error", price: "price", amount: "amount", date: "date"));
      notifyListeners();
      print("Error in api");
    }
    // trade_channel.sink.add(jsonString);
    // trade_channel.stream.forEach((element) {
    //   var item=jsonDecode(element);
    //   print("trade>>"+item.toString());
    //   if(item.toString().contains("result")){
    //   }
    //   else{
    //     listorderHistoryModel.add(orderHistoryModel(date: item['T'] == null ? "" : DateTime.fromMillisecondsSinceEpoch(item['T']).toString().split(' ')[1],
    //         type: item['m'] == true ? "Buy":"Sell", price: item['p'] == null ? "" : Cr.format(double.parse(item['p'].toString())),
    //         amount: item['q'] == null ? "" : item['q'].toString()));
    //     notifyListeners();
    //   }
    // });
  }

  List<orderHistoryModel> gettrade(){
    return listorderHistoryModel.toList();
  }
  
  Future<void> getBuyorder()async{
    networkService.P2PBuyOrder("/backend/public/api/p2p/get_buy_orders/USDT").then((value){
      print("data"+value.toString());
      p2pbuyAmountList.clear();
      for(int i=0;i<value.length;i++){
      p2pbuyAmountList.add(buyAmount(number:value[i]["user_xid"].toString(), price:double.parse(value[i]["price"].toString()).toString(), value: value[i]["quantity"].toString(), percent:"0",value1: "0"));
      }
      notifyListeners();
    });
    networkService.P2PBuyOrder("/backend/public/api/p2p/get_sell_orders/USDT").then((value){
      print("data 2"+value.toString());
      p2pamountSellList.clear();
      if(value.length>0) {
        for (int i = 0; i < value.length; i++) {
          p2pamountSellList.add(amountSell(
              number: value[i]["user_xid"].toString(),
              price: double.parse(value[i]["price"].toString()).toString(),
              value: value[i]["quantity"].toString(),
              percent: "0",
              valume1: "0"));
        }
      }else{
        print("data-------"+"2");
      }
      notifyListeners();
    });

    networkService.P2PBuyOrder("/backend/public/api/p2p/get_order_buy_volume/USDT").then((value){
      p2pbuyMarketDepthList.clear();
      print("data----"+value.toString());
      p2pbuyMarketDepthList.clear();
      for(int i=0;i<value.length;i++){
        p2pbuyMarketDepthList.add(buyMarketDepthAmount(number:value[i]["user_xid"].toString(), price:double.parse(value[i]["price"].toString()).toStringAsFixed(5), value: value[i]["quantity"].toString(), percent:"0",value1: "0"));
      }
      notifyListeners();
    });
    networkService.P2PBuyOrder("/backend/public/api/p2p/get_order_sell_volume/USDT").then((value){
      print("data---- 2"+value.toString());
      p2psellMarketDepthList.clear();
      for(int i=0;i<value.length;i++){
        p2psellMarketDepthList.add(sellMarketDepthAmount(number:value[i]["user_xid"].toString(), price:double.parse(value[i]["price"].toString()).toStringAsFixed(5), value: value[i]["quantity"].toString(), percent:"0",valume1: "0"));
      }
      notifyListeners();
    });
  }

  Future<void> getOpenOrder()async{
    openOrderP2p.clear();
    CompleteOrder.clear();
    print("Api Hit");
    networkService.getOpenOrder("/backend/public/api/p2p/remaining_orders").then((value){
      print("Value"+value.toString());
      openOrderP2p=value;
      notifyListeners();
    });
    networkService.getOpenOrder("/backend/public/api/p2p/completed_orders").then((value){
      CompleteOrder=value;
      notifyListeners();
    });
  }

  ScoketStop(){
    print("Close");
    if(channel_usdt !=null) {
      channel_usdt.sink.close();
      channel_usdt=IOWebSocketChannel.connect(
        Uri.parse('wss://stream.binance.com:9443/ws/stream?'),
      );
    } if(trade_channel !=null){
      trade_channel.sink.close();
      trade_channel=IOWebSocketChannel.connect(
        Uri.parse('wss://stream.binance.com:9443/ws/stream?'),
      );
    }
   // notifyListeners();
  }



  }