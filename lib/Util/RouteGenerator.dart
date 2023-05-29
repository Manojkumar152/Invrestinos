// ignore_for_file: file_names, prefer_const_constructors, unused_local_variable


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:investions/Screen/Credential%20Screen/ForgotPassword.dart';
import 'package:investions/Screen/Dialog/PleaseConfirmWidget.dart';
import 'package:investions/Screen/P2P/P2PMatchingDetails.dart';
import 'package:investions/Screen/Setting/Bank/AddBank.dart';
import '../Screen/Credential Screen/splash_screen.dart';
import '../Screen/Order/OrderDetails.dart';
import '../Screen/Setting/AboutUsWidget.dart';
import '../Screen/Setting/ActivityLogsWidget.dart';
import '../Screen/Setting/AppearanceWidget.dart';
import '../Screen/CLaimCouponsWidget.dart';
import '../Screen/Chart/ChartWidget.dart';
import '../Screen/CurrencyPerference.dart';
import '../Screen/DownloadTradeReportWidget.dart';
import '../Screen/Exchange/ExchangesWidget.dart';
import '../Screen/Setting/Bank/BankList.dart';
import '../Screen/Setting/FAWidget.dart';
import '../Screen/Setting/FeeSettingsWidget.dart';
import '../Screen/Setting/TicketReply.dart';
import '../Screen/Setting/ViewTicket.dart';
import '../Screen/Setting/addTicket.dart';
import '../Screen/Wallet/Deposit.dart';
import '../Screen/Wallet/Funds.dart';
import '../Screen/Setting/HelpAndSupportWidget.dart';
import '../Screen/InviteAndEarnWidget.dart';
import '../Screen/Setting/LanguageWidget.dart';
import '../Screen/Credential Screen/LoginWidget.dart';
import '../Screen/MarketWidget.dart';
import '../Screen/Setting/NotificationsWidget.dart';
import '../Screen/P2P/P2PBuySell_WidgetDialog.dart';
import '../Screen/P2P/P2PCancelWidget.dart';
import '../Screen/P2P/P2PContinueToPay.dart';
import '../Screen/P2P/P2PInstantDepositeWidget.dart';
import '../Screen/P2P/P2PSellerMatchedMakePayment.dart';
import '../Screen/P2P/P2Pbuy_sell.dart';
import '../Screen/P2P/P2Pbuy_sell_Widget.dart';
import '../Screen/PaymentOptionsWidget.dart';
import '../Screen/P2P/PeerToPeer_trade.dart';
import '../Screen/Dialog/PeerTopeerCreateYour_xidWidgetDialog.dart';
import '../Screen/Quicky_buy.dart';
import '../Screen/Setting/SecurityWidget.dart';
import '../Screen/Setting/SettingWidget.dart';
import '../Screen/Credential Screen/SignupWidget.dart';
import '../Screen/Setting/TradeSettingWidget.dart';
import '../Screen/Account/VerifyAccountWidget.dart';
import '../Screen/Account/VerifyAccountWidget2.dart';
import '../Screen/Wallet/Recevie_portfalio.dart';
import '../Screen/Wallet/SendPortfolio.dart';
import '../Screen/Wallet/WalletWidget.dart';
import '../Screen/P2P/peerTopeerComplete.dart';
import '../Screen/P2P/peerTopeerOrderBook.dart';
import '../Screen/Wallet/WithdrawHistory.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
        case SplashScreen.id:
        return MaterialPageRoute(builder: (_) => SplashScreen());
        case Quick_buy.id:
        return MaterialPageRoute(builder: (_) => Quick_buy(args as p2pdata));
        case ExchangesWidget.id:
        return MaterialPageRoute(builder: (_) => ExchangesWidget());
        case LoginWidget.id:
        return MaterialPageRoute(builder: (_) => LoginWidget());
        case ForgotPassword.id:
        return MaterialPageRoute(builder: (_) => ForgotPassword());
        case SignupWidget.id:
        return MaterialPageRoute(builder: (_) => SignupWidget());
        case FAWidget.id:
        return MaterialPageRoute(builder: (_) => FAWidget());
        case AboutUsWidget.id:
        return MaterialPageRoute(builder: (_) => AboutUsWidget());
        case ActivityLogsWidget.id:
        return MaterialPageRoute(builder: (_) => ActivityLogsWidget());
        case P2Pbuy_sell.id:
        return MaterialPageRoute(builder: (_) => P2Pbuy_sell(pagedata: args as p2pdata));
        case WalletWidget.id:
        return MaterialPageRoute(builder: (_) => WalletWidget());
        case MarketWidget.id:
        return MaterialPageRoute(builder: (_) => MarketWidget());
        case P2PCancelWidget.id:
        return MaterialPageRoute(builder: (_) => P2PCancelWidget());
        case CLaimCouponsWidget.id:
        return MaterialPageRoute(builder: (_) => CLaimCouponsWidget());
        case P2PContinueToPay.id:
        return MaterialPageRoute(builder: (_) => P2PContinueToPay());
        case DownloadTradeReportWidget.id:
        return MaterialPageRoute(builder: (_) => DownloadTradeReportWidget());
        case FeeSettingsWidget.id:
        return MaterialPageRoute(builder: (_) => FeeSettingsWidget());
        case AppearanceWidget.id:
        return MaterialPageRoute(builder: (_) => AppearanceWidget());
        case HelpAndSupportWidget.id:
        return MaterialPageRoute(builder: (_) => HelpAndSupportWidget());
        case P2PInstantDepositeWidget.id:
        return MaterialPageRoute(builder: (_) => P2PInstantDepositeWidget());
        case InviteAndEarnWidget.id:
        return MaterialPageRoute(builder: (_) => InviteAndEarnWidget());
        case NotificationsWidget.id:
        return MaterialPageRoute(builder: (_) => NotificationsWidget());
        case PaymentOptionsWidget.id:
        return MaterialPageRoute(builder: (_) => PaymentOptionsWidget());
        case P2Pbuy_sell_Widget.id:
        return MaterialPageRoute(builder: (_) => P2Pbuy_sell_Widget());
        case P2PBuySell_Widget.id:
        return MaterialPageRoute(builder: (_) => P2PBuySell_Widget());
        case P2PSellerMatchedMakePayment.id:
        return MaterialPageRoute(builder: (_) => P2PSellerMatchedMakePayment());
        case SecurityWidget.id:
        return MaterialPageRoute(builder: (_) => SecurityWidget());
        case TradeSettingWidget.id:
        return MaterialPageRoute(builder: (_) => TradeSettingWidget());
        case SettingWidget.id:
        return MaterialPageRoute(builder: (_) => SettingWidget());
        case VerifyAccountWidget.id:
        return MaterialPageRoute(builder: (_) => VerifyAccountWidget());
        case VerifyAccountWidget2.id:
        return MaterialPageRoute(builder: (_) => VerifyAccountWidget2());
        // case ChartWidget.id:
        // return MaterialPageRoute(builder: (_) => ChartWidget());
      case PeerToPeer_Complete.id:
        return MaterialPageRoute(builder: (_) => PeerToPeer_Complete());
      case PeertoPeer_OrderBook.id:
        return MaterialPageRoute(builder: (_) => PeertoPeer_OrderBook());
      case PeerToPeer_MatchHistory.id:
        return MaterialPageRoute(builder: (_) => PeerToPeer_MatchHistory());
      case Funds.id:
        return MaterialPageRoute(builder: (_) => Funds());
      case Currency_Perference.id:
        return MaterialPageRoute(builder: (_) => Currency_Perference());
        case LanguageWidget.id:
        return MaterialPageRoute(builder: (_) => LanguageWidget());
        case "/Send_portfolio":
        return MaterialPageRoute(builder: (_) => Send_portfolio(passdata: [args],));
        case "/Receive_portfolio":
        return MaterialPageRoute(builder: (_) => Receive_portfolio(passdata: [args],));
        case "/OrderDetails":
        return MaterialPageRoute(builder: (_) => OrderDetails(passdata: [args],));
        case "/BankDetail":
        return MaterialPageRoute(builder: (_) => BankDetail());
        case "/AddNewBank":
        return MaterialPageRoute(builder: (_) => AddNewBank());
        case "/Add_Ticket":
        return MaterialPageRoute(builder: (_) => Add_Ticket());
        case "/View_Ticket":
        return MaterialPageRoute(builder: (_) => View_Ticket());
        case "/TicketDetail":
        return MaterialPageRoute(builder: (_) => TicketDetail(args as passdata));
       case "/Withdraw_History":
        return MaterialPageRoute(builder: (_) => Withdraw_History());
        case "/Deposit":
        return MaterialPageRoute(builder: (_) => Deposit());
      case "/P2PMatchingDetails":
        return MaterialPageRoute(builder: (_) => P2PMatchingDetails(id:args.toString(),));

      default:
        //    If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Page Note Found'),
        ),
      );
    });
  }
}
