import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:investions/Constant/Nodata.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../Api/ApiCollections.dart';
import '../../Api/ApiMain.dart';
import '../../Api/MarketPageProvider.dart';
import '../../Constant/CommonClass.dart';
import '../Chart/ChartWidget.dart';

class favorite extends StatefulWidget {
  const favorite({Key? key}) : super(key: key);

  @override
  State<favorite> createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {

  List<CoinsData> favList=[];
  bool loading=true;
  bool nodata=false;
  WebSocketChannel channel_home = IOWebSocketChannel.connect(
    Uri.parse('wss://stream.binance.com:9443/ws/stream?'),
  );
  Future<void> connectToServer() async {
    var subRequest_usdthome = {
      'method': "SUBSCRIBE",
      'params': CommonClass.allTickerData,
      'id': 1,
    };
    print("param"+subRequest_usdthome.toString());
    var jsonString = await json.encode(subRequest_usdthome);
    channel_home.sink.add(jsonString);
  }
  void disConnectFromServer() {
    channel_home.sink.close();
  }
  @override
  void initState() {
    super.initState();
    getaddtofav();
  }
  Future<void> getaddtofav() async {
   try{
     CommonClass.favList.clear();
     final paramDic = {
       "": '',
     };
     var response = await APIMainClassbinance(ApiCollections.getaddtofav, paramDic, "Get");
     var data = json.decode(response.body);
     List favdata=[];
     if (response.statusCode == 200) {
       favdata = data['data'];
       print(favdata.toString());
       if(favdata.length>0){
         for (int i = 0; i <favdata.length; i++) {
           setState(() {
             favList.add(CoinsData(coinImage: favdata[i]["image"], coinName: favdata[i]["name"], coinShortName:favdata[i]["currency"],
                 coinPrice: favdata[i]["price"], coinPercentage: favdata[i]["change"], coinSymbol: favdata[i]["symbol"], coinPairWith: favdata[i]["pair_with"],
                 high: favdata[i]["high"], low: favdata[i]["low"], listed: favdata[i]["listed"].toString(),decimalPair:favdata[i]["decimal_pair"].toString()));
           });
         }
         setState(() {
           loading=false;
           nodata=false;
         });
         print("Done");
       }else{
         setState(() {
           loading=false;
           nodata=true;
         });
       }
     } else {
       setState(() {
         loading=false;
         nodata=true;
       });
       print("error");
     }
     connectToServer();
   }catch(e){
     setState(() {
       loading=false;
       nodata=true;
     });
     print("error");
   }
  }
  @override
  void dispose() {
    disConnectFromServer();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 4,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 20,),
                    Text("Market/", style: TextStyle(color: Theme
                        .of(context)
                        .textTheme
                        .headline3
                        ?.color, fontWeight: FontWeight.w700, fontSize: 9),),
                    SizedBox(width: 2,),
                    Text("Vol", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 9),),
                    Icon(Icons.arrow_upward, size: 10,
                      color:
                      Colors.green,),
                    Icon(Icons.arrow_downward, size: 10,
                      color:
                      Colors.green,),
                  ],
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Price", style: TextStyle(color: Theme
                        .of(context)
                        .textTheme
                        .headline3
                        ?.color, fontWeight: FontWeight.w600, fontSize: 9),),
                    SizedBox(width: 16,),
                    Text(
                      "Change", style: TextStyle(color: Theme
                        .of(context)
                        .textTheme
                        .headline3
                        ?.color, fontWeight: FontWeight.w600, fontSize: 9),),
                    SizedBox(width: 12,),
                  ],
                ),
              ],
            ),
            StreamBuilder(
                stream: channel_home.stream,
                builder: (context, snapshot) {
                  // if(snapshot.hasData !=true ){
                  //   return loading?Center(child: spinIndicator,):nodata?Nodata():ListView.builder(
                  //       padding: EdgeInsets.only(top: 8),
                  //       itemCount: favList.length,
                  //       shrinkWrap: true,
                  //       primary: false,
                  //       itemBuilder: (BuildContext context, int index) {
                  //         return DashboardList2(context, index,size,snapshot);
                  //       });
                  // }
                  return loading?Center(child: spinIndicator,):nodata?Nodata():ListView.builder(
                      padding: EdgeInsets.only(top: 8),
                      itemCount: favList.length,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (BuildContext context, int index) {
                        return DashboardList(context, index,size,snapshot);
                      });
                }
            )
          ],
        ),
      ),
    );
  }
  Widget DashboardList(BuildContext context, int i,Size size,snapshot) {
    if(snapshot.connectionState== ConnectionState.active && snapshot.hasData){
      var list=jsonDecode(snapshot.data);
      if(favList[i].coinSymbol == list['s'].toString()){
       // print(list.toString());
        favList[i].coinPrice=list["c"].toString();
        favList[i].coinPercentage=list["P"].toString();
      }else{
        // print("not");
        // print(list.toString());
      }
    }
    return Container(
      height: 52,
      //color: Colors.red,
      width:size.width,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            //  margin: EdgeInsets.only(top: 0,bottom: 6),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(0),),
              gradient: LinearGradient(
                colors: [Theme
                    .of(context)
                    .highlightColor,
                  Theme
                      .of(context)
                      .highlightColor
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 2.0, right: 4.0),
              child: InkWell(
                onTap:(){
                  // channel_home.sink.close();
                  Provider.of<market>(context,listen: false).getOrdervalume(favList[i].coinSymbol,favList[i].coinPairWith, favList[i].coinPairWith, favList[i].coinShortName);
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                      ChartWidget(
                        currency_data: {
                          "currency_name": favList[i].coinName,
                          "currency_shortName": favList[i].coinShortName,
                          "currency_Image":favList[i].coinImage,
                          "PRICE": favList[i].coinPrice,
                          "HIGHDAY": favList[i].high,
                          "LOWDAY": favList[i].low,
                          "VOL": "0.0",
                          "Symbol": favList[i].coinSymbol,
                          "24chng":favList[i].coinPercentage,
                          "listed":favList[i].listed,
                          "DecimalValue":favList[i].decimalPair,
                        },
                        pair:favList[i].coinPairWith,
                        familycoin: favList[i].coinPairWith,
                        family: favList[i].coinShortName,
                      )));
                  // Navigator.pushNamed(context, ChartWidget.id);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          child: Image.network(favList[i].coinImage.toString()),
                        ),
                        SizedBox(width: 6,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(favList[i].coinShortName.toString()+" / ", style: TextStyle(color: Theme
                                    .of(context)
                                    .textTheme
                                    .headline3
                                    ?.color, fontWeight: FontWeight.w700, fontSize: 12),),
                                Text(favList[i].coinPairWith.toString(), style: TextStyle(color: Theme
                                    .of(context)
                                    .textTheme
                                    .headline2
                                    ?.color, fontWeight: FontWeight.w700, fontSize: 10.5),),
                              ],
                            ),
                            Text(
                              favList[i].coinName.toString(), style: TextStyle(color: Theme
                                .of(context)
                                .textTheme
                                .headline3
                                ?.color, fontWeight: FontWeight.w500, fontSize: 8),),
                          ],
                        ),

                        SizedBox(width: 2,),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(favList[i].coinPrice
                                .replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), ""),
                              style: TextStyle(color: Theme
                                  .of(context)
                                  .textTheme
                                  .headline2
                                  ?.color,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10),),
                            // Text("\u20B9 " +widget.datalist.cointdata[i].coinPrice
                            //     .replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), ""),
                            //   style: TextStyle(color: Theme
                            //       .of(context)
                            //       .textTheme
                            //       .headline2
                            //       ?.color,
                            //       fontWeight: FontWeight.w700,
                            //       fontSize: 8),),

                          ],
                        ),

                        SizedBox(width: 10,),
                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                            //  color: Theme.of(context).buttonColor,
                            borderRadius: BorderRadius.all(Radius.circular(2.0)),
                            gradient: LinearGradient(colors: [
                              favList[i].coinPercentage.startsWith('-') ? Colors.red : Colors.green,
                              favList[i].coinPercentage.startsWith('-') ? Colors.red : Colors.green,
                            ],
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 2,),
                              Icon(favList[i].coinPercentage.startsWith('-')?
                              Icons.arrow_downward : Icons.arrow_upward, size: 12,
                                color:
                                Theme.of(context).textTheme.headline1?.color,),
                              SizedBox(width: 2,),
                              Text(favList[i].coinPercentage.toString()+"%",
                                style: TextStyle(color: Theme.of(context).textTheme.headline1?.color, fontSize: 10, fontWeight: FontWeight.w600),),
                              SizedBox(width: 2,),
                            ],

                          ),
                        ),

                        SizedBox(width: 2,),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
          Container(height: 1, color: Theme
              .of(context)
              .canvasColor,)
        ],
      ),
    );
  }
}
