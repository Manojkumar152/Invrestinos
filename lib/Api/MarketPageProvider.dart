import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:investions/Api/Network%20Service.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../Constant/MarketDeath_Moadal.dart';

class market extends ChangeNotifier{
  WebSocketChannel marketChannel = IOWebSocketChannel.connect(
    Uri.parse('wss://stream.binance.com:9443/ws/stream?'),
  );
  NetworkService repositry=NetworkService();
  static NumberFormat Cr = new NumberFormat("#,##0.00", "en_US");
  List<buyAmount> buyAmountList=[];
  List<amountSell>sellAmountList=[];

 List<buyAmount> getbuyList(){
    return buyAmountList;
  }
  List<amountSell> getsellList(){
    return sellAmountList;
  }
  Future<void>getOrdervalume(String symbol,String pair,String familyCoin,String shortname)async{
    var jsonString;
    if (familyCoin == "INR") {
      jsonString = json.encode({
        'method': "SUBSCRIBE",
        'params': [
         shortname.toLowerCase() + 'usdt@depth10@1000ms',
        ],
        'id': 3,
      });
      print("SYM "+jsonString.toString());
    }
    else {
      jsonString = json.encode({
        'method': "SUBSCRIBE",
        'params': [
          symbol.toLowerCase() + '@depth10@1000ms',
        ],
        'id': 3,
      });
    }
    print(jsonString.toString());
    repositry.getOrderValue(symbol,familyCoin,shortname).then((value){
      buyAmountList.clear();
      sellAmountList.clear();
      print(value.toString());
      print("ApI data"+value.toString());
      List bids=[];
      List asks=[];
      bids=value["bids"];
      asks=value["asks"];
      double lastamount = 0.0;
      double lastamount1 = 0.0;
      double large_value = 5.0;
      for(int i=0;i<bids.length;i++){
        lastamount = lastamount + double.parse(bids[i][1].toString());
        lastamount1 = lastamount1 + double.parse(asks[i][1].toString());
        large_value = double.parse(lastamount1.toString()) > double.parse(lastamount.toString()) ? double.parse(lastamount1.toString()) : double.parse(lastamount.toString());
          buyAmountList.add(buyAmount(number:i.toString(), price:double.parse(bids[i][0].toString()).toString(), value:lastamount.toString(), percent:(lastamount/large_value).toString(),value1:double.parse(bids[i][1].toString()).toString()));
        sellAmountList.add(amountSell(number:i.toString(), price:double.parse(asks[i][0].toString()).toString(), value: lastamount1.toString(), percent:(lastamount1/large_value).toString(),valume1:double.parse(asks[i][1].toString()).toString()));
      }
       notifyListeners();
    });
    marketChannel.sink.add(jsonString);
    marketChannel.stream.forEach((element) {
         var item=jsonDecode(element);
         //print(item.toString());
        if(item.toString().contains("result")){
          print("item"+item.toString());
        }
        else {
         // print("item"+item.toString());
          double large_value = 0.0;
          double vallue1=0.0;
          double vallue2=0.0;
          buyAmountList.clear();
          sellAmountList.clear();
          for (int i = 0; i < item['bids'].length; i++) {
            vallue1=vallue1+double.parse(item['bids'][i][1].toString());
            vallue2=vallue2+double.parse(item['asks'][i][1].toString());
            buyAmountList.add(buyAmount(number:"0", price: double.parse(item['bids'][i][0].toString()).toString(), value: vallue1.toString(), percent:(vallue1/large_value).toString(),value1:double.parse(item['bids'][i][1].toString()).toString()));
            sellAmountList.add(amountSell(number:"0", price: double.parse(item['asks'][i][0].toString()).toString(), value: vallue2.toString(), percent:(vallue2/large_value).toString(),valume1:double.parse(item['asks'][i][1].toString()).toString()));
          }
          large_value = double.parse(buyAmountList[9].value) > double.parse(sellAmountList[9].value) ? double.parse(buyAmountList[9].value) : double.parse(sellAmountList[9].value);
          for (int i = 0; i < item['asks'].length; i++) {
            buyAmountList[i].percent = (double.parse(buyAmountList[i].value) / large_value).toString();
            sellAmountList[i].percent = (double.parse(sellAmountList[i].value) / large_value).toString();
          }
          notifyListeners();
        }
    });
}

SocketStop(){
   print("Close");
  if(marketChannel !=null) {
    marketChannel.sink.close();
    marketChannel=IOWebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws/stream?'),
    );
  }
}
}