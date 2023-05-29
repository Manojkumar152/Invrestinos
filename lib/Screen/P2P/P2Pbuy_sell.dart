
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:investions/Api/Provideclass.dart';
import 'package:investions/Screen/Chart/ChartWidget.dart';
import 'package:investions/Screen/Setting/TradeSettingWidget.dart';
import 'package:investions/Screen/P2P/p2p_BuySell_New.dart';
import 'package:investions/Screen/P2P/peerTopeerComplete.dart';
import 'package:investions/Screen/P2P/peerTopeerOrderBook.dart';
import 'package:provider/provider.dart';

import '../Wallet/Funds.dart';
import '../Order/OrderWidget.dart';
import 'P2Pbuy_sell_Widget.dart';
import 'PeerToPeer_trade.dart';
class P2Pbuy_sell extends StatefulWidget {
  static const id = 'P2Pbuy_sell';
  p2pdata pagedata;

  P2Pbuy_sell({required this.pagedata});

  @override
  State<P2Pbuy_sell> createState() => _P2Pbuy_sellState();
}

class _P2Pbuy_sellState extends State<P2Pbuy_sell>{
  late int selectedIndex;
  late int _currentPage ;
  static const int totalPage = 4;
  // late BuildContext context;
  List <BottomImageIcons> bottomImageList =  [
   // BottomImageIcons("assets/images/charticon.png", 'Chart'),
    BottomImageIcons("assets/images/orders.png", 'Orders'),
    BottomImageIcons("assets/images/exchange.png", 'Buy/Sell'),
    BottomImageIcons("assets/images/trade.png", 'Trades'),
    BottomImageIcons("assets/images/my_orders.png", 'My Orders'),
  ];
  //P2p_BuySell_New(),
  List widgets = [PeertoPeer_OrderBook(),P2p_BuySell_New(),PeerToPeer_MatchHistory(),PeerToPeer_Complete()];


  @override
  void initState() {
    setState(() {
      selectedIndex=widget.pagedata.index;
      _currentPage=widget.pagedata.page;
    });
    super.initState();
  }
  @override
  void dispose(){
    super.dispose();
  }
  stop(){
    print('Stop');
    Provider.of<providerdata>(context,listen: false).ScoketStop();
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop:()async{
        stop();
        return true;
      },
      child: Scaffold(
        backgroundColor:Theme.of(context).backgroundColor,
        body:widgets[_currentPage],
        bottomNavigationBar: _getBottomBar(size),
      ),
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
class BottomImageIcons{
  String imageIcon;
  String imageName;

  BottomImageIcons(this.imageIcon, this.imageName);

}
class p2pdata{
  int index;
  int page;

  p2pdata(this.index, this.page);
}