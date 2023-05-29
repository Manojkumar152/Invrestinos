
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:investions/Screen/P2P/P2PBuySell_WidgetDialog.dart';


class P2Pbuy_sell_Widget extends StatefulWidget {
  static const id = 'P2Pbuy_sell_Widget';

  @override
  State<P2Pbuy_sell_Widget> createState() => _P2Pbuy_sell_WidgetState();
}

class _P2Pbuy_sell_WidgetState extends State<P2Pbuy_sell_Widget> with SingleTickerProviderStateMixin {
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
    return Scaffold(
      backgroundColor:Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
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
                padding: EdgeInsets.only(top: size.height*0.07,left: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Icon(FontAwesomeIcons.arrowLeft,color:Colors.white,)),
                      SizedBox(width: 13,),
                      Text("Peer To Peer (P2P)",style: TextStyle(color:Colors.white,fontWeight: FontWeight.w500,fontSize: 13,letterSpacing: 0.1),)
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: size.width,
              height: size.height,
              margin: EdgeInsets.only(top: size.height*0.16,left: 16,right: 16),

              decoration: BoxDecoration(
                color:Theme.of(context).cardColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border:Border.all(color: Theme.of(context).cardColor),
              ),
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    height: size.height*0.619,
                    margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(3),),
                        gradient: LinearGradient(
                          colors: [Theme
                              .of(context)
                              .hintColor,
                            Theme
                                .of(context)
                                .hintColor
                          ],
                        ),
                        border: Border.all(width: 1,color: Theme.of(context).focusColor.withOpacity(0.2))
                    ),
                    child: Padding(
                      padding:  EdgeInsets.only(left:8.0,right: 8.0,top:14.0,bottom: 8.0),
                      child: Column(
                        children: [
                          Container(
                            height: size.height * 0.043,
                            width: size.width,
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
                                  width: size.width * 0.34,
                                  child: Center(
                                    child: Text(
                                      'Buy',
                                      textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),
                                  ),
                                ),
                                SizedBox(
                                  width:size.width * 0.34,
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
                            height: size.height*0.535,
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
              Container(
                width: size.width,
                height: size.height*0.132,
                margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3),),
                    gradient: LinearGradient(
                      colors: [Theme
                          .of(context)
                          .hintColor,
                        Theme
                            .of(context)
                            .hintColor
                      ],
                    ),
                    border: Border.all(width: 1,color: Theme.of(context).focusColor.withOpacity(0.2))
                ),
                child: Padding(
                  padding:  EdgeInsets.only(left:10.0,right: 10.0,top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Get YOUR OWN XID!",
                            style: TextStyle(color: Theme.of(context).textTheme.headline1?.color,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,),),
                          SizedBox(width: 6,),
                          DottedBorder(
                            borderType: BorderType.RRect,
                            strokeCap: StrokeCap.round,
                            radius: Radius.circular(2),
                            color: Theme.of(context).hoverColor.withOpacity(0.4),

                            child: Container(
                              width: 50,
                              child: Text("CREATE",textAlign: TextAlign.center,
                                style: TextStyle(color: Theme.of(context).textTheme.headline1?.color,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,),),
                            ),
                          ),
                        ],
                      ),
                      visiblebool==true?SizedBox(height: 0,):SizedBox(height: 10,),
                      visiblebool==true?Text(""): Text("1. Create & Share your in Crypto groups",
                        style: TextStyle(color: Theme
                            .of(context)
                            .indicatorColor.withOpacity(0.8),
                          fontSize: 8,
                          fontWeight: FontWeight.w600,),),
                      SizedBox(height: 4,),
                      visiblebool==true?Text(""): Text("2. Get Matched instantly with sellers",
                        style: TextStyle(color: Theme
                            .of(context)
                            .indicatorColor.withOpacity(0.8),
                          fontSize: 8,
                          fontWeight: FontWeight.w600,),),
                    ],
                  ),
                ),
              ),
                  SizedBox(height: 60,),
                  InkWell(
                    onTap: (){
                      showDialog(context: context, builder: (BuildContext context)=>P2PBuySell_Widget());

                    },
                    child: Container(
                      height:26 ,
                      width: size.width,
                      margin: EdgeInsets.only(left: 10,right: 10),
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

                  Container(
                    width: MediaQuery.of(context).size.width,
                    //  margin: EdgeInsets.only(top: 0,bottom: 6),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0,top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text("FEE:0.00%",
                                  style: TextStyle(color: Theme
                                      .of(context)
                                      .indicatorColor.withOpacity(0.8),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,),),
                              ),
                              visiblebool==true?Container():  Container(
                                child: Text("ADD/EDIT PAYMENT DETAILS",
                                  style: TextStyle(color: Theme
                                      .of(context)
                                      .focusColor.withOpacity(0.6),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,),),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget BuyWidget(Size size) {
    return  Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          //  margin: EdgeInsets.only(top: 0,bottom: 6),
          child: Padding(
            padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text("At Price(0.5881)",
                    style: TextStyle(color: Theme
                        .of(context)
                        .indicatorColor.withOpacity(0.8),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,),),
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
                  child: Text("Amount",
                    style: TextStyle(color: Theme
                        .of(context)
                        .indicatorColor.withOpacity(0.8),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,),),
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
                  child: Text("Total(1.1822)",
                    style: TextStyle(color: Theme
                        .of(context)
                        .indicatorColor.withOpacity(0.8),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,),),
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


        SizedBox(height: 12,),
        Row(
          children: [
            Icon(Icons.play_arrow_rounded,size: 16,color:Theme.of(context)
                .indicatorColor ,),
            Text("Add preferred seller(option)",
              style: TextStyle(
                color: Theme.of(context).indicatorColor,
                fontSize: 8.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 16,),
        Row(
          children: [
            Text("ENTER XID OF PREFERRED SELLER(OPTIONAL)",
              style: TextStyle(
                color: Theme.of(context).indicatorColor.withOpacity(0.6),
                fontSize: 9.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 6,),
        Container(
          height:30 ,
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
              contentPadding:  EdgeInsets.only(left: 14,bottom: 15),
              hintText: 'Eg:cryptotrader',
              hintStyle: TextStyle(
                color: Theme.of(context)
                    .indicatorColor
                    .withOpacity(0.6),
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
        SizedBox(height: 6,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("HOW IT WORK",textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).focusColor.withOpacity(0.7),
                  fontSize: 8.0,fontWeight: FontWeight.w600
              ),
            ),

            Image.asset("assets/images/howitswork.png",height: 18,width: 18,)
          ],
        ),

        // Container(height: 1, color: Theme
        //     .of(context)
        //     .canvasColor,)
      ],
    );
 }
  Widget SellWidget(Size size) {
    return   Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          //  margin: EdgeInsets.only(top: 0,bottom: 6),
          child: Padding(
            padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text("At Price(0.5881)",
                    style: TextStyle(color: Theme
                        .of(context)
                        .indicatorColor.withOpacity(0.8),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,),),
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
                  child: Text("Amount",
                    style: TextStyle(color: Theme
                        .of(context)
                        .indicatorColor.withOpacity(0.8),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,),),
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
                  child: Text("Total(1.1822)",
                    style: TextStyle(color: Theme
                        .of(context)
                        .indicatorColor.withOpacity(0.8),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,),),
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


        SizedBox(height: 12,),
        Row(
          children: [
            Icon(Icons.play_arrow_rounded,size: 16,color:Theme.of(context)
                .indicatorColor ,),
            Text("Add preferred seller(option)",
              style: TextStyle(
                color: Theme.of(context).indicatorColor,
                fontSize: 8.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 16,),
        Row(
          children: [
            Text("ENTER XID OF PREFERRED SELLER(OPTIONAL)",
              style: TextStyle(
                color: Theme.of(context).indicatorColor.withOpacity(0.6),
                fontSize: 9.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 6,),
        Container(
          height:30 ,
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
              contentPadding:  EdgeInsets.only(left: 14,bottom: 15),
              hintText: 'Eg:cryptotrader',
              hintStyle: TextStyle(
                color: Theme.of(context)
                    .indicatorColor
                    .withOpacity(0.6),
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
        SizedBox(height: 6,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("HOW IT WORK",textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).focusColor.withOpacity(0.7),
                  fontSize: 8.0,fontWeight: FontWeight.w600
              ),
            ),

            Image.asset("assets/images/howitswork.png",height: 18,width: 18,)
          ],
        ),

        // Container(height: 1, color: Theme
        //     .of(context)
        //     .canvasColor,)
      ],
    );
  }
}
