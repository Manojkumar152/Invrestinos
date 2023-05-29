
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:investions/Screen/Dialog/PeerTopeerCreateYour_xidWidgetDialog.dart';
import 'package:investions/Screen/P2P/peerTopeerComplete.dart';
import 'package:provider/provider.dart';

import '../../Api/ApiCollections.dart';
import '../../Api/ApiMain.dart';
import '../../Api/Provideclass.dart';
import '../../Constant/CommonClass.dart';
import '../../Constant/SharePerferarance.dart';
import '../../Constant/ToastClass.dart';
import 'P2Pbuy_sell.dart';
import 'P2Pbuy_sell_Widget.dart';

class P2p_BuySell_New extends StatefulWidget {

  const P2p_BuySell_New({Key? key}) : super(key: key);

  @override
  _P2p_BuySell_NewState createState() => _P2p_BuySell_NewState();
}

class _P2p_BuySell_NewState extends State<P2p_BuySell_New>with SingleTickerProviderStateMixin  {

  late TabController _tabController;
  int ind = 0;
  bool booladdprefferd = false;
  bool boolcopy = false;
  TextEditingController priceController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController xidpreferredSellerController = TextEditingController();
  TextEditingController yourxidController = TextEditingController();
  final _formKey =GlobalKey<FormState>();
  double sizeprice =0.036;
  double sizeamount=0.036;

  bool booladdprefferdsell = false;
  bool boolcopysell = false;
  TextEditingController pricesellController = TextEditingController();
  TextEditingController amountsellController = TextEditingController();
  TextEditingController totalsellController = TextEditingController();
  TextEditingController xidpreferredBuyerController = TextEditingController();
  TextEditingController yourxidsellController = TextEditingController();
  final _formKeySell =GlobalKey<FormState>();
  double sizepricesell =0.036;
  double sizeamountsell=0.036;
  String c_bal = '';
  bool click = true;
  String status = '';

