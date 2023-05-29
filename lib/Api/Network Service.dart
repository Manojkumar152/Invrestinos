import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:investions/Api/ApiMain.dart';
import 'package:investions/Constant/ToastClass.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'ApiCollections.dart';
import 'package:http/http.dart' as http;

class NetworkService{
  Future<List<dynamic>> P2PBuyOrder(String Url)async{
    final parmDic={
      "":""
    };
     try{
       var response=await APIMainClass("$Url", parmDic,"Get");
       var data=jsonDecode(response.body);
       if(data["status_code"]=="1"){
         log("byerr-----"+data.toString());
         return data["data"];
       }else{
         log("byerr-----"+data.toString());
         return [];
       }
     }catch(e){
       print(e);
       return [];
     }
  }
  Future<List<dynamic>> getOpenOrder(String url)async{
    final paramDic={
      "":""
    };
    try{
      var response=await APIMainClass("$url", paramDic, "Get");
      var data=jsonDecode(response.body);
      print("Api data"+data.toString());
      if(data["status_code"].toString()=="1"){
        if(data["data"].length>0){
          return data["data"];
        }else{
          return ["No Data"];
        }
      }else{
        return ["No Data",data["message"]];
      }
    }catch(e){
      print(e.toString());
      return ["Error"];
    }
  }
  Future <dynamic> getOrderValue(String symbol,String family,String shortname)async{
    final paramDic={
      "":""
    };
    try{
      var uri;
      if(family=="INR"){
        uri=Uri.parse("https://"+ApiCollections.TradeUrl+"/list-crypto/market-data/"+shortname.toUpperCase()+"USDT");
      }else{
        uri= Uri.parse("https://"+ApiCollections.TradeUrl+"/list-crypto/market-data/"+symbol.toString().toUpperCase());
      }
      print("uri"+uri.toString());
      final res = await http.get(uri);
      var data = jsonDecode(res.body);
      if(data["status_code"]=="1"){
        print("API HIT");
        return data["data"];
      }else{
        return data["status_code"];
      }
    }catch(e){
      return ;
    }
  }

}