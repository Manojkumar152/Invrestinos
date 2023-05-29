
import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:investions/Api/ApiCollections.dart';
import 'package:investions/Api/ApiMain.dart';
import 'package:investions/Api/MarketPageProvider.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:investions/Constant/SharedPreferenceClass.dart';
import 'package:investions/Screen/P2P/P2PBuySell_WidgetDialog.dart';
import 'package:k_chart/chart_style.dart';
import 'package:k_chart/entity/k_line_entity.dart';
import 'package:k_chart/k_chart_widget.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../Constant/CommonClass.dart';
import '../../Constant/ToastClass.dart';
import '../Exchange/Buy.dart';
import 'coinMarketTab.dart';


class ChartWidget extends StatefulWidget {
  static const id = 'ChartWidget';
  var currency_data;
  var pair;
  var familycoin;
  var family;

  ChartWidget(
      {required this.currency_data,
        required this.pair,
        required this.familycoin,
        required this.family,
        index});
  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> with TickerProviderStateMixin {
  late TabController _tabController;
  int ind = 0;
  bool visiblebool = false;
  double oldPrice = 0.0;

  bool isProgress = false;
  bool isChartProgress = false;
  bool isLine = true;
  bool expand = false;
  String selected = "1";
  String selected2 = "1m";

  int nextindex = 0;

  double currentprice_pre = 0.00;
  String Status = 'E';
  String Status_currentprice = 'E';

  List<dynamic> tickersList = [];
  List<Candle> candles = [];
  List<KLineEntity> datasKline = [];
  WebSocketChannel _channels = IOWebSocketChannel.connect(
    Uri.parse('wss://stream.binance.com:9443/ws'),
  );

  ChartStyle chartStyle = ChartStyle();
  ChartColors chartColors = ChartColors();

  bool fav = false;
  String status = '';
  List favdata = [];

   late SpinKitRotatingPlain spinIndicator;

  ///get INR price

  WebSocketChannel channel_home = IOWebSocketChannel.connect(
    Uri.parse('wss://stream.binance.com:9443/ws/stream?'),
  );

  Future<void> connectToServer() async {
    var subRequest_usdthome = {
      'method': "SUBSCRIBE",
      'params': [
        widget.currency_data["Symbol"].toLowerCase()+'@ticker'
      ],
      'id': 1,
    };
    print("param"+subRequest_usdthome.toString());
    var jsonString = json.encode(subRequest_usdthome);
    channel_home.sink.add(jsonString);
  }

  void disConnectFromServer() {
    channel_home.sink.close();
    _channels.sink.close();
  }

  String interval = "1m";

  int flagupdate = 0;

  void updateCandlesFromSnapshot(snapshot) async {

    if (snapshot.data != null) {
      final data = jsonDecode(snapshot.data as String) as Map<String, dynamic>;

      if (data.containsKey("k") == true && datasKline[datasKline.length - 1].time! < data["k"]["t"]) {
        if (widget.pair == "INR") {
          datasKline.add(KLineEntity.fromCustom(
              time: data["k"]["t"],
              amount:
              double.parse(data["k"]["h"].toString()) * CommonClass.rate,
              change: double.parse(data["k"]["v"].toString()),
              close: double.parse(data["k"]["c"].toString()) * CommonClass.rate,
              high: double.parse(data["k"]["h"].toString()) * CommonClass.rate,
              low: double.parse(data["k"]["l"].toString()) * CommonClass.rate,
              open: double.parse(data["k"]["o"].toString()) * CommonClass.rate,
              vol: double.parse(data["k"]["v"].toString()),
              ratio: double.parse(data["k"]["c"].toString())));
        } else {
          datasKline.add(KLineEntity.fromCustom(
              time: data["k"]["t"],
              amount: double.parse(data["k"]["h"].toString()),
              change: double.parse(data["k"]["v"].toString()),
              close: double.parse(data["k"]["c"].toString()),
              high: double.parse(data["k"]["h"].toString()),
              low: double.parse(data["k"]["l"].toString()),
              open: double.parse(data["k"]["o"].toString()),
              vol: double.parse(data["k"]["v"].toString()),
              ratio: double.parse(data["k"]["c"].toString())));
        }
      } else if (data.containsKey("k") == true) {
        if (widget.pair == "INR") {
          datasKline[datasKline.length - 1] = KLineEntity.fromCustom(
              time: data["k"]["t"],
              amount: double.parse(data["k"]["h"]) * CommonClass.rate,
              change: double.parse(data["k"]["v"].toString()),
              close: double.parse(data["k"]["c"]) * CommonClass.rate,
              high: double.parse(data["k"]["h"]) * CommonClass.rate,
              low: double.parse(data["k"]["l"]) * CommonClass.rate,
              open: double.parse(data["k"]["o"]) * CommonClass.rate,
              vol: double.parse(data["k"]["v"].toString()),
              ratio: double.parse(data["k"]["c"].toString()));
        } else {
          datasKline[datasKline.length - 1] = KLineEntity.fromCustom(
              time: data["k"]["t"],
              amount: double.parse(data["k"]["h"].toString()),
              change: double.parse(data["k"]["v"].toString()),
              close: double.parse(data["k"]["c"].toString()),
              high: double.parse(data["k"]["h"].toString()),
              low: double.parse(data["k"]["l"].toString()),
              open: double.parse(data["k"]["o"].toString()),
              vol: double.parse(data["k"]["v"].toString()),
              ratio: double.parse(data["k"]["c"].toString()));
        }
      }
    }
  }

  void binanceFetchcandle(String interval) {
    datasKline.clear();
    print("listed"+widget.currency_data.toString());
    if(widget.currency_data["listed"].toString() == "true"){
      fetchCandles2(
          symbol: widget.family.toUpperCase() + widget.pair.toString().toUpperCase(),
          interval: interval,
          familycoin: widget.pair,
          rate: CommonClass.rate,
          listed:widget.currency_data["listed"].toString())
          .then((value) => setState(() {
        this.interval = interval;
        candles = value;
        for (int i = 0; i < value.length; i++) {
          datasKline.add(KLineEntity.fromCustom(
              time: value[i].date.millisecondsSinceEpoch,
              amount: value[i].high,
              change: value[i].volume,
              close: value[i].close,
              high: value[i].high,
              low: value[i].low,
              open: value[i].open,
              vol: value[i].volume,
              ratio: value[i].low));
        }
      },
      ),
      );
      if (_channels != null) _channels.sink.close();
      _channels = WebSocketChannel.connect(Uri.parse('wss://server.zonox.io'),);
      _channels.sink.add(
        jsonEncode(
          {
            "method": "ADD",
            "params": [
              widget.family.toLowerCase()+widget.pair.toLowerCase() + "@kline_" + interval
            ],
          },
        ),
      );
    }
    else if (widget.pair == "INR") {
        fetchCandles(
            symbol: widget.family.toUpperCase() + "USDT",
            interval: interval,
            familycoin: widget.pair,
            rate: CommonClass.rate,
            listed: widget.currency_data["listed"].toString()).then((value) =>
            setState(() {
              this.interval = interval;
              nextindex = value.length;
              candles = value;
              for (int i = 0; i < value.length; i++) {
                datasKline.add(KLineEntity.fromCustom(
                    time: value[i].date.millisecondsSinceEpoch,
                    amount: value[i].high * CommonClass.rate,
                    change: value[i].volume,
                    close: value[i].close * CommonClass.rate,
                    high: value[i].high * CommonClass.rate,
                    low: value[i].low * CommonClass.rate,
                    open: value[i].open * CommonClass.rate,
                    vol: value[i].volume,
                    ratio: value[i].low * CommonClass.rate));
              }
            },
            ),
        );
        if (_channels != null) _channels.sink.close();
        _channels = IOWebSocketChannel.connect(
          Uri.parse('wss://stream.binance.com:9443/ws'),
        );
        _channels.sink.add(jsonEncode(
          {
            "method": "SUBSCRIBE",
            "params": [widget.family.toLowerCase() + "usdt@kline_" + interval],
            "id": 1
          },
        ),
        );
      }
      else {
        fetchCandles(
            symbol: widget.family.toUpperCase() +
                widget.pair.toString().toUpperCase(),
            interval: interval,
            familycoin: widget.pair,
            rate: CommonClass.rate,
            listed: widget.currency_data["listed"].toString())
            .then((value) =>
            setState(() {
              this.interval = interval;
              candles = value;
              for (int i = 0; i < value.length; i++) {
                datasKline.add(KLineEntity.fromCustom(
                    time: value[i].date.millisecondsSinceEpoch,
                    amount: value[i].high,
                    change: value[i].volume,
                    close: value[i].close,
                    high: value[i].high,
                    low: value[i].low,
                    open: value[i].open,
                    vol: value[i].volume,
                    ratio: value[i].low));
              }
            },
            ),
        );
        if (_channels != null) _channels.sink.close();
        _channels = WebSocketChannel.connect(
          Uri.parse('wss://stream.binance.com:9443/ws'),
        );
        _channels.sink.add(
          jsonEncode(
            {
              "method": "SUBSCRIBE",
              "params": [
                widget.family.toLowerCase() + widget.pair.toLowerCase() +
                    "@kline_" + interval
              ],
              "id": 1
            },
          ),
        );
      }

  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
    //   if(widget.currency_data["listed"].toString() == "true"){
    //     binanceFetchcandle("1m");
    //     connectToServer();
    //   }else{
    //     print("false");
    //     connectToServer();
    //     binanceFetchcandle("1m");
    //   }
    // });
    binanceFetchcandle("1m");;
    getShareddata();
    oldPrice = double.parse(widget.currency_data['PRICE']);
    connectToServer();
    getaddtofav();
    super.initState();
  }
  @override
  void didChangeDependencies() {
    if(widget.pair == "INR") {
      gettrade(widget.currency_data["currency_shortName"].toString()+"USDT",
          widget.currency_data["listed"].toString(),
          widget.currency_data["currency_shortName"],
          widget.familycoin.toString());
    }else{
      gettrade(widget.currency_data["Symbol"].toString(),
          widget.currency_data["listed"].toString(),
          widget.currency_data["currency_shortName"],
          widget.familycoin.toString());
    }
    super.didChangeDependencies();
  }
  @override
  void didUpdateWidget(covariant ChartWidget oldWidget) {
    print("Upadte");
    super.didUpdateWidget(oldWidget);
  }

  Future<void> addfev()async{
    final paramDic = {
      "currency": widget.family.toString(),
      "pair_with": widget.pair.toString(),
    };
    print(paramDic.toString());
    try{
      var response=await LBMAPIMainClass(ApiCollections.addtofav, paramDic, "Post");
      print(response.body.toString());
      var data = json.decode(response.body);
      if (data["status_code"] == "1") {
        ToastShowClass.toastShow(context, data['message'].toString(), Colors.blue);
        setState(() {
          fav = true;
        });
      } else {
        ToastShowClass.toastShow(context, data["message"], Colors.red);
      }

    }catch(e){
      print(e.toString());
    }
  }
  Future<void> getaddtofav() async {
    final paramDic = {
      "": '',
    };
    var response = await APIMainClassbinance(ApiCollections.getaddtofav, paramDic, "Get");
    var data = json.decode(response.body);
    favdata.clear();
    if (response.statusCode == 200) {
      print("SYMBOL"+widget.currency_data["Symbol"].toString());
      favdata = data['data'];
      for (int i = 0; i <favdata.length; i++) {
        if (favdata[i]['symbol'] == widget.currency_data["Symbol"].toString()) {
          print("SYMBOL"+widget.currency_data["Symbol"].toString()+"   "+favdata[i]['symbol'].toString());
        setState(() {
          fav = true;
        });
        }
        print("Done");
      }
    } else {
       // ToastShowClass.toastShow(context, data["message"], Colors.red);
    }
  }

  Future<void> Deletetofav(String id) async {
    final paramDic = {
      "": '',
    };
    print("id"+id.toString());
    var response = await LBMAPIMainClass(ApiCollections.deladdtofav+id, paramDic, "Delete");
    var data = json.decode(response.body);
    if (data["status_code"] == "1") {
      ToastShowClass.toastShow(context, data['message'].toString(), Colors.blue);
      setState(() {fav = false;});
    } else {
      ToastShowClass.toastShow(context, data["message"], Colors.red);
    }
  }


  getShareddata()async{
    status=await SharedPreferenceClass.GetSharedData("isLogin");
    setState(() {
      status=status;
    });
  }
  stop(){
    print('Stop');
    Provider.of<market>(context,listen: false).SocketStop();
    Navigator.of(context).pop();
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
      backgroundColor:Theme.of(context).backgroundColor,
      bottomSheet: BottomSheet(
        backgroundColor: Theme.of(context).cardColor,
        builder: (index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8,bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    // CommonClass.buyCoinSymbol = widget.currency_data["currency_shortName"];
                    // CommonClass.buyCoinName = widget.currency_data["currency_name"]; //for send data to next screen
                    // CommonClass.buyPrice = widget.currency_data['PRICE'];
                    // CommonClass.buyCoinImage = widget.currency_data['currency_Image'];
                    // CommonClass.buyCoinfamily = widget.pair.toString();
                    //Navigator.pushNamed(context, "/BuyBinance",);
                    if (status == 'true') {
                      showAnimatedDialog(
                          animationType: DialogTransitionType.slideFromBottom,
                          curve: Curves.easeOut,
                          barrierDismissible:true,
                          context: context, builder: (BuildContext context){
                        return Buy_Binace(data:CoinMarketData(currency_data: widget.currency_data,familycoin: widget.pair,pair: widget.family,),issell: false,);
                      });
                    }else{
                      ToastShowClass.toastShow(context, "You are not Login.Please login..",Colors.red);
                    }
                  },
                  child: Container(
                    height:35 ,
                      width: size.width*0.4,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Theme
                                .of(context)
                                .hoverColor.withOpacity(0.9),
                              Theme
                                  .of(context)
                                  .hoverColor.withOpacity(0.9)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(2)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Buy",textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).textTheme.headline1?.color,
                                fontSize: 11.0,fontWeight: FontWeight.w600
                            ),
                          ),
                        ],
                      ),
                    ),
                ),
                GestureDetector(
                  onTap: () {
                    if (status == 'true') {
                      showAnimatedDialog(
                          animationType: DialogTransitionType.slideFromBottom,
                          curve: Curves.easeOut,
                          barrierDismissible:true,
                          context: context, builder: (BuildContext context){
                        return Buy_Binace(data:CoinMarketData(currency_data: widget.currency_data,familycoin: widget.pair,pair: widget.family),issell: true,);
                      });
                    }else{
                      ToastShowClass.toastShow(context, "You are not Login.Please login..",Colors.red);
                    }
                  },
                  child: Container(
                    height:35 ,
                    width: size.width*0.4,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.redAccent,Colors.red
                          ],
                        ),
                        borderRadius: BorderRadius.circular(2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Sell",textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).textTheme.headline1?.color,
                              fontSize: 11.0,fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        onClosing: () {},
      ),
      body: SingleChildScrollView(
        child: WillPopScope(
          onWillPop: ()async{
            stop();
            return true;
          },
          child: Stack(
            children: [
              Container(
                height: size.height*0.4,
                width: size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/dashboard_headerImage.png'),
                      fit: BoxFit.fill,
                    )
                ),
                child:Padding(
                  padding: EdgeInsets.only(top: size.height*0.07,left: 10,right: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                       // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: (){
                                Provider.of<market>(context,listen: false).SocketStop();
                                Navigator.of(context).pop();
                              },
                              child: Icon(FontAwesomeIcons.arrowLeft,color:Colors.white,)),
                          SizedBox(width: 13,),
                          Text( widget.currency_data["currency_shortName"],style: TextStyle(color:Colors.white,
                              fontWeight: FontWeight.w500,fontSize: 13,letterSpacing: 0.1),),
                          Text("/"+widget.familycoin.toString(),style: TextStyle(color:Theme.of(context).indicatorColor,
                              fontWeight: FontWeight.w500,fontSize: 10,letterSpacing: 0.1),),
                          SizedBox(width: 6,),
                        //  Image.asset("assets/images/star.png")
                          InkWell(
                              onTap: () {
                                if (status == 'true') {
                                  if (fav == false) {
                                   // ToastShowClass.toastShow(context, "${widget.family} Adding", Colors.blue);
                                    addfev();
                                  } else {
                                    Deletetofav(widget.family.toString()+widget.pair.toString());
                                  }
                                } else {
                                  ToastShowClass.toastShow(context, "You're not Logged In!",  Colors.blue);
                                }
                              },
                              child: Icon(Icons.star,size: 16,color:fav ? Colors.yellow : Colors.white,)),
                        ],
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     if (status == 'true') {
                      //       if (fav == false) {
                      //         ToastShowClass.toastShow(context, "${widget.family} Adding", Colors.blue);
                      //         addfev();
                      //       } else {
                      //          Deletetofav(widget.family.toString()+widget.pair.toString());
                      //       }
                      //     } else {
                      //       ToastShowClass.toastShow(context, "You're not Logged In!",  Colors.blue);
                      //     }
                      //   },
                      //   child: Icon(Icons.star,size: 18,color:fav ? Colors.orangeAccent : Colors.white,),
                      // ),
                    ],
                  ),
                ),
              ),
              Container(
                width: size.width,
                height: size.height,
                margin:EdgeInsets.only(top: size.height*0.14,left: 16,right: 16),
                decoration: BoxDecoration(
                  color:Theme.of(context).cardColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),),
                  border:Border.all(color: Theme.of(context).focusColor.withOpacity(0.1)),
                ),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                      children: [
                        StreamBuilder(
                          stream:channel_home.stream,
                          builder: (context,snapshot) {
                              var list=jsonDecode(snapshot.data.toString());
                           //   print("List??"+list.toString());
                              if(list.toString() == "null"){}else{
                              if(widget.currency_data["Symbol"].toString().toUpperCase()== list['s'].toString()) {
                                widget.currency_data["PRICE"] = list["c"].toString();
                                widget.currency_data["24chng"] = list["P"].toString();
                              //  print("Chart>" + list.toString());
                              }
                              }
                            return Container(
                              height: size.height * 0.083,
                              width: size.width,
                              child: Padding(
                                padding:  EdgeInsets.only(left:18.0,right: 8.0,top: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Current Price",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,),),
                                        Text(widget.currency_data["PRICE"].toString(),
                                          style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,),),
                                      ],
                                    ),
                                    Container(
                                      height: 24,
                                      width: size.width*0.23,
                                      margin: EdgeInsets.only(right: 8.0,bottom: 10.0),
                                      decoration: BoxDecoration(
                                        color: ColorsCollectionsDark.markitlistgreen,
                                        borderRadius: BorderRadius.circular(2),
                                        gradient: LinearGradient(colors: [
                                          widget.currency_data["24chng"].toString().startsWith('-') ? Colors.red : ColorsCollectionsDark.markitlistgreen,
                                          widget.currency_data["24chng"].toString().startsWith('-') ? Colors.red :ColorsCollectionsDark.markitlistgreen,
                                        ],
                                      )),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon( widget.currency_data["24chng"].toString().startsWith('-')?
                                          Icons.arrow_downward : Icons.arrow_upward, size: 15, color: Theme.of(context).textTheme.headline1?.color,),
                                          SizedBox(width: 2,),
                                          Text( widget.currency_data["24chng"].toString()+"%",
                                            style: TextStyle(color: Theme.of(context).textTheme.headline1?.color, fontSize: 11, fontWeight: FontWeight.w600),),
                                        ],

                                      ),
                                    )
                                  ],
                                ),
                              ),

                            );
                          }
                        ),
                        Stack(
                          //alignment: Alignment.bottomCenter,
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: size.height *0.4,
                              // child:datasKline.isEmpty?Center(child:SizedBox(width: 25,height: 25,child: CircularProgressIndicator(color: Colors.amber),),):StreamBuilder(
                              child:StreamBuilder(
                                  stream: _channels.stream,
                                  builder: (context, snapshot) {
                                    // print("dataCandle"+snapshot.data.toString());
                                    if(snapshot.connectionState == ConnectionState.waiting){
                                      print("NOne????");
                                    return Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            //height: height * 0.44,
                                            child: KChartWidget(
                                              datasKline,
                                              chartStyle,
                                              chartColors,
                                              isLine: isLine,
                                              onSecondaryTap: () {
                                                print('Secondary Tap');
                                              },
                                              showInfoDialog: false,
                                              isTrendLine: false,
                                              mainState: MainState.NONE,
                                              volHidden: true,
                                              // secondaryState: SecondaryState.MACD,
                                              fixedLength: 2,
                                              timeFormat: TimeFormat.YEAR_MONTH_DAY,
                                              showNowPrice: true,
                                              //`isChinese` is Deprecated, Use `translations` instead.
                                              hideGrid: false,
                                              isTapShowInfoDialog: true,
                                              maDayList: [1, 100, 1000],
                                              // flingTime: 100,
                                              flingCurve: Curves.bounceInOut,
                                              //flingRatio: 0,
                                              //isOnDrag: () {},
                                            ),
                                          ),
                                        ],
                                      );;
                                    }
                                    if (snapshot.connectionState == ConnectionState.active && snapshot.hasData && snapshot.data != null) {
                                      updateCandlesFromSnapshot(snapshot);
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap:(){
                                                  binanceFetchcandle("$selected2");
                                              },
                                              child: Icon(Icons.refresh_outlined,color:Colors.amber,)),
                                              SizedBox(width: 30,),
                                              Container(
                                                height: 25,
                                              width: 80,
                                         margin: EdgeInsets.only(bottom: 10,right: 10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(color:  Colors.amber),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      isLine = !isLine;
                                                    });
                                                  },
                                                  child: Center(
                                                    child: Text(
                                                      isLine ? "  Candle  " : "  Line  ",
                                                      style: TextStyle(
                                                          color: Colors.amber,
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            //height: height * 0.44,
                                            child: KChartWidget(
                                              datasKline,
                                              chartStyle,
                                              chartColors,
                                              isLine: isLine,
                                              onSecondaryTap: () {
                                                print('Secondary Tap');
                                              },
                                              showInfoDialog: false,
                                              isTrendLine: false,
                                              mainState: MainState.NONE,
                                              volHidden: false,
                                              // secondaryState: SecondaryState.MACD,
                                              fixedLength: 2,
                                              timeFormat: TimeFormat.YEAR_MONTH_DAY,
                                              showNowPrice: true,
                                              //`isChinese` is Deprecated, Use `translations` instead.
                                              hideGrid: false,
                                              isTapShowInfoDialog: true,
                                              maDayList: [1, 100, 1000],
                                              // flingTime: 100,
                                              flingCurve:
                                              Curves.bounceInOut,
                                              //flingRatio: 0,
                                              //isOnDrag: () {},
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    else {
                                      return Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            //height: height * 0.44,
                                            child: KChartWidget(
                                              datasKline,
                                              chartStyle,
                                              chartColors,
                                              isLine: isLine,
                                              onSecondaryTap: () {
                                                print('Secondary Tap');
                                              },
                                              showInfoDialog: false,
                                              isTrendLine: false,
                                              mainState: MainState.NONE,
                                              volHidden: true,
                                              // secondaryState: SecondaryState.MACD,
                                              fixedLength: 2,
                                              timeFormat: TimeFormat.YEAR_MONTH_DAY,
                                              showNowPrice: true,
                                              //`isChinese` is Deprecated, Use `translations` instead.
                                              hideGrid: false,
                                              isTapShowInfoDialog: true,
                                              maDayList: [1, 100, 1000],
                                              // flingTime: 100,
                                              flingCurve: Curves.bounceInOut,
                                              //flingRatio: 0,
                                              //isOnDrag: () {},
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  }),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: size.height*0.32,left: 25,right: 25),
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(4),),
                                gradient: LinearGradient(
                                  colors: [Theme
                                      .of(context)
                                      .hintColor.withOpacity(1),
                                    Theme
                                        .of(context)
                                        .hintColor.withOpacity(1)
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding:  EdgeInsets.only(top:4.0,bottom: 4.0,left: 5,right: 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap:(){
                                        binanceFetchcandle("1m");
                                        selected = "1";
                                        selected2='1m';
                                        },
                                      child: Container(
                                        width:30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(3),),
                                           color:selected == "1"?Theme.of(context).shadowColor.withOpacity(1):Theme.of(context).focusColor.withOpacity(0.3),
                                        ),
                                        padding: EdgeInsets.all(4),
                                        child: Center(
                                          child:  Text("1m",
                                            style: TextStyle(color: Theme.of(context).textTheme.headline1?.color,
                                              fontSize: 8,
                                              fontWeight: FontWeight.w600,),),
                                        ),),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        binanceFetchcandle("5m");
                                        selected = "2";
                                        selected2='5m';
                                      },
                                      child: Container(
                                        width:30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(3),),
                                          color:selected == "2"?Theme.of(context).shadowColor.withOpacity(1):Theme.of(context).focusColor.withOpacity(0.3),
                                        ),
                                        padding: EdgeInsets.all(4),
                                        child: Center(
                                          child:  Text("5m",
                                            style: TextStyle(color: Theme.of(context).textTheme.headline1?.color,
                                              fontSize: 8,
                                              fontWeight: FontWeight.w600,),),
                                        ),),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        binanceFetchcandle("15m");
                                        selected = "3";
                                        selected2='15m';
                                      },
                                      child: Container(
                                        width:30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(3),),
                                          color:selected == "3"?Theme.of(context).shadowColor.withOpacity(1):Theme.of(context).focusColor.withOpacity(0.3),
                                          // gradient: LinearGradient(
                                          //   colors: [Theme
                                          //       .of(context)
                                          //       .focusColor.withOpacity(0.3),
                                          //     Theme
                                          //         .of(context)
                                          //         .focusColor.withOpacity(0.3)
                                          //   ],
                                          // ),
                                        ),
                                        padding: EdgeInsets.all(4),
                                        child: Center(
                                          child:  Text("15m",
                                            style: TextStyle(color: Theme.of(context).textTheme.headline1?.color,
                                              fontSize: 8,
                                              fontWeight: FontWeight.w600,),),
                                        ),),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        binanceFetchcandle("30m");
                                        selected = "4";
                                        selected2='30m';
                                      },
                                      child: Container(
                                        width:30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(3),),
                                          color:selected == "4"?Theme.of(context).shadowColor.withOpacity(1):Theme.of(context).focusColor.withOpacity(0.3),
                                        ),
                                        padding: EdgeInsets.all(4),
                                        child: Center(
                                          child:  Text("30m",
                                            style: TextStyle(color: Theme.of(context).textTheme.headline1?.color,
                                              fontSize: 8,
                                              fontWeight: FontWeight.w600,),),
                                        ),),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        binanceFetchcandle("1h");
                                        selected = "5";
                                        selected2='1h';
                                      },
                                      child: Container(
                                        width:30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(3),),
                                          color:selected == "5"?Theme.of(context).shadowColor.withOpacity(1):Theme.of(context).focusColor.withOpacity(0.3),
                                        ),
                                        padding: EdgeInsets.all(4),
                                        child: Center(
                                          child:  Text("1h",
                                            style: TextStyle(color: Theme.of(context).textTheme.headline1?.color,
                                              fontSize: 8,
                                              fontWeight: FontWeight.w600,),),
                                        ),),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                        onTap: (){
                                          binanceFetchcandle("2h");
                                          selected = "6";
                                          selected2='2h';
                                        },
                                      child: Container(
                                        width:30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(3),),
                                          color:selected == "6"?Theme.of(context).shadowColor.withOpacity(1):Theme.of(context).focusColor.withOpacity(0.3),
                                        ),
                                        padding: EdgeInsets.all(4),
                                        child: Center(
                                          child:  Text("2h",
                                            style: TextStyle(color: Theme.of(context).textTheme.headline1?.color,
                                              fontSize: 8,
                                              fontWeight: FontWeight.w600,),),
                                        ),),
                                    ),
                                    SizedBox(width: 5,),
                                    // Container(
                                    //   width:30,
                                    //   padding: EdgeInsets.all(5),
                                    //   child: Center(
                                    //     child:  Image.asset("assets/images/group_chart.png"),
                                    //   ),),
                                    // SizedBox(
                                    //   width: 5,
                                    // ),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                    SizedBox(height: 30,),
                        Container(
                          child: CoinMarketTabBar(
                            familyCoin: widget.pair,
                            symbol: widget.currency_data['Symbol'].toString(),
                            rate: CommonClass.rate,
                            pairCoin: widget.family,
                            highDay: widget.currency_data['HIGHDAY'] == null ? ""
                                : widget.currency_data['HIGHDAY'].toString(),
                            lowDay: widget.currency_data['LOWDAY'] == null ? "" : widget.currency_data['LOWDAY'].toString(),
                            listed: widget.currency_data["listed"].toString(),
                            Shortname:widget.currency_data['currency_shortName'].toString(),
                          ),
                        ),

                      ],
                    ),
                ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