  @override
  void initState() {
    getShareddata();
    getCrypto();
   yourxidController.text = CommonClass.pref_xid;
   yourxidsellController.text = CommonClass.pref_xid;
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        ind = _tabController.index;
        log("fffdsf"+ind.toString());
      });
    });
    super.initState();
  }
  Future<void>getCrypto()async{
    final paramDic = {
      "": '',
    };
    try{
      var response=await APIMainClassbinance(ApiCollections.getcrypto, paramDic,"Get");
      var data=jsonDecode(response.body);
      if(data["status_code"]=="1"){
        List userdata=[];
        userdata=data["data"];
        for(int i=0;i<userdata.length;i++){
          if(userdata[i]["symbol"].toString()=="USDT"){
            setState(() {
              c_bal=userdata[i]["c_bal"].toString();
            });
          }
        }
        print(userdata.toString());
      }
    }catch(e){
      print(e.toString());
    }
  }


  getShareddata()async{
    status=await SharedPreferenceClass.GetSharedData("isLogin");
    setState(() {
      status=status;
    });
  }
  Future<void> proceedtoBuy(String orderType,String TypeNew) async {
    var tokenValue = await SharedPreferenceClass.GetSharedData("token");
    final paramDic = {
      "currency": "USDT",
      "order_type": orderType,
      "price": orderType=="buy"?int.parse(priceController.text.toString()):int.parse(pricesellController.text.toString()),
      "quantity": orderType=="buy"?int.parse(amountController.text.toString()):int.parse(amountsellController.text.toString()),
      "with_currency": "INR",

    };
    print(paramDic);
    final uri = Uri.http(ApiCollections.LBM_BaseURL, ApiCollections.p2pcreate);
    log("ffdfdsfdfdfd"+uri.toString());
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.postUrl(uri);
    request.headers.set('Content-Type', 'application/json');
    request.headers.set('Accept', 'application/json');
    request.headers.set('Authorization', 'Bearer $tokenValue');
    request.add(utf8.encode(json.encode(paramDic)));
    HttpClientResponse response = await request.close();
    print(request.headers.toString());
    print(response.toString());
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      var data = jsonDecode(reply);
      print('Data=== >' + data.toString());
      if (data["status_code"] == '1') {
        setState(() {
          click = true;
        });
        ToastShowClass.toastShow(context, data['message'].toString(), Colors.blue);
 //       Navigator.pushReplacementNamed(context, P2Pbuy_sell.id,arguments: p2pdata(4,4));
        Navigator.pushNamed(context, "/P2PMatchingDetails",arguments: data['data']['id'].toString(),);
      }else {
         setState(() {
           click=true;
         });
        ToastShowClass.toastShowerror(context, data["message"], Colors.red);
      }
      }
    else {
      setState(() {
        click=true;
      });
      ToastShowClass.toastShow(context, 'Something Went Wrong', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:Theme.of(context).backgroundColor,
      body: Stack(
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
                          Provider.of<providerdata>(context,listen: false).ScoketStop();
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: size.width,
                   // height: size.height*0.587,
                  //  height: size.height*0.497,
                  //  height: size.height*0.687,
                    height: booladdprefferd==false?size.height*0.591:size.height*0.730,
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
                              color: Theme.of(context).indicatorColor.withOpacity(0.2),
                              //color: Colors.grey.shade300,
                              //border: Border.all(color: Colors.grey.shade700),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: TabBar(
                              physics:NeverScrollableScrollPhysics(),
                              controller: _tabController,
                              isScrollable: false,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Theme.of(context).focusColor),
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelColor:Colors.white,
                              labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              unselectedLabelStyle: TextStyle(
                                fontSize: 13,
                              ),
                              unselectedLabelColor:Theme.of(context).selectedRowColor,
                              tabs: [
                                SizedBox(
                                  width: size.width * 0.34,
                                  height: size.height * 0.043,
                                  child: Center(
                                    child: Text(
                                      'Buy',
                                      textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
                                  ),
                                ),
                                SizedBox(
                                  width:size.width * 0.34,
                                  height: size.height * 0.043,
                                  child: Center(
                                    child: Text(
                                      'Sell',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ),
                          Container(
                           // height: size.height*0.4,
                           // height: size.height*0.6,
                            height: booladdprefferd==false?size.height*0.495:size.height*0.646,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: TabBarView(
                              physics: BouncingScrollPhysics(),
                              controller: _tabController,
                              children: [
                                BuyWidget(size),
                                SellWidget(size),

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
          ),
        ],
      ),
    );
  }
  Widget BuyWidget(Size size) {
    return  SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
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
                      child: Text("At Price INR",
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
            TextFormField(
              onChanged: (value){
                print("value----"+value.toString());
                try {
                  if (priceController.text.isNotEmpty) {
                    setState(() {
                      sizeprice = 0.036;
                    });
                    totalController.text =  (int.parse(value.toString()) * int.parse(amountController.text)).toString()
                        ;
                  }
                } catch (e) {
                 // ToastShowClass.toastShow(context, "Invalid amount", Colors.red);
                }
              },
              controller: priceController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Price is required';
                }
                return null;
              },
              decoration: InputDecoration(
                // enabledBorder:OutlineInputBorder(
                //   borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.4),),
                //   borderRadius: BorderRadius.circular(2),
                // ),
                focusedErrorBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ),
                border:OutlineInputBorder(
                  borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ),
                fillColor:Theme.of(context).indicatorColor.withOpacity(0.4),
                filled: true,
                isDense: true,
                focusedBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ),
                errorBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Colors.red.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ) ,
                errorStyle: TextStyle(fontSize: 8,color: Colors.red),
                contentPadding:  EdgeInsets.only(left: 10,right:10,top:10,bottom: 10),
                hintText: '0',
                hintStyle: TextStyle(
                  color: Theme.of(context).indicatorColor,
                  fontSize: 11.0,
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).textTheme.headline3?.color,
                fontSize: 11.0,
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
                      child: Text("Amount USDT",
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
            TextFormField(
              onChanged: (value){
                try {
                  if (amountController.text.isNotEmpty) {
                    setState(() {
                      sizeamount = 0.036;
                    });
                    totalController.text =  (int.parse(value.toString()) * int.parse(priceController.text)).toString()
                    ;
                  }
                } catch (e) {
                  // ToastShowClass.toastShow(context, "Invalid amount", Colors.red);
                }
              },
              controller: amountController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Amount is required';
                }
                return null;
              },
              decoration: InputDecoration(
                focusedErrorBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ),
                border:OutlineInputBorder(
                  borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ),
                fillColor:Theme.of(context).indicatorColor.withOpacity(0.4),
                filled: true,
                isDense: true,
                focusedBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ),
                errorBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Colors.red.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ) ,
                errorStyle: TextStyle(fontSize: 8,color: Colors.red),
                contentPadding:  EdgeInsets.only(left: 10,right:10,top:10,bottom: 10),
                hintText: '0',
                hintStyle: TextStyle(
                  color: Theme.of(context).indicatorColor,
                  fontSize: 11.0,
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).textTheme.headline3?.color,
                fontSize: 11.0,
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
                      child: Text("Total INR",
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
            TextFormField(
              controller: totalController,
              decoration: InputDecoration(
                focusedErrorBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ),
                border:OutlineInputBorder(
                  borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ),
                fillColor:Theme.of(context).indicatorColor.withOpacity(0.4),
                filled: true,
                isDense: true,
                focusedBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ),
                errorBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Colors.red.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ) ,
                errorStyle: TextStyle(fontSize: 8,color: Colors.red),
                contentPadding:  EdgeInsets.only(left: 10,right:10,top:10,bottom: 10),
                hintText: '0',
                hintStyle: TextStyle(
                  color: Theme.of(context).indicatorColor,
                  fontSize: 11.0,
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).textTheme.headline3?.color,
                fontSize: 11.0,
              ),
            ),


            SizedBox(height: 26,),
            GestureDetector(
              onTap: (){
                setState(() {
                  booladdprefferd = !booladdprefferd;
                });
              },
              child: Container(
                height:24 ,
                width: size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .cardColor
                        .withOpacity(0.4),
                    borderRadius: BorderRadius.circular(2)),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left:6),
                      child: Icon(Icons.play_arrow_rounded,size: 16,color:Theme.of(context)
                          .indicatorColor ,),
                    ),
                    Text("Add Preffered Seller(Optional)",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline2?.color,
                        fontSize: 9.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
           Visibility(
             visible:booladdprefferd,
             child: Column(
               children: [

                 Container(
                   width: MediaQuery.of(context).size.width,
                   //  margin: EdgeInsets.only(top: 0,bottom: 6),
                   child: Padding(
                     padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 10.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Container(
                           child: Text("ENTER XID OF PREFERRED SELLER",
                             style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,
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
                     controller: xidpreferredSellerController,
                     decoration: InputDecoration(
                       enabledBorder: InputBorder.none,
                       disabledBorder: InputBorder.none,
                       errorBorder: InputBorder.none,
                       errorStyle: TextStyle(fontSize: 8,color: Colors.red),
                       contentPadding:  EdgeInsets.only(left: 10,bottom: 15),
                       hintText: 'Eg.crypton2p',
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
                           child: Text("Your XID",
                             style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,
                               fontSize: 10,
                               fontWeight: FontWeight.w600,),),
                         ),

                       ],
                     ),
                   ),
                 ),
                 SizedBox(height: 0,),
                 Container(
                   height:24 ,
                   width: size.width,
                   decoration: BoxDecoration(
                       color: Theme.of(context)
                           .indicatorColor
                           .withOpacity(0.4),
                       borderRadius: BorderRadius.circular(2)),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("   "+yourxidController.text,
                         style: TextStyle(
                           color: Theme.of(context).textTheme.headline3?.color,
                           fontSize: 11.0,
                         ),
                       ),
                       GestureDetector(
                         onTap: (){
                          setState(() {
                                   boolcopy = !boolcopy;
                                 });
                          boolcopy==false?"": FlutterClipboard.copy(yourxidController.text.toString()).then((value){
                                   print('Copied' + yourxidController.text.toString());
                                 });
                         },
                         child: Row(
                           children: [
                             Text(boolcopy==false?"Copy":"Copied",
                               style: TextStyle(
                                 color: Theme.of(context).textTheme.headline1?.color,
                                 fontSize: 11.0,
                               ),
                             ),
                             SizedBox(width: 4,),
                             Container(
                                 height:24 ,
                                 width: 38,
                                 decoration: BoxDecoration(
                                     color: Theme
                                         .of(context)
                                         .hoverColor.withOpacity(0.9),
                                     borderRadius: BorderRadius.circular(2)),
                                 child: Icon(Icons.file_copy,size: 14,color: Colors.white,)),
                           ],
                         ),
                       )
                     ],
                   ),
                 ),
                 Container(
                   width: MediaQuery.of(context).size.width,
                   //  margin: EdgeInsets.only(top: 0,bottom: 6),
                   child: Padding(
                     padding: EdgeInsets.only(left: 10.0, right: 4.0,top: 10.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("1. Create & Share Your XID In Crypto Groups.",
                           style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,
                             fontSize: 10,
                             fontWeight: FontWeight.w600,),),

                         Text("2. Get Matched Instantly With Sellers.",
                           style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,
                             fontSize: 10,
                             fontWeight: FontWeight.w600,),),

                       ],
                     ),
                   ),
                 ),
               ],
             ),
           ),
            SizedBox(height: 16,),
            GestureDetector(
              onTap: (){
              //  showDialog(context: context, builder: (BuildContext context)=>PeerTopeerCreateYour_xidWidgetDialog());
                  final isValid = _formKey.currentState!.validate();
                  if (!isValid) {
                  setState(() {
                    sizeprice = 0.07;
                    sizeamount = 0.07;
                  });
                    return;
                  } else {
                    if(status=="true") {
                      setState(() {
                        click = false;
                      });
                      proceedtoBuy("buy", "Buyer's");
                    }else{
                      setState(() {
                        click = true;
                      });
                      ToastShowClass.toastShow(context, "You are not Login.Please login..",Colors.red);
                    }
                  }
                },
              child: Container(
                height:26 ,
                width: size.width,
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
                    click==false?SizedBox(
                      height:20,
                      width:20,
                        child: CircularProgressIndicator()):
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

            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   //  margin: EdgeInsets.only(top: 0,bottom: 6),
            //   child: Padding(
            //     padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 10.0),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Container(
            //           child: Text("FEE:0.00%",
            //             style: TextStyle(color: Theme
            //                 .of(context)
            //                 .indicatorColor.withOpacity(0.8),
            //               fontSize: 10,
            //               fontWeight: FontWeight.w600,),),
            //         ),
            //
            //       ],
            //     ),
            //   ),
            // ),
            // Container(height: 1, color: Theme
            //     .of(context)
            //     .canvasColor,)
          ],
        ),
      ),
    );
  }

  Widget SellWidget(Size size) {
    return  SingleChildScrollView(
      child: Form(
        key: _formKeySell,
        child: Column(
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
                      child: Text("At Price INR",
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
            TextFormField(
              onChanged: (value){
                print("value----"+value.toString());
                try {
                  if (pricesellController.text.isNotEmpty) {
                    setState(() {
                      sizepricesell = 0.036;
                    });
                    totalsellController.text =  (int.parse(value.toString()) * int.parse(amountsellController.text)).toString()
                    ;
                  }
                } catch (e) {
                  // ToastShowClass.toastShow(context, "Invalid amount", Colors.red);
                }
              },
              controller: pricesellController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Price is required';
                }
                return null;
              },
              decoration: InputDecoration(
                focusedErrorBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ),
                border:OutlineInputBorder(
                  borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ),
                fillColor:Theme.of(context).indicatorColor.withOpacity(0.4),
                filled: true,
                isDense: true,
                focusedBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ),
                errorBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Colors.red.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ) ,
                errorStyle: TextStyle(fontSize: 8,color: Colors.red),
                contentPadding:  EdgeInsets.only(left: 10,right:10,top:10,bottom: 10),
                hintText: '0',
                hintStyle: TextStyle(
                  color: Theme.of(context).indicatorColor,
                  fontSize: 11.0,
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).textTheme.headline3?.color,
                fontSize: 11.0,
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
                      child: Text("Amount USDT",
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
            TextFormField(
              onChanged: (value){
                try {
                  if (amountsellController.text.isNotEmpty) {
                    setState(() {
                      sizeamountsell = 0.036;
                    });
                    totalsellController.text =  (int.parse(value.toString()) * int.parse(pricesellController.text)).toString()
                    ;
                  }
                } catch (e) {
                  // ToastShowClass.toastShow(context, "Invalid amount", Colors.red);
                }
              },
              controller: amountsellController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Amount is required';
                }
                return null;
              },
              decoration: InputDecoration(
                focusedErrorBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ),
                border:OutlineInputBorder(
                  borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ),
                fillColor:Theme.of(context).indicatorColor.withOpacity(0.4),
                filled: true,
                isDense: true,
                focusedBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ),
                errorBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Colors.red.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ) ,
                errorStyle: TextStyle(fontSize: 8,color: Colors.red),
                contentPadding:  EdgeInsets.only(left: 10,right:10,top:10,bottom: 10),
                hintText: '0',
                hintStyle: TextStyle(
                  color: Theme.of(context).indicatorColor,
                  fontSize: 11.0,
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).textTheme.headline3?.color,
                fontSize: 11.0,
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
                      child: Text("Total INR",
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
            TextFormField(
              controller: totalsellController,
              decoration: InputDecoration(
                focusedErrorBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ),
                border:OutlineInputBorder(
                  borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ),
                fillColor:Theme.of(context).indicatorColor.withOpacity(0.4),
                filled: true,
                isDense: true,
                focusedBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ),
                errorBorder:OutlineInputBorder(
                  borderSide:BorderSide(color:Colors.red.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(2),
                ) ,
                errorStyle: TextStyle(fontSize: 8,color: Colors.red),
                contentPadding:  EdgeInsets.only(left: 10,right:10,top:10,bottom: 10),
                hintText: '0',
                hintStyle: TextStyle(
                  color: Theme.of(context).indicatorColor,
                  fontSize: 11.0,
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).textTheme.headline3?.color,
                fontSize: 11.0,
              ),
            ),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(FontAwesomeIcons.wallet,size: 20,),
                SizedBox(width: 10,),
                Text( c_bal,
                  style: TextStyle(color: Theme
                      .of(context)
                      .textTheme.headline2?.color,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,),),
              ],
            ),
            SizedBox(height: 16,),
            GestureDetector(
              onTap: (){
                setState(() {
                  booladdprefferd = !booladdprefferd;
                });
              },
              child: Container(
                height:24 ,
                width: size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .cardColor
                        .withOpacity(0.4),
                    borderRadius: BorderRadius.circular(2)),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left:6),
                      child: Icon(Icons.play_arrow_rounded,size: 16,color:Theme.of(context)
                          .indicatorColor ,),
                    ),
                    Text("Add Preffered Buyer(Optional)",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.subtitle2?.color,
                        fontSize: 9.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible:booladdprefferd,
              child: Column(
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width,
                    //  margin: EdgeInsets.only(top: 0,bottom: 6),
                    child: Padding(
                      padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text("ENTER XID OF PREFERRED BUYER",
                              style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,
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
                      controller: xidpreferredBuyerController,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        errorStyle: TextStyle(fontSize: 8,color: Colors.red),
                        contentPadding:  EdgeInsets.only(left: 10,bottom: 15),
                        hintText: 'Eg.crypton2p',
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
                            child: Text("Your XID",
                              style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,),),
                          ),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 0,),
                  Container(
                    height:24 ,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .indicatorColor
                            .withOpacity(0.4),
                        borderRadius: BorderRadius.circular(2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("   "+yourxidsellController.text,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headline3?.color,
                            fontSize: 11.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              boolcopysell = !boolcopysell;
                            });
                            boolcopysell==false?"": FlutterClipboard.copy(yourxidsellController.text.toString()).then((value){
                              print('Copied sell' + yourxidsellController.text.toString());
                            });
                          },
                          child: Row(
                            children: [
                              Text(boolcopysell==false?"Copy":"Copied",
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.headline1?.color,
                                  fontSize: 11.0,
                                ),
                              ),
                              SizedBox(width: 4,),
                              Container(
                                  height:24 ,
                                  width: 38,
                                  decoration: BoxDecoration(
                                      color: Theme
                                          .of(context)
                                          .hoverColor.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(2)),
                                  child: Icon(Icons.file_copy,size: 14,color: Colors.white,)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    //  margin: EdgeInsets.only(top: 0,bottom: 6),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 4.0,top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("1. Create & Share Your XID In Crypto Groups.",
                            style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,),),

                          Text("2. Get Matched Instantly With Buyers.",
                            style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,),),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16,),

            InkWell(
              onTap: (){
              //  showDialog(context: context, builder: (BuildContext context)=>PeerTopeerCreateYour_xidWidgetDialog());
                final isValid = _formKeySell.currentState!.validate();
                if (!isValid) {
                  setState(() {
                    sizepricesell = 0.07;
                    sizeamountsell = 0.07;
                  });
                  return;
                } else {

                  if(status=="true") {
                    setState(() {
                      click = false;
                    });
                    proceedtoBuy("sell", "Seller");
                  }else{
                    setState(() {
                      click = true;
                    });
                    ToastShowClass.toastShow(context, "You are not Login.Please login..",Colors.red);
                  }
                }
              },
              child: Container(
                height:26 ,
                width: size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [ Colors.red, Colors.redAccent],
                    ),
                    borderRadius: BorderRadius.circular(2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   click==false?SizedBox(
                        height:20,
                        width:20,
                        child: CircularProgressIndicator()):
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

            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   //  margin: EdgeInsets.only(top: 0,bottom: 6),
            //   child: Padding(
            //     padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 10.0),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Container(
            //               child: Text("FEE:0.00%",
            //                 style: TextStyle(color: Theme
            //                     .of(context)
            //                     .indicatorColor.withOpacity(0.8),
            //                   fontSize: 10,
            //                   fontWeight: FontWeight.w600,),),
            //             ),
            //             Container(
            //               child: Text("ADD/EDIT PAYMENT DETAILS",
            //                 style: TextStyle(color: Theme
            //                     .of(context)
            //                     .focusColor.withOpacity(0.8),
            //                   fontSize: 10,
            //                   fontWeight: FontWeight.w600,),),
            //             ),
            //           ],
            //         ),
            //
            //       ],
            //     ),
            //   ),
            // ),
            // Container(height: 1, color: Theme
            //     .of(context)
            //     .canvasColor,)
          ],
        ),
      ),
    );
  }
}
