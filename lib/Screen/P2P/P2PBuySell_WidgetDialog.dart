
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'P2PSellerMatchedMakePayment.dart';


class P2PBuySell_Widget extends StatefulWidget {
  static const id = 'P2PBuySell_Widget';

  @override
  State<P2PBuySell_Widget> createState() => _P2Pbuy_sell_WidgetState();
}

class _P2Pbuy_sell_WidgetState extends State<P2PBuySell_Widget> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int ind = 0;
  bool visiblebool = false;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        ind = _tabController.index;
        if(ind==0){
         setState(() {
           visiblebool = false;
         });
        }else{
          setState(() {
            visiblebool = true;
          });
        }
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Dialog(
      elevation: 0.5,
      backgroundColor: Theme
          .of(context)
          .hintColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        height: size.height*0.572,
        width: size.width,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(6.0),),
            gradient: LinearGradient(
              colors: [Theme
                  .of(context)
                  .hintColor,
                Theme
                    .of(context)
                    .hintColor
              ],
            ),
            border: Border.all(width: 1,color: Theme.of(context).indicatorColor.withOpacity(0.6))
        ),
         child: SingleChildScrollView(
           child: Padding(
             padding:  EdgeInsets.only(left:8.0,right: 8.0,top:14.0,bottom: 8.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Container(
                   height: size.height * 0.043,
                   width: size.width*0.4,
                   padding: EdgeInsets.all(0),
                   decoration: BoxDecoration(
                     color: Theme.of(context).textTheme.headline4?.color,
                     //color: Colors.grey.shade300,
                     //border: Border.all(color: Colors.grey.shade700),
                     borderRadius: BorderRadius.circular(2),
                   ),
                   child: TabBar(
                     physics: BouncingScrollPhysics(),
                     controller: _tabController,
                     isScrollable: true,
                     indicator: BoxDecoration(
                         borderRadius: BorderRadius.circular(2),
                         color: Theme.of(context).focusColor),
                     indicatorSize: TabBarIndicatorSize.tab,
                     labelColor:Colors.white,
                     labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                     unselectedLabelStyle: TextStyle(
                       fontSize: 13,
                     ),
                     unselectedLabelColor:Theme.of(context).textTheme.headline1?.color,
                     tabs: [
                       SizedBox(
                         width: size.width * 0.11,
                         child: Center(
                           child: Text(
                             'Buy',
                             textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),
                         ),
                       ),
                       SizedBox(
                         width:size.width * 0.11,
                         child: Center(
                           child: Text(
                             'Sell',
                             textAlign: TextAlign.center,
                             style: TextStyle(fontSize: 12),
                           ),
                         ),
                       ),
                     ],
                   ),

                 ),
                 Container(
                   height: size.height*0.54,
                   decoration: BoxDecoration(
                       color: Theme.of(context)
                           .hintColor,
                       borderRadius: BorderRadius.circular(5)),
                   child: TabBarView(
                     physics: BouncingScrollPhysics(),
                     controller: _tabController,
                     children: [
                       BuyWidget(size),
                      SellWidget(size),
                     ],
                   ),
                 ),

               ],
             ),
           ),
         ),

      ),
    );
  }

 Widget BuyWidget(Size size) {
    return  Padding(
      padding:  EdgeInsets.only(left:6.0,right: 6.0,top:4.0,bottom: 8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height:22 ,
              width: size.width * 0.16,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Theme.of(context)
                        .indicatorColor
                        .withOpacity(0.4),
                      Theme.of(context)
                          .indicatorColor
                          .withOpacity(0.4),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(2)),
              child: Padding(
                padding:  EdgeInsets.only(left:8.0,right: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Limit",textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline1?.color,
                          fontSize: 8.0,fontWeight: FontWeight.w600
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down_sharp,size: 22,color: Theme.of(context).textTheme.headline1?.color,),
                  ],
                ),
              ),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            //  margin: EdgeInsets.only(top: 0,bottom: 6),
            child: Padding(
              padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("At Price(0.5881)",
                          style: TextStyle(color: Theme
                              .of(context)
                              .indicatorColor.withOpacity(0.8),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,),),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text("AUSDT",
                                  style: TextStyle(color: Theme
                                      .of(context)
                                      .indicatorColor.withOpacity(0.8),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,),),
                                SizedBox(width: 2,),
                                Text("0.00%",
                                  style: TextStyle(color:  Theme.of(context)
                                      .hoverColor.withOpacity(0.6),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,),),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: 8,),
          Container(
            height:24 ,
            width: size.width,
            decoration: BoxDecoration(
                color: Theme.of(context)
                    .indicatorColor
                    .withOpacity(0.4),
                borderRadius: BorderRadius.circular(2)),
            child: TextFormField(
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                errorStyle: TextStyle(fontSize: 8,color: Colors.red),
                contentPadding:  EdgeInsets.only(left: 10,bottom: 15),
                hintText: '',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: Theme.of(context).textTheme.headline3?.color,
                fontSize: 11.0,
              ),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            //  margin: EdgeInsets.only(top: 0,bottom: 6),
            child: Padding(
              padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Amount",
                          style: TextStyle(color: Theme
                              .of(context)
                              .indicatorColor.withOpacity(0.8),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,),),
                        Text("ADX",
                          style: TextStyle(color: Theme
                              .of(context)
                              .indicatorColor.withOpacity(0.8),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,),),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: 8,),
          Container(
            height:24 ,
            width: size.width,
            decoration: BoxDecoration(
                color: Theme.of(context)
                    .indicatorColor
                    .withOpacity(0.4),
                borderRadius: BorderRadius.circular(2)),
            child: TextFormField(
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                errorStyle: TextStyle(fontSize: 8,color: Colors.red),
                contentPadding:  EdgeInsets.only(left: 10,bottom: 15),
                hintText: '',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: Theme.of(context).textTheme.headline3?.color,
                fontSize: 11.0,
              ),
            ),
          ),



          Container(
            width: MediaQuery.of(context).size.width,
            //  margin: EdgeInsets.only(top: 0,bottom: 6),
            child: Padding(
              padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total(1.1822)",
                          style: TextStyle(color: Theme
                              .of(context)
                              .indicatorColor.withOpacity(0.8),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,),),
                        Text("USDT",
                          style: TextStyle(color: Theme
                              .of(context)
                              .indicatorColor.withOpacity(0.8),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,),),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: 8,),

          Container(
            height:24 ,
            width: size.width,
            decoration: BoxDecoration(
                color: Theme.of(context)
                    .indicatorColor
                    .withOpacity(0.4),
                borderRadius: BorderRadius.circular(2)),
            child: TextFormField(
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                errorStyle: TextStyle(fontSize: 8,color: Colors.red),
                contentPadding:  EdgeInsets.only(left: 10,bottom: 15),
                hintText: '',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: Theme.of(context).textTheme.headline3?.color,
                fontSize: 11.0,
              ),
            ),
          ),
          SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset("assets/images/wallet.png",height: 16,width: 14,color: Theme
                          .of(context)
                          .indicatorColor ,),
                      SizedBox(width: 4,),
                      Text("0 WAX",
                        style: TextStyle(color: Theme
                            .of(context)
                            .indicatorColor.withOpacity(0.8),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,),),
                    ],
                  ),
                ],
              ),
              Text("25%",
                style: TextStyle(color: Theme
                    .of(context)
                    .indicatorColor.withOpacity(0.8),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,),),
              Text("50%",
                style: TextStyle(color: Theme
                    .of(context)
                    .indicatorColor.withOpacity(0.8),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,),),
              Text("75%",
                style: TextStyle(color: Theme
                    .of(context)
                    .indicatorColor.withOpacity(0.8),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,),),
              Text("100%",
                style: TextStyle(color: Theme
                    .of(context)
                    .indicatorColor.withOpacity(0.8),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,),),
            ],
          ),
          SizedBox(height: 18,),
          Container(
            height:26 ,
            width: size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Theme
                      .of(context)
                      .hoverColor.withOpacity(0.9),
                    Theme.of(context)
                        .hoverColor.withOpacity(0.9)
                  ],
                ),
                borderRadius: BorderRadius.circular(2)),
            child: InkWell(
              onTap: (){
                Navigator.pushNamed(context, P2PSellerMatchedMakePayment.id);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(visiblebool==true?"Sell":"Buy",textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headline1?.color,
                        fontSize: 11.0,fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Container(height: 1, color: Theme
          //     .of(context)
          //     .canvasColor,)
        ],
      ),
    );
 }
  Widget SellWidget(Size size) {
    return   Padding(
      padding:  EdgeInsets.only(left:6.0,right: 6.0,top:4.0,bottom: 8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height:22 ,
              width: size.width * 0.16,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Theme.of(context)
                        .indicatorColor
                        .withOpacity(0.4),
                      Theme.of(context)
                          .indicatorColor
                          .withOpacity(0.4),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(2)),
              child: Padding(
                padding:  EdgeInsets.only(left:8.0,right: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Limit",textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline1?.color,
                          fontSize: 8.0,fontWeight: FontWeight.w600
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down_sharp,size: 22,color: Theme.of(context).textTheme.headline1?.color,),
                  ],
                ),
              ),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            //  margin: EdgeInsets.only(top: 0,bottom: 6),
            child: Padding(
              padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("At Price(0.5881)",
                          style: TextStyle(color: Theme
                              .of(context)
                              .indicatorColor.withOpacity(0.8),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,),),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text("AUSDT",
                                  style: TextStyle(color: Theme
                                      .of(context)
                                      .indicatorColor.withOpacity(0.8),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,),),
                                SizedBox(width: 2,),
                                Text("0.00%",
                                  style: TextStyle(color:  Theme.of(context)
                                      .hoverColor.withOpacity(0.9),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,),),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: 8,),
          Container(
            height:24 ,
            width: size.width,
            decoration: BoxDecoration(
                color: Theme.of(context)
                    .indicatorColor
                    .withOpacity(0.4),
                borderRadius: BorderRadius.circular(2)),
            child: TextFormField(
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                errorStyle: TextStyle(fontSize: 8,color: Colors.red),
                contentPadding:  EdgeInsets.only(left: 10,bottom: 15),
                hintText: '',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: Theme.of(context).textTheme.headline3?.color,
                fontSize: 11.0,
              ),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            //  margin: EdgeInsets.only(top: 0,bottom: 6),
            child: Padding(
              padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Amount",
                          style: TextStyle(color: Theme
                              .of(context)
                              .indicatorColor.withOpacity(0.8),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,),),
                        Text("ADX",
                          style: TextStyle(color: Theme
                              .of(context)
                              .indicatorColor.withOpacity(0.8),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,),),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: 8,),
          Container(
            height:24 ,
            width: size.width,
            decoration: BoxDecoration(
                color: Theme.of(context)
                    .indicatorColor
                    .withOpacity(0.4),
                borderRadius: BorderRadius.circular(2)),
            child: TextFormField(
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                errorStyle: TextStyle(fontSize: 8,color: Colors.red),
                contentPadding:  EdgeInsets.only(left: 10,bottom: 15),
                hintText: '',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: Theme.of(context).textTheme.headline3?.color,
                fontSize: 11.0,
              ),
            ),
          ),



          Container(
            width: MediaQuery.of(context).size.width,
            //  margin: EdgeInsets.only(top: 0,bottom: 6),
            child: Padding(
              padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total(1.1822)",
                          style: TextStyle(color: Theme
                              .of(context)
                              .indicatorColor.withOpacity(0.8),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,),),
                        Text("USDT",
                          style: TextStyle(color: Theme
                              .of(context)
                              .indicatorColor.withOpacity(0.8),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,),),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: 8,),

          Container(
            height:24 ,
            width: size.width,
            decoration: BoxDecoration(
                color: Theme.of(context)
                    .indicatorColor
                    .withOpacity(0.4),
                borderRadius: BorderRadius.circular(2)),
            child: TextFormField(
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                errorStyle: TextStyle(fontSize: 8,color: Colors.red),
                contentPadding:  EdgeInsets.only(left: 10,bottom: 15),
                hintText: '',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: Theme.of(context).textTheme.headline3?.color,
                fontSize: 11.0,
              ),
            ),
          ),
          SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset("assets/images/wallet.png",height: 16,width: 14,color: Theme
                          .of(context)
                          .indicatorColor ,),
                      SizedBox(width: 4,),
                      Text("0 WAX",
                        style: TextStyle(color: Theme
                            .of(context)
                            .indicatorColor.withOpacity(0.8),
                          fontSize: 8,
                          fontWeight: FontWeight.w600,),),
                    ],
                  ),
                ],
              ),
              Text("25%",
                style: TextStyle(color: Theme
                    .of(context)
                    .indicatorColor.withOpacity(0.8),
                  fontSize: 8,
                  fontWeight: FontWeight.w600,),),
              Text("50%",
                style: TextStyle(color: Theme
                    .of(context)
                    .indicatorColor.withOpacity(0.8),
                  fontSize: 8,
                  fontWeight: FontWeight.w600,),),
              Text("75%",
                style: TextStyle(color: Theme
                    .of(context)
                    .indicatorColor.withOpacity(0.8),
                  fontSize: 8,
                  fontWeight: FontWeight.w600,),),
              Text("100%",
                style: TextStyle(color: Theme
                    .of(context)
                    .indicatorColor.withOpacity(0.8),
                  fontSize: 8,
                  fontWeight: FontWeight.w600,),),
            ],
          ),
          SizedBox(height: 18,),
          Container(
            height:26 ,
            width: size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Theme
                      .of(context)
                      .hoverColor.withOpacity(0.9),
                    Theme.of(context)
                        .hoverColor.withOpacity(0.9)
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

          // Container(height: 1, color: Theme
          //     .of(context)
          //     .canvasColor,)
        ],
      ),
    );
  }
}
