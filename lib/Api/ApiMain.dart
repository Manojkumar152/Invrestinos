// ignore_for_file: avoid_print, non_constant_identifier_names, file_names

import 'package:http/http.dart' as http;
import 'package:investions/Api/ApiCollections.dart';

import '../Constant/SharePerferarance.dart';
import 'ApiCollections.dart';

Future<http.Response> APIMainClass(
    String SubURL, Map<String, String> paramDic, String PostGet) async {
  String? token = await SharedPreferenceClass.GetSharedData("token");
  if (PostGet == "Get") {
    final uri = Uri.https(ApiCollections.P2pBaseUrl, SubURL, paramDic);
    print(uri);
    var response = await http.get(uri, headers: {"Authorization": "Bearer $token"});
    return response;
  } else {
    final uri = Uri.https(ApiCollections.P2pBaseUrl, SubURL);
    print("Post :" + uri.toString()+"$token");
    var response = await http.post(uri, body: paramDic,headers: {"Authorization": "Bearer $token"});
    return response;
  }
}

Future<http.Response> APIMainClassbinance(String SubURL, Map<String, String> paramDic, String PostGet) async {
  String? token = await SharedPreferenceClass.GetSharedData('token');

  //check the condition API post and get
  if (PostGet == "Get") {
    final uri = Uri.http(ApiCollections.NODELBM_BaseURL, SubURL, paramDic);
    print('Uri===>' + uri.toString());
    var response = await http.get(uri, headers: {"Accept": "application/json",
      "Authorization": "Bearer $token"});
    print('ApiMainClass Response==> ' +token.toString());
    return response;
  } else {
    final uri = Uri.http(ApiCollections.NODELBM_BaseURL, SubURL);
    print("Post :" + uri.toString());
    var response = await http.post(uri, body: paramDic, headers: {"Authorization": "Bearer $token"});
    return response;
  }
}

Future<http.Response> LBMAPIMainClass(
    String SubURL, Map<String, String> paramDic, String PostGet) async {
  String? token = await SharedPreferenceClass.GetSharedData("token");
  print("URIII" + token.toString());

  //check the condition API post and get
  if (PostGet == "Get") {
    final uri = Uri.http(ApiCollections.LBM_BaseURL, SubURL, paramDic,);
    print("URi>>>>"+uri.toString());
    var response = await http.get(uri, headers: {"Authorization": "Bearer $token"});
    return response;
  } else if (PostGet == "Delete") {
    final uri = Uri.http(ApiCollections.LBM_BaseURL, SubURL);
    var response = await http.delete(uri, headers: {"Authorization": "Bearer $token"});
    return response;
  } else if (PostGet == "Put") {
    final uri = Uri.http(ApiCollections.LBM_BaseURL, SubURL, paramDic);
    print("Put :" + uri.toString());
    var response =
    await http.put(uri, headers: {"Authorization": "Bearer $token"});
    return response;
  } else {
    final uri = Uri.http(ApiCollections.LBM_BaseURL, SubURL);
    print("Post :" + uri.toString());
    var response = await http.post(uri, body: paramDic, headers: {"Authorization": "Bearer $token"});
    return response;
  }
}

Future<http.Response> APIMainClassbanner(String SubURL, Map<String, String> paramDic, String PostGet) async {
  String? token = await SharedPreferenceClass.GetSharedData('token');

  //check the condition API post and get
  if (PostGet == "Get") {
    final uri = Uri.https(ApiCollections.LBM_BaseURL, SubURL, paramDic);
    print(uri);
    var response = await http.get(uri, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });
    print(response);
    return response;
  } else {
    final uri = Uri.https(ApiCollections.LBM_BaseURL, SubURL);
    print("Post :" + uri.toString());
    var response = await http
        .post(uri, body: paramDic, headers: {"Authorization": "Bearer $token"});
    return response;
  }
}

Future<http.Response> ServerMain(String SubURL, Map<String, String> paramDic, String PostGet) async {
  //check the condition API post and get
  if (PostGet == "Get") {
    final uri = Uri.https("server.bitqixnode.co.in", SubURL, paramDic);
    print(uri);
    var response = await http.get(uri);
    print(response);
    return response;
  } else {
    final uri = Uri.https(ApiCollections.listedcoinServer, SubURL);
    print("Post :" + uri.toString());
    var response = await http.post(uri, body: paramDic);
    return response;
  }
}
