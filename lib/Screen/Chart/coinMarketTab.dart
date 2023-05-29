
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:investions/Screen/Chart/trade_history.dart';
import 'package:investions/Screen/Exchange/ExchangesWidget.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'info_tab.dart';
import 'market_depth.dart';
import 'order_volume.dart';

class CoinMarketTabBar extends StatefulWidget {
  static const id = 'CoinMarketTabBar';

  String symbol;
  String familyCoin;
  String pairCoin;
  double rate;
  String highDay;
  String lowDay;
  String Shortname;
  String listed;
  CoinMarketTabBar(
      {required this.symbol,
      required this.familyCoin,
      required this.pairCoin,
      required this.rate,
      required this.highDay,
      required this.lowDay,
      required this.listed,
      required this.Shortname});

  @override
  State<CoinMarketTabBar> createState() => _CoinMarketTabBarState();
}

class _CoinMarketTabBarState extends State<CoinMarketTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int tabindex = 0;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        tabindex = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height * 0.045,
            width: width,
            //padding: EdgeInsets.all(3),
            child: TabBar(
              controller: _tabController,
              isScrollable: false,
              physics: BouncingScrollPhysics(),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.blue,
              labelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3),
              unselectedLabelStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3),
              unselectedLabelColor:
                  Theme.of(context).textTheme.bodyText1!.color,
              tabs: [
                SizedBox(
                  //width: width * 0.222,
                  child: Text(
                    'Order Book',
                    textAlign: TextAlign.center,
                    style:TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 12,fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  //width: width * 0.222,
                  child: Text('Order Volume',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 12,fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  //width: width * 0.222,
                  child: Text('Trade History',
                      textAlign: TextAlign.center,
                      style:TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 12,fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  //width: width * 0.222,
                  child: Text('Info',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 12,fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            height: height * 0.7,
            child: IndexedStack(
              children: [
                Container(
                  child: TabBarView(
                    controller: _tabController,
                    physics: BouncingScrollPhysics(),
                    children: [
                      MarketDepth(
                          symbol: widget.symbol.toLowerCase(),
                          familyCoin: widget.familyCoin,
                          rate: widget.rate,
                          pairCoin: widget.pairCoin.toLowerCase() +
                              widget.familyCoin.toLowerCase(),
                      listed:widget.listed.toString(),
                      shortname:widget.Shortname.toString() ),
                      OrderVolumeTab(
                          symbol: widget.symbol.toLowerCase(),
                          familyCoin: widget.familyCoin,
                          rate: widget.rate,
                          pairCoin: widget.pairCoin.toLowerCase() +
                              widget.familyCoin.toLowerCase(),),
                      TradeHistoryTab(
                        symbol: widget.symbol.toLowerCase(),
                        familyCoin: widget.familyCoin,
                        pairCoin: widget.pairCoin.toLowerCase() +
                            widget.familyCoin.toLowerCase(),
                        rate: widget.rate,
                          listed:widget.listed.toString()
                      ), //orderHistory(symbol: widget.pair.toLowerCase(),familyCoin:widget.familycoin,pairCoin:widget.pair.toLowerCase()+widget.familycoin.toLowerCase()),
                      //SignedInTab(),
                      //SignedOutTab(),
                      InfoTab(highDay: widget.highDay, lowDay: widget.lowDay)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
