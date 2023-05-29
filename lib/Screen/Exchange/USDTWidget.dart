import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:investions/Api/MarketPageProvider.dart';
import 'package:investions/Screen/Chart/ChartWidget.dart';
import 'package:investions/Screen/Exchange/ExchangesWidget.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../Constant/CommonClass.dart';

class USDTWidget extends StatefulWidget {
 static const id ='USDTWidget';
 tabs datalist;

 USDTWidget(this.datalist);

  @override
  _USDTWidgetState createState() => _USDTWidgetState();
}

class _USDTWidgetState extends State<USDTWidget> {
  bool clickname=false;
  WebSocketChannel channel_home = IOWebSocketChannel.connect(
    Uri.parse('wss://stream.binance.com:9443/ws/stream?'),
  );
  Future<void> connectToServer() async {
    var subRequest_usdthome = {
      'method': "SUBSCRIBE",
      'params': widget.datalist.ticketlist,
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
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      if (CommonClass.usdtCoin.isEmpty) {
        await getRequest();
        print("false");
      } else {}
    });
    connectToServer();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      clickname==true?false:true;
                    });    
                    if(clickname==false){
                      print("Alpha");
                       widget.datalist.cointdata.sort((a,b)=>a.coinShortName.compareTo(b.coinShortName));
                    }else{
                      print("Rendom");
                      widget.datalist.cointdata.shuffle();
                    }
                  },
                  child: Padding(
                    padding:  EdgeInsets.only(top:4.0),
                    child: Row(
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
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top:4.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          print("clck");
                          widget.datalist.cointdata.sort((a,b)=>a.coinPrice.compareTo(b.coinPrice));
                        },
                        child: Text("Price", style: TextStyle(color: Theme
                            .of(context)
                            .textTheme
                            .headline3
                            ?.color, fontWeight: FontWeight.w600, fontSize: 9),),
                      ),
                      SizedBox(width: 30,),
                      GestureDetector(
                        onTap: (){
                          widget.datalist.cointdata.sort((a,b)=>a.coinPercentage.compareTo(b.coinPercentage));
                        },
                        child: Text(
                          "Change", style: TextStyle(color: Theme
                            .of(context)
                            .textTheme
                            .headline3
                            ?.color, fontWeight: FontWeight.w600, fontSize: 9),),
                      ),
                      SizedBox(width: 12,),
                    ],
                  ),
                ),
              ],
            ),
            StreamBuilder(
              stream: channel_home.stream,
              builder: (context, snapshot) {
                // if(snapshot.connectionState == ConnectionState.waiting){
                //   return
                // }
                if(snapshot.hasError){
                  return ListView.builder(
                      padding: EdgeInsets.only(top: 8),
                      itemCount: widget.datalist.cointdata.length,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (BuildContext context, int index) {
                        return DashboardList(context, index, size, snapshot);
                      });
                }else {
                  return ListView.builder(
                      padding: EdgeInsets.only(top: 8),
                      itemCount: widget.datalist.cointdata.length,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (BuildContext context, int index) {
                        return DashboardList(context, index, size, snapshot);
                      });
                }
              }
            )
          ],
        ),
      ),
    );

  }
  Widget DashboardList(BuildContext context, int i,Size size,snapshot) {
    var imgVariable;
    imgVariable= NetworkImage(widget.datalist.cointdata[i].coinImage.toString());
    if(snapshot.connectionState== ConnectionState.active && snapshot.hasData){
      var list=jsonDecode(snapshot.data);
      if(widget.datalist.cointdata[i].coinSymbol == list['s'].toString()){
        // print(list.toString());
        // print("USDT>>");
        widget.datalist.cointdata[i].coinPrice=list["c"].toString();
        widget.datalist.cointdata[i].coinPercentage=list["P"].toString();
      }else{
       // print("not  $i");
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
                  Provider.of<market>(context,listen: false).getOrdervalume(widget.datalist.cointdata[i].coinSymbol,widget.datalist.cointdata[i].coinPairWith, widget.datalist.cointdata[i].coinPairWith, widget.datalist.cointdata[i].coinShortName);
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                              ChartWidget(
                                currency_data: {
                                  "currency_name":  widget.datalist.cointdata[i].coinName,
                                  "currency_shortName": widget.datalist.cointdata[i].coinShortName,
                                  "currency_Image":widget.datalist.cointdata[i].coinImage,
                                  "PRICE": widget.datalist.cointdata[i].coinPrice,
                                  "HIGHDAY": widget.datalist.cointdata[i].high,
                                  "LOWDAY": widget.datalist.cointdata[i].low,
                                  "VOL": "0.0",
                                  "Symbol": widget.datalist.cointdata[i].coinSymbol,
                                  "24chng": widget.datalist.cointdata[i].coinPercentage,
                                  "listed":widget.datalist.cointdata[i].listed,
                                  "DecimalValue":widget.datalist.cointdata[i].decimalPair,
                                },
                                pair: widget.datalist.cointdata[i].coinPairWith,
                                familycoin: widget.datalist.cointdata[i].coinPairWith,
                                family: widget.datalist.cointdata[i].coinShortName,
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
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:imgVariable,
                              onError: (details,bnbj){
                                setState(() {
                                  imgVariable=AssetImage("assets/images/investinosName.png");
                                });
                              }
                            )
                          ),
                         // child: Image.network(widget.datalist.cointdata[i].coinImage.toString()),
                        ),
                        SizedBox(width: 8,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(widget.datalist.cointdata[i].coinShortName.toString()+" / ", style: TextStyle(color: Theme
                                    .of(context)
                                    .textTheme
                                    .headline3
                                    ?.color, fontWeight: FontWeight.w700, fontSize: 13),),
                                Text(widget.datalist.cointdata[i].coinPairWith.toString(), style: TextStyle(color: Theme
                                    .of(context)
                                    .textTheme
                                    .headline2
                                    ?.color, fontWeight: FontWeight.w700, fontSize: 11),),
                              ],
                            ),
                            Text(
                              widget.datalist.cointdata[i].coinName.toString(), style: TextStyle(color: Theme
                                .of(context)
                                .textTheme
                                .headline3
                                ?.color, fontWeight: FontWeight.w500, fontSize: 9),),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(widget.datalist.cointdata[i].coinPrice=="0"?"0":widget.datalist.cointdata[i].coinPrice.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), " "),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Theme.of(context).textTheme.headline2?.color, fontWeight: FontWeight.w700, fontSize: 12),),
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
                          width: 66,
                          decoration: BoxDecoration(
                            //  color: Theme.of(context).buttonColor,
                            borderRadius: BorderRadius.all(Radius.circular(2.0)),
                            gradient: LinearGradient(colors: [
                              widget.datalist.cointdata[i].coinPercentage.startsWith('-') ? Colors.red : Colors.green,
                              widget.datalist.cointdata[i].coinPercentage.startsWith('-') ? Colors.red : Colors.green,
                              ],
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 2,),
                              Icon(widget.datalist.cointdata[i].coinPercentage.startsWith('-')?
                              Icons.arrow_downward : Icons.arrow_upward, size: 12,
                                color:
                                Theme.of(context).textTheme.headline1?.color,),
                              SizedBox(width: 2,),
                              Text(widget.datalist.cointdata[i].coinPercentage.toString()+"%",
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
          Container(height: 1, color: Theme.of(context).canvasColor,)
        ],
      ),
    );
  }

}

class ExchnageCoinsList{
  String image ;
  String Name;
  String currency;
  String smallName;
  String number;
  String numberprice;
  Icon icon;
  String numberpercentage;


  ExchnageCoinsList(this.image, this.Name,this.currency, this.smallName, this.number,this.numberprice,
      this.icon, this.numberpercentage);
}