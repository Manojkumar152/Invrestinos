import 'dart:convert';
import 'dart:io';

import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../Api/ApiCollections.dart';
import '../Api/ApiMain.dart';
import '../Screen/Exchange/ExchangesWidget.dart';
import 'MarketDeath_Moadal.dart';
import 'SharePerferarance.dart';


class CommonClass {
  static List<CoinsData> coinsData = [];
  static List allTickerData = [];
  static List CurrencyList=[];
  static List<CoinsData> usdtCoin=[];
  static List usdtTicker=[];
  static List<tabs> allCoinlist=[];
  static double rate=0.0;
  static List<CoinsData> favList=[];
  static List<orderHistoryModel> listorderHistoryModel=[];
  static List<buyAmount> p2pbuyAmountList=[];
  static List<amountSell> p2pamountSellList=[];
  static String pref_xid = "";
}

List marketData = [];
List<CoinsData> allCoinsList = [];
List currencyList = [];
List UsdtCoin=[];
List<CoinsData> coin2=[];

Future<void> getRequest() async {
  try {
    String url = "http://node.investinos.com/list-crypto/get?";
    final response = await http.get(Uri.parse(url));
    print(response.statusCode.toString());
    var data = json.decode(response.body);
    print('1');

    if (data['status_code'] == '1') {
      CommonClass.allTickerData.clear();
      CommonClass.coinsData.clear();
      CommonClass.usdtCoin.clear();
      CommonClass.usdtTicker.clear();
      CommonClass.CurrencyList.clear();
      currencyList.clear();
      allCoinsList.clear();
      UsdtCoin.clear();
      UsdtCoin=data["data"]["USDT"];
      // for (var i = 0; i < data['data'].keys.length; i++) {
      //   currencyList.add(data['data'].keys.elementAt(i).toString());
      //   if (data['data'].keys.elementAt(i).toString() == 'INR') {
      //   } else {
      //     for (var j = 0; j < data['data'][data['data'].keys.elementAt(i).toString()].length; j++) {
      //       allCoinsList.add(CoinsData(coinImage: data['data'][data['data'].keys.elementAt(i).toString()][j]['image'],
      //           coinName: data['data'][data['data'].keys.elementAt(i).toString()][j]['name'],
      //           coinShortName: data['data'][data['data'].keys.elementAt(i).toString()][j]['currency'],
      //           coinPrice: data['data'][data['data'].keys.elementAt(i).toString()][j]['price'],
      //           coinPercentage: data['data'][data['data'].keys.elementAt(i).toString()][j]['change'],
      //           coinSymbol: data['data'][data['data'].keys.elementAt(i).toString()][j]['symbol'],
      //           coinPairWith: data['data'][data['data'].keys.elementAt(i).toString()][j]['pair_with'],
      //           high: data['data'][data['data'].keys.elementAt(i).toString()][j]['high'],
      //           low: data['data'][data['data'].keys.elementAt(i).toString()][j]['low']));
      //     }
      //   }
      // }
      CommonClass.allCoinlist.clear();
      List ticker=[];

      CommonClass.allCoinlist.add(tabs("star",coin2,ticker));
      for(int i=0;i<data['data'].keys.length;i++){
        List Coustome=[];
        List<CoinsData> coin=[];
        List tickerlist=[];
        Coustome=data["data"][data['data'].keys.elementAt(i)];
        for(int  j=0;j<Coustome.length;j++){
          coin.add(CoinsData(coinImage: Coustome[j]["image"], coinName:  Coustome[j]["name"], coinShortName:  Coustome[j]["currency"], coinPrice:  Coustome[j]["price"],
              coinPercentage:  Coustome[j]["change"], coinSymbol:  Coustome[j]["symbol"], coinPairWith:  Coustome[j]["pair_with"],
              high:  Coustome[j]["high"], low:  Coustome[j]["low"],listed: Coustome[j]["listed"].toString(),decimalPair: Coustome[j]["decimal_pair"].toString()));
          tickerlist.add(Coustome[j]["symbol"].toString().toLowerCase()+'@ticker');
        }
        CommonClass.allCoinlist.add(tabs(data['data'].keys.elementAt(i).toString(), coin,tickerlist));
      }
      CommonClass.allCoinlist.add(tabs("P2P",coin2,ticker));


      // CommonClass.coinsData = allCoinsList;
      // CommonClass.CurrencyList=currencyList;


      for(int i=0;i<UsdtCoin.length;i++){
        CommonClass.usdtCoin.add(CoinsData(coinImage: UsdtCoin[i]["image"], coinName: UsdtCoin[i]["name"],
            coinShortName: UsdtCoin[i]["currency"], coinPrice:UsdtCoin[i]["price"], coinPercentage: UsdtCoin[i]["change"], coinSymbol: UsdtCoin[i]["symbol"],
            coinPairWith: UsdtCoin[i]["pair_with"], high:UsdtCoin[i]["high"], low:UsdtCoin[i]["low"],listed: UsdtCoin[i]["listed"].toString(),decimalPair: UsdtCoin[i]["decimal_pair"].toString()));
        CommonClass.usdtTicker.add(UsdtCoin[i]["symbol"].toString().toLowerCase()+"@ticker");
      }


      print('CommonData======>>>'+"  "+CommonClass.usdtCoin.length.toString()+"  "+ CommonClass.CurrencyList.length.toString()+"  " +CommonClass.allCoinlist.length.toString());
      marketData = data['tickers'];
      print('2');
      for (var element in marketData) {
        CommonClass.allTickerData.add(element.toString().toLowerCase() + '@ticker');
      }
      print('3');

      print('4');
    } else {
      print('failed');
    }
  } catch (e) {
    print('Get Request error' + e.toString());
  }
}


Future<void> getdata()async{
  final paramDic={
    "":""
  };
  var response=await APIMainClassbinance(ApiCollections.getuser, paramDic,"Get");
  var data=jsonDecode(response.body);
  print(data.toString());
  if(data["status_code"]=="1"){
    SharedPreferenceClass.SetSharedData("isLogin", "true");
    CommonClass.pref_xid = data['data']['pref_xid'];
  }else{
    SharedPreferenceClass.SetSharedData("isLogin", "false");
  }
}

SpinKitSquareCircle spinIndicator = SpinKitSquareCircle(
  color: Colors.white,
  size: 50.0,
);

Future<void> getaddtofav() async {
  CommonClass.favList.clear();
  final paramDic = {
    "": '',
  };
  var response = await APIMainClassbinance(ApiCollections.getaddtofav, paramDic, "Get");
  var data = json.decode(response.body);
  List favdata=[];
  if (response.statusCode == 200) {
    favdata = data['data'];
    for (int i = 0; i <favdata.length; i++) {
      CommonClass.favList.add(CoinsData(coinImage: favdata[i]["image"], coinName: favdata[i]["name"], coinShortName:favdata[i]["currency"],
          coinPrice: favdata[i]["price"], coinPercentage: favdata[i]["change"], coinSymbol: favdata[i]["symbol"], coinPairWith: favdata[i]["pair_with"],
          high: favdata[i]["high"], low: favdata[i]["low"], listed: favdata[i]["listed"].toString(),decimalPair:favdata[i]["decimal_pair"]));
    }
    print("Done");
  } else {
    print("error");
  }
}
File? UploadImage;

Future<http.Response> getuser() async {
  final paramDic = {
    "": '',
  };
  var response = await LBMAPIMainClass(ApiCollections.user, paramDic, "Get");
  return response;
}

class CoinsData {
  String coinImage;
  String coinName;
  String coinShortName;
  String coinPrice;
  String coinPercentage;
  String coinSymbol;
  String coinPairWith;
  String high;
  String low;
  String listed;
  String decimalPair;

  CoinsData({
    required this.coinImage,
    required this.coinName,
    required this.coinShortName,
    required this.coinPrice,
    required this.coinPercentage,
    required this.coinSymbol,
    required this.coinPairWith,
    required this.high,
    required this.low,
    required this.listed,
    required this.decimalPair
  });
}

