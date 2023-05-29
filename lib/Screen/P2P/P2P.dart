import 'package:flutter/material.dart';
import 'package:investions/Api/Provideclass.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:investions/Screen/P2P/P2Pbuy_sell.dart';
import 'package:investions/Screen/P2P/peerTopeerComplete.dart';
import 'package:provider/provider.dart';

import '../Account/VerifyAccountWidget.dart';

class P2p_Screen extends StatefulWidget {
  const P2p_Screen({Key? key}) : super(key: key);

  @override
  State<P2p_Screen> createState() => _P2p_ScreenState();
}

class _P2p_ScreenState extends State<P2p_Screen> {


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        primary: false,
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Provider.of<providerdata>(context,listen: false).getmatket();
                Provider.of<providerdata>(context,listen: false).gettradeChannel();
                Navigator.pushNamed(context, P2Pbuy_sell.id,arguments: p2pdata(1,1));
              },
              child: Container(
                height:size.height*0.14,
                width: size.width,
                margin: EdgeInsets.only(left: 10,right: 10,top: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                   // /borderRadius: BorderRadius.circular(3),
                  border:Border.all(color: ColorsCollectionsDark.lightblueColor.withOpacity(0.5)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                       color: ColorsCollectionsDark.lightblueColor.withOpacity(0.2)
                    )
                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height:size.height*0.14,
                        width: size.width*0.18,
                     //   color: Colors.red,
                        child: Image.asset("assets/images/p2p2.png",)
                    ),
                    Container(
                      height: size.height*0.14,
                      width: size.width*0.63,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment:  CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Buy INR with p2p',style: TextStyle(color: Theme.of(context).textTheme.headline2!.color,fontWeight: FontWeight.w500,fontSize: 12,letterSpacing: 0.3),),
                              SizedBox(height: 3,),
                              Container(
                                width: size.width*0.55,
                                child: Text('Inventions P2p is an alternative way to buy and sell with USDT.we recommend using  deposit inr via newt net banking',style: TextStyle(
                                  fontSize: 10,color: Colors.grey.shade600,fontWeight: FontWeight.w400,letterSpacing: 0.1,),),
                              ),
                            ],
                          ),
                          Icon(Icons.keyboard_arrow_right_rounded,color: Colors.grey.shade500,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 6,),
            GestureDetector(
              onTap: (){
                Provider.of<providerdata>(context,listen: false).getmatket();
                Provider.of<providerdata>(context,listen: false).gettradeChannel();
                Navigator.pushNamed(context, P2Pbuy_sell.id,arguments: p2pdata(3,3));
              },
              child: Container(
                height:size.height*0.10,
                width: size.width,
                margin: EdgeInsets.only(left: 10,right: 10,top: 4),
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(2),
                    border:Border.all(color: ColorsCollectionsDark.lightblueColor.withOpacity(0.5)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: ColorsCollectionsDark.lightblueColor.withOpacity(0.2)
                      )
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height:size.height*0.10,
                        width: size.width*0.18,
                        //   color: Colors.red,
                        child: Image.asset("assets/images/myp2p.png",)
                    ),
                    Container(
                      height: size.height*0.10,
                      width: size.width*0.63,
                      //color: Colors.green,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment:  CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('My P2P Order',style: TextStyle(color: Theme.of(context).textTheme.headline2!.color,fontWeight: FontWeight.w500,fontSize: 12,letterSpacing: 0.3),),
                              SizedBox(height: 3,),
                              Text('Inventions P2p is an alternative\nway to buy and sell with USDT',style: TextStyle(
                                fontSize: 10,color: Colors.grey.shade600,fontWeight: FontWeight.w400,letterSpacing: 0.1,),),
                            ],
                          ),
                          Icon(Icons.keyboard_arrow_right_rounded,color: Colors.grey.shade500,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
            Text("How it Work",style: TextStyle(color: Theme.of(context).textTheme.headline2!.color,fontWeight: FontWeight.w600,fontSize: 14),),
            SizedBox(height: 4,),
            Container(
              width: 80,
                child: Image.asset('assets/images/p2pLine.png',fit: BoxFit.fitWidth,)),
            SizedBox(height: 15,),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  // color: Colors.red,
                image: DecorationImage(
                  image: AssetImage('assets/images/p2pDirect.png'),
                )
              ),
            ),
            Text("Pay directly to seller bank\n account",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey.shade600,fontSize: 11,fontWeight: FontWeight.w500),),
            SizedBox(height: 10,),
            Container(
              height:60,
             // / color: Colors.red,
              child: Image.asset('assets/images/p2pVerticalLine.png',color:Theme.of(context).textTheme.headline2!.color,fit: BoxFit.fitHeight),
            ),
            SizedBox(height: 10,),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/p2pSeller.png'),
                  )
              ),
            ),
            Text("Seller Confirm\nPayment",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey.shade600,fontSize: 11,fontWeight: FontWeight.w500),),
            SizedBox(height: 10,),
            Container(
              height:60,
              // / color: Colors.red,
              child: Image.asset('assets/images/p2pVerticalLine.png',color:Theme.of(context).textTheme.headline2!.color,fit: BoxFit.fitHeight),
            ),
            SizedBox(height: 10,),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/p2pSeller.png'),
                  )
              ),
            ),
            Text("Inversions releases locked usdt to your\nAccount",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey.shade600,fontSize: 11,fontWeight: FontWeight.w500),),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
