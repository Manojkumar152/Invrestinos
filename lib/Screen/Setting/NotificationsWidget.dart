import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:getwidget/components/radio_list_tile/gf_radio_list_tile.dart';
import 'package:provider/provider.dart';

import '../../Constant/ColorsCollection.dart';
import '../../Constant/SharedPreferenceClass.dart';
import '../../Constant/Themedata.dart';
import '../InviteAndEarnWidget.dart';
import '../MarketWidget.dart';
import '../Exchange/USDTWidget.dart';

class NotificationsWidget extends StatefulWidget {
   static const id = 'NotificationsWidget';
  @override
  _NotificationsWidgetState createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget>  {




  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,

      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Container(
              height: size.height * 0.367,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/dashboard_headerImage.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding:  EdgeInsets.only(top:40.0,left: 23),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                              child: Icon(Icons.arrow_back,color: Colors.white,)),
                          SizedBox(width: 10,),
                          Text("Notifications",style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height*0.145, left: 16.0, right: 16.0),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height:size.height*0.16,
                          width: size.width,
                          margin: EdgeInsets.only(left: 6,right: 10,top: 4),
                          decoration: BoxDecoration(
                              color: Theme.of(context).hintColor,
                              borderRadius: BorderRadius.circular(2),
                              border:Border.all(color: Theme.of(context).focusColor.withOpacity(0.4)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: ColorsCollectionsDark.lightblueColor.withOpacity(0.2)
                                )
                              ]
                          ),
                          child: InkWell(
                            onTap: (){

                            },
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    height:size.height*0.10,
                                    width: size.width*0.18,
                                    //   color: Colors.red,
                                    child: Image.asset("assets/images/notification.png",)
                                ),
                                Container(
                                  height: size.height*0.20,
                                  width: size.width*0.63,
                                //  color: Colors.green,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:  CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: size.width*0.6,
                                            child: Text('Signup Bank Account Verification First Crypto Mpl Gaming Voucher',style: TextStyle(
                                              fontSize: 8,color: Theme.of(context).indicatorColor.withOpacity(1),fontWeight: FontWeight.w400,letterSpacing: 0.1,),),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );

  }


}





