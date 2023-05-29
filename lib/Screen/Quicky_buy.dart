
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:investions/Constant/IntenetError.dart';
import 'package:investions/Constant/SharedPreferenceClass.dart';
import 'package:investions/Constant/ToastClass.dart';
import 'package:investions/Screen/Setting/AppearanceWidget.dart';
import 'package:investions/Screen/Wallet/Funds.dart';
import 'package:investions/Screen/P2P/peerTopeerComplete.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../Api/MarketPageProvider.dart';
import '../Constant/CommonClass.dart';
import '../Constant/Error_Screen.dart';
import 'Chart/ChartWidget.dart';
import 'CurrencyPerference.dart';
import 'Exchange/ExchangesWidget.dart';
import 'Credential Screen/ForgotPassword.dart';
import 'Credential Screen/LoginWidget.dart';
import 'Order/OrderWidget.dart';
import 'P2P/P2Pbuy_sell.dart';
import 'Setting/SettingWidget.dart';


class Quick_buy extends StatefulWidget {
  static const id = 'Quick_buy';
  p2pdata? data;
  Quick_buy(this.data);

  @override
  State<Quick_buy> createState() => _Quick_buyState();
}

class _Quick_buyState extends State<Quick_buy> {

  int selectedIndex = 0;
  int _currentPage = 0;
  String? login;
  static const int totalPage = 4;
  List <BottomImageIcons> bottomImageList =  [
    BottomImageIcons("assets/images/quick_buy.png", 'Home'),
    BottomImageIcons("assets/images/exchange.png", 'Exchanges'),
    BottomImageIcons("assets/images/my_orders.png", 'Orders'),
    BottomImageIcons("assets/images/fund.png", 'Funds'),
  ];
  List widgets = [getDashboard(),ExchangesWidget(),OrderWidget(),Funds()];
  List widgets2 = [getDashboard(),ExchangesWidget(),LoginWidget(),LoginWidget()];
  @override
  void initState() {
    getShared();
    setState(() {
      selectedIndex=widget.data!.index;
      _currentPage=widget.data!.page;
    });
    super.initState();
  }
  getShared()async{
    login=await SharedPreferenceClass.GetSharedData("isLogin");
    setState(() {
      login=login;
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body:login.toString() == "true"?widgets[_currentPage]:widgets2[_currentPage],
      bottomNavigationBar: _getBottomBar(size),
    );
  }

  Widget _getBottomBar(Size size) {
    return BottomNavigationBar(
        currentIndex: _currentPage,
        backgroundColor: Theme.of(context).errorColor,
        onTap: (index) {
          // _currentPage = index;
          print(index.toString());
          setState(() {
            _currentPage = index;
          });
          print(_currentPage.toString());
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 10),
        unselectedLabelStyle: TextStyle(fontSize: 10),
        items: List.generate(totalPage,
                (index) => BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(bottomImageList[index].imageIcon.toString())),
               label:  bottomImageList[index].imageName.toString(),
                ),
            )
    );


  }
}
class getDashboard extends StatefulWidget {
  const getDashboard({Key? key}) : super(key: key);

  @override
  _getDashboardState createState() => _getDashboardState();
}