Future<List<Candle>> fetchCandles({required String symbol, required String interval, required double rate,
      required String familycoin, required String listed}) async {
      final uri;
      List<Candle> candlist2=[];
        print("Listed Coin  not>>>>>>>+"+listed.toString());
        uri =Uri.parse("https://api.binance.com/api/v3/klines?symbol=$symbol&interval=$interval&limit=1000");
        print("URI>>>>>>>>>>>>>>>"+uri.toString());
        final res = await http.get(uri);
        var data = jsonDecode(res.body);
        return (jsonDecode(res.body) as List<dynamic>).map((e) => Candle.fromJson(e)).toList();
      print("URI>?>>>>>>>>>>>>>>>>>");
}
Future<List<Candle>> fetchCandles2({required String symbol, required String interval, required double rate,
  required String familycoin, required String listed}) async {
  final uri;
  List<Candle> candlist2=[];
    try{
      List fetchdata=[];
      print("Listed Coin>>>>>>>>>>>>>>>>>>>>>");
      uri =Uri.parse("https://${ApiCollections.NODELBM_BaseURL}/orders/getohlc?symbol=$symbol&interval=$interval&limit=1000");
      print("URI>>>>"+uri.toString());
      final res = await http.get(uri);
      var data = jsonDecode(res.body);
      print("data"+data.toString());
      fetchdata=data["data"];
      List<Candle> candlist=[];
      for(int i=0;i<fetchdata.length;i++){
        candlist.add(Candle(date:DateTime.fromMillisecondsSinceEpoch(fetchdata[i]["start_time"]), high: double.parse(fetchdata[i]["ohlc"]["h"]), low: double.parse(fetchdata[i]["ohlc"]["l"]),
            open: double.parse(fetchdata[i]["ohlc"]["o"]), close: double.parse(fetchdata[i]["ohlc"]["c"]), volume: double.parse(fetchdata[i]["ohlc"]["v"].toString())));
      }
      return candlist;
    }catch(e){
      return candlist2;
    }

  print("URI>?>>>>>>>>>>>>>>>>>");
}

// graph
Future<void> getRate() async {
  String uri = "https://${ApiCollections.NODELBM_BaseURL}/get-currency-price";
  var response = await http.get(Uri.parse(uri.toString()));
  var data = json.decode(response.body);
  if (response.statusCode == 200) {
    CommonClass.rate = data['rate'];
    print("RATE>>>>>");
  } else {
    //ToastMessage.showToast(context, data["message"], Colors.red);
  }
}
Future<void> gettrade(String symbol,String listed,String Shortname,String pair)async{
  CommonClass.listorderHistoryModel.clear();
  final uri;
  if(listed.toString()=="true"){
    final paramDic={
      "currency":Shortname.toString().toUpperCase(),
      "with_currency":pair.toString().toUpperCase(),
    };
     uri = Uri.http(ApiCollections.NODELBM_BaseURL, "/orders/trade-book", paramDic);
  }else{
    uri= Uri.parse("https://"+ApiCollections.TradeUrl+"/list-crypto/trade-history/"+symbol.toString().toUpperCase());
  }
  print("uri"+uri.toString());
  final res = await http.get(uri);
  var data = jsonDecode(res.body);
   NumberFormat Cr = new NumberFormat("#,##0.00", "en_US");
  if(data["status_code"] == "1"){
    List trade=data["data"];
    for(int i=0;i<trade.length;i++){
      if(listed.toString()=="true"){
        CommonClass.listorderHistoryModel.add(orderHistoryModel(date: DateTime.fromMillisecondsSinceEpoch(int.parse(trade[i]['T']))
                .toString()
                .split(' ')[1],
            price: Cr.format(double.parse(trade[i]['p'].toString())),
            amount: trade[i]['q'].toString(),
            type: trade[i]["m"].toString() == "true" ? "Buy" : "Sell"));
      }else {
        CommonClass.listorderHistoryModel.add(orderHistoryModel(
            date: DateTime.fromMillisecondsSinceEpoch(trade[i]['T'])
                .toString()
                .split(' ')[1],
            price: Cr.format(double.parse(trade[i]['p'].toString())),
            amount: trade[i]['q'].toString(),
            type: trade[i]["m"].toString() == "true" ? "Buy" : "Sell"));
      }
    }
    print("Done????");
  }
}
Future<String> getkyc()async{
  final paramDic={
    "":""
  };
  try{
    var response=await LBMAPIMainClass(ApiCollections.TwoFAuth, paramDic,"Get");
    var data=jsonDecode(response.body);
    print(data.toString());
      return data.toString();
  }catch(e){
    return "error";
  }
}
class CoinMarketData {
  var currency_data;
  var pair;
  var familycoin;

  CoinMarketData(
      {required this.currency_data,
        required this.pair,
        required this.familycoin});
}