class _getDashboardState extends State<getDashboard> {
  String? login;
  int val = -1;
  bool error=false;
  List<CoinsData> list_default=[];
  WebSocketChannel channel_home = IOWebSocketChannel.connect(
    Uri.parse('wss://stream.binance.com:9443/ws/stream?'),
  );
  Future<void> connectToServer() async {
    var subRequest_usdthome = {
      'method': "SUBSCRIBE",
      'params': CommonClass.usdtTicker,
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
    getShared();
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      if (CommonClass.usdtCoin.isEmpty) {
        await getRequest().timeout(Duration(seconds: 5)).then((value) {
          setState(() {
            error=true;
          });
        });
      } else {
        setState(() {
          error=false;
        });
      }
    });
    connectToServer();
    setState(() {
      list_default.addAll(CommonClass.usdtCoin.toList());
    });
    getRate();
    print(list_default.length);
  }
  getShared()async{
    login=await SharedPreferenceClass.GetSharedData("isLogin");
    setState(() {
      login=login;
    });
  }
  @override
  void didUpdateWidget(covariant getDashboard oldWidget) {
    connectToServer();
    print("Upadte");
    super.didUpdateWidget(oldWidget);
  }
  @override
  void dispose() {
    disConnectFromServer();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return  SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: size.height*0.37,
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/dashboard_headerImage.png'),
                fit: BoxFit.fill,

              ),

            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 40, left: 12.0, right: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap:(){
                          if(login.toString() == "true") {
                            Navigator.pushNamed(context, SettingWidget.id);
                          }else{
                            ToastShowClass.toastShowerror(context,"You are not Login.Please login..", Colors.red);
                          }
      },
                        child: Icon(Icons.manage_accounts_rounded, color: Theme
                            .of(context)
                            .textTheme
                            .headline1
                            ?.color, size: 25,),
                      ),
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/investinosName.png')
                            )
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          //Navigator.pushNamed(context, Currency_Perference.id);
                        },
                        child: Icon(FontAwesomeIcons.indianRupeeSign, color: Theme
                            .of(context)
                            .textTheme
                            .headline1
                            ?.color, size: 20,),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Text("Welcome to Investinos",
                    style: TextStyle(color: Theme
                        .of(context)
                        .textTheme
                        .headline1
                        ?.color,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2)),
                SizedBox(height: 10,),
                Text("Buy Your First Cryptocurrency Today",
                  style: TextStyle(color: Theme
                      .of(context)
                      .textTheme
                      .headline1
                      ?.color, fontSize: 8),),
                SizedBox(height: 14,),
                // InkWell(
                //   onTap: () {},
                //   child: Container(
                //     height: 30,
                //     width: 120,
                //     decoration: BoxDecoration(
                //       //  color: Theme.of(context).buttonColor,
                //       borderRadius: BorderRadius.all(
                //           Radius.circular(2.0)),
                //       gradient: LinearGradient(
                //         colors: [Theme
                //             .of(context)
                //             .buttonColor, Theme
                //             .of(context)
                //             .buttonColor
                //         ],
                //       ),
                //     ),
                //
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Text("Get Started ", style: TextStyle(color: Theme
                //             .of(context)
                //             .textTheme
                //             .headline1
                //             ?.color, fontSize: 10),),
                //         Icon(Icons.arrow_forward, size: 14, color: Theme
                //             .of(context)
                //             .textTheme
                //             .headline1
                //             ?.color,)
                //       ],
                //     ),
                //   ),
                // ),

              ],
            ),
          ),
          Card(
            margin:EdgeInsets.only(top: size.height*0.3, left: 16.0, right: 16.0),
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: size.width,
                    decoration: BoxDecoration(
                      //  color: Theme.of(context).buttonColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      gradient: LinearGradient(
                        colors: [Theme
                            .of(context)
                            .hintColor, Theme
                            .of(context)
                            .hintColor
                        ],
                      ),

                    ),

                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween,
                        children: [
                          Text("POPULAR COINS", style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Theme
                                  .of(context)
                                  .textTheme
                                  .headline2
                                  ?.color),),
                          GestureDetector(
                            onTap: (){
                              showModalBottomSheet(
                                  shape:RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),topRight:Radius.circular(20),
                                    ),
                                  ) ,
                                  context: context, builder: (builder){
                                    return Container(
                                      height: 260,
                                      decoration:BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8,top: 8,right: 8),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width:size.width*0.8,
                                                  //color: Colors.redAccent,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("Sort By",style: TextStyle(color: ColorsCollectionsDark.buttoncolorsMostTrade,fontSize: 15,fontWeight: FontWeight.w600),),
                                                      InkWell(
                                                        onTap: (){
                                                          setState(() {
                                                         // CommonClass.usdtCoin.shuffle(Random(1));
                                                            CommonClass.usdtCoin.clear();
                                                            CommonClass.usdtCoin.addAll(list_default.toList());
                                                            Navigator.of(context).pop();
                                                          });
                                                        },
                                                          child: Text("SET TO DEFAULT",style: TextStyle(color: ColorsCollectionsDark.greenlightColor,fontSize: 13,fontWeight: FontWeight.w700),)),
                                                    ],
                                                  ),
                                                ),
                                                IconButton(onPressed: (){
                                                  Navigator.of(context).pop();
                                                },
                                                    icon:Icon(Icons.clear_rounded,color:ColorsCollectionsDark.greenlightColor,)),
                                              ],
                                            ),
                                            Divider(color:ColorsCollectionsDark.buttoncolorsMostTrade,height:5,thickness: 0.8,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text( "Highest Price",
                                                  style: TextStyle(color: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .headline2
                                                      ?.color,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600,),),
                                                Radio(
                                                  value:1,
                                                  groupValue: val,
                                                  splashRadius: 10,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      CommonClass.usdtCoin.sort((a,b)=>b.coinPrice.compareTo(a.coinPrice));
                                                      val = int.parse(value.toString());
                                                      Navigator.of(context).pop();

                                                    });
                                                  },
                                                  activeColor: Colors.green,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text( "Low Price",
                                                  style: TextStyle(color: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .headline2
                                                      ?.color,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600,),),
                                                Radio(
                                                  value:2,
                                                  groupValue: val,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      CommonClass.usdtCoin.sort((a,b)=>a.coinPrice.compareTo(b.coinPrice));
                                                      val = int.parse(value.toString());
                                                      Navigator.of(context).pop();

                                                    });
                                                  },
                                                  activeColor: Colors.green,
                                                ),
                                              ],
                                            ),
                                            Divider(color:ColorsCollectionsDark.buttoncolorsMostTrade,height: 5,thickness: 0.7,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Top Losers",
                                                  style: TextStyle(color: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .headline2
                                                      ?.color,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600,),),
                                                Radio(
                                                  value:3,
                                                  groupValue: val,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      CommonClass.usdtCoin.sort((a,b)=>a.coinPercentage.compareTo(b.coinPercentage));
                                                      val = int.parse(value.toString());
                                                      Navigator.of(context).pop();

                                                    });
                                                  },
                                                  activeColor: Colors.green,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Top Gainer",
                                                  style: TextStyle(color: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .headline2
                                                      ?.color,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600,),),
                                                Radio(
                                                  value:4,
                                                  groupValue: val,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      CommonClass.usdtCoin.sort((a,b)=>b.coinPercentage.compareTo(a.coinPercentage));
                                                      val = int.parse(value.toString());
                                                      Navigator.of(context).pop();

                                                    });
                                                  },
                                                  activeColor: Colors.green,
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    );
                              });
                            },
                            child: Container(
                              height: 25,
                              width: 100,
                              // color: Theme.of(context).cardColor,
                              decoration: BoxDecoration(
                                color: Theme
                                    .of(context)
                                    .bottomAppBarColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),),
                                // gradient: LinearGradient(
                                //   colors: [Theme.of(context).cardColor, Theme.of(context).cardColor],
                                // ),

                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround,
                                children: [
                                  Icon(
                                    Icons.filter_list_outlined, size: 20,
                                    color: Theme
                                        .of(context)
                                        .textTheme
                                        .headline4
                                        ?.color,),
                                  Text("Flitter Traded ", style: TextStyle(
                                      fontSize: 10, color: Theme
                                      .of(context)
                                      .textTheme
                                      .headline4
                                      ?.color),),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  error==true?Container(height: size.height*0.6,width:size.width,child: CustomError()):StreamBuilder(
                    stream: channel_home.stream,
                    builder: (context,snapshot) {
                      if(CommonClass.usdtCoin.isEmpty){
                       return Center(child: CircularProgressIndicator(color: Colors.orangeAccent),);
                      }
                      else if(snapshot.connectionState==ConnectionState.waiting){
                        print("Waiting??????????");
                        return ListView.builder(
                            padding: EdgeInsets.only(top: 8),
                            itemCount: CommonClass.usdtCoin.length,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (BuildContext context, int index) {
                              return DashboardList(context, index,snapshot);
                            });
                      }else if(snapshot.hasError){
                        return ListView.builder(
                            padding: EdgeInsets.only(top: 8),
                            itemCount: CommonClass.usdtCoin.length,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (BuildContext context, int index) {
                              return DashboardList(context, index,snapshot);
                            });
                      }else {
                        return ListView.builder(
                            padding: EdgeInsets.only(top: 8),
                            itemCount: CommonClass.usdtCoin.length,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (BuildContext context, int index) {
                              return DashboardList(context, index, snapshot);
                            });
                      }
                    }
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget DashboardList(BuildContext context, int i,snapshot) {
    if(snapshot.connectionState== ConnectionState.active && snapshot.hasData){
      var list=jsonDecode(snapshot.data);
      if(CommonClass.usdtCoin[i].coinSymbol == list['s'].toString()){
      //  print(list.toString());
        CommonClass.usdtCoin[i].coinPrice=list["c"].toString();
        CommonClass.usdtCoin[i].coinPercentage=list["P"].toString();
      }else{
        // print("not");
        // print(list.toString());
      }
    }
    return SizedBox(
      height: 52,
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              Provider.of<market>(context,listen: false).getOrdervalume(CommonClass.usdtCoin[i].coinSymbol,CommonClass.usdtCoin[i].coinPairWith, CommonClass.usdtCoin[i].coinPairWith, CommonClass.usdtCoin[i].coinShortName);
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                  ChartWidget(
                    currency_data: {
                      "currency_name":CommonClass.usdtCoin[i].coinName,
                      "currency_shortName": CommonClass.usdtCoin[i].coinShortName,
                      "currency_Image":CommonClass.usdtCoin[i].coinImage,
                      "PRICE": CommonClass.usdtCoin[i].coinPrice,
                      "HIGHDAY": CommonClass.usdtCoin[i].high,
                      "LOWDAY": CommonClass.usdtCoin[i].low,
                      "VOL": "0.0",
                      "Symbol": CommonClass.usdtCoin[i].coinSymbol,
                      "24chng":CommonClass.usdtCoin[i].coinPercentage,
                      "listed":CommonClass.usdtCoin[i].listed,
                      "DecimalValue":CommonClass.usdtCoin[i].decimalPair,
                    },
                    pair:CommonClass.usdtCoin[i].coinPairWith,
                    familycoin: CommonClass.usdtCoin[i].coinPairWith,
                    family: CommonClass.usdtCoin[i].coinShortName,
                  )));
            },
            child: Container(
              height: 45,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              //  margin: EdgeInsets.only(top: 0,bottom: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(0),),
                gradient: LinearGradient(
                  colors: [Theme
                      .of(context)
                      .highlightColor, Theme
                      .of(context)
                      .highlightColor
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 0.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          child: Image.network(CommonClass.usdtCoin[i].coinImage.toString()),
                        ),
                        SizedBox(width: 8,),
                        Text(CommonClass.usdtCoin[i].coinShortName.toString(), style: TextStyle(color: Theme
                            .of(context)
                            .textTheme
                            .headline2
                            ?.color, fontWeight: FontWeight.w700, fontSize: 12),),
                        Text("/",style:TextStyle(color: Theme.of(context).indicatorColor,fontSize: 8),),
                        SizedBox(width: 2,),
                        Text(
                          CommonClass.usdtCoin[i].coinPairWith, style: TextStyle(color: Theme
                            .of(context)
                            .textTheme
                            .headline3
                            ?.color, fontWeight: FontWeight.w500, fontSize: 8),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(CommonClass.usdtCoin[i].coinPrice
                                .replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), ""),
                              style: TextStyle(color: Theme
                                  .of(context)
                                  .textTheme
                                  .headline2
                                  ?.color,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10),),
                            SizedBox(height: 4,),
                            Container(
                              height: 1,
                              width: 40,
                              color: Theme
                                  .of(context)
                                  .hintColor,
                            ),
                            SizedBox(height: 2,),
                            Row(
                              children: [
                                CommonClass.usdtCoin[i].coinPercentage.startsWith('-')
                                    ? Icon(
                                    Icons.arrow_downward,
                                    color:Colors.red,
                                    size: 12
                                )
                                    : Icon(
                                    Icons.arrow_upward,
                                    color: Colors.green,size: 12
                                ),
                                SizedBox(width: 2,),
                                Text( CommonClass.usdtCoin[i].coinPercentage+"%",
                                  style: TextStyle(color:  CommonClass.usdtCoin[i].coinPercentage.startsWith('-')? Colors.red : Colors.green,
                                      fontSize: 10, fontWeight: FontWeight.w600),),
                              ],
                            )
                          ],
                        ),

                        // Icon(popularList[i].icon.icon == Icons.arrow_upward ? Icons.arrow_upward : Icons.arrow_downward, size: 12,
                        //   color: popularList[i].icon.icon == Icons.arrow_upward ? Colors.green : Colors.red,),
                        SizedBox(width: 15,),
                        Container(
                          height: 20,
                          width: 50,
                          decoration: BoxDecoration(
                            //  color: Theme.of(context).buttonColor,
                            borderRadius: BorderRadius.all(Radius.circular(2.0)),
                            gradient: LinearGradient(
                              colors: [Theme.of(context).hoverColor, Theme.of(context).hoverColor
                              ],
                            ),
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Buy ", style: TextStyle(fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Theme
                                      .of(context)
                                      .textTheme
                                      .headline1
                                      ?.color),),
                            ],
                          ),
                        ),

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

class PopularCoinsList{
  String image ;
  String Name;
  String smallName;
  String number;
  Icon icon;
  String numberpercentage;

  PopularCoinsList(this.image, this.Name, this.smallName, this.number,
      this.icon, this.numberpercentage);
}

class BottomImageIcons{
  String imageIcon;
  String imageName;

  BottomImageIcons(this.imageIcon, this.imageName);

}



