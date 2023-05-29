
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:investions/Api/ApiCollections.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:investions/Constant/CommonClass.dart';
import 'package:investions/Constant/SharedPreferenceClass.dart';
import 'package:investions/Constant/ToastClass.dart';

import '../../Api/ApiMain.dart';
import '../P2P/P2Pbuy_sell.dart';
import '../Quicky_buy.dart';

class Buy_Binace extends StatefulWidget {
  CoinMarketData? data;
  bool issell=false;
  Buy_Binace({this.data,required this.issell});

  @override
  State<Buy_Binace> createState() => _Buy_BinaceState();
}

class _Buy_BinaceState extends State<Buy_Binace> {
  TextEditingController limitPriceController = TextEditingController();
  TextEditingController RupeesController = TextEditingController();
  TextEditingController CryptoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var payableAmount;
  bool isLimit = true,limitpadding=false,quantitypadding=false,cryptopadding=false,click=false;
  String currencyName = '';
  String currencyShortName = '';
  String currencyImage = '';
  String currencyPrice = '';
  String currencyFamily = '';
  String currencyPair = '',Balance='0',Dacimalpair='';

  @override
  void initState() {
    print(widget.data!.familycoin.toString());
    getCrypto();
    setState(() {
      currencyName = widget.data!.currency_data['currency_name'];
      currencyShortName = widget.data!.currency_data['currency_shortName'];
      currencyImage = widget.data!.currency_data['currency_Image'];
      limitPriceController.text=widget.data!.currency_data['PRICE'].toString();
      currencyPrice = widget.data!.currency_data['PRICE'];
      currencyFamily = widget.data!.familycoin;
      currencyPair = widget.data!.pair;
      Dacimalpair=widget.data!.currency_data["DecimalValue"].toString();
    });
    print("Decimal value"+Dacimalpair.toString());
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
          if(userdata[i]["symbol"].toString()==widget.data!.familycoin.toString()){
          setState(() {
            Balance=userdata[i]["c_bal"].toString();
          });
          }
        }
        print(userdata.toString());
      }
    }catch(e){
      print(e.toString());
    }
  }
  Future<void> proceedtoBuy() async {
    var tokenValue = await SharedPreferenceClass.GetSharedData("token");
    final paramDic = {
      "at_price": double.parse(isLimit ? limitPriceController.text.toString() : currencyPrice.toString()).toStringAsFixed(int.parse(Dacimalpair)),
      "currency": currencyShortName.toString(),
      "with_currency": currencyFamily.toString(),
      "quantity": CryptoController.text.toString(),
      "total": double.parse(RupeesController.text.toString()).toStringAsFixed(int.parse(Dacimalpair)),
      "order_type": widget.issell ? "sell" : "buy",
      "type": isLimit ? "limit" : "market",
    };
    print(paramDic);
    final uri = Uri.http(ApiCollections.NODELBM_BaseURL, ApiCollections.buy);
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.postUrl(uri);
    request.headers.set('Content-Type', 'application/json');
    request.headers.set('Accept', 'application/json');
     request.headers.set('Authorization', 'Bearer $tokenValue');
    request.add(utf8.encode(json.encode(paramDic)));
    HttpClientResponse response = await request.close();
    print(request.headers.toString());
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      var data = jsonDecode(reply);
      print('Data=== >' + data.toString());
      if (data["status_code"] == '1') {
        setState(() {
          click = false;
        });
        ToastShowClass.toastShow(context, data['message'].toString(), Colors.blue);
        Navigator.of(context).pop();
        if (data['status_text'] != 'failed') {
          ToastShowClass.toastShow(context, data["message"], Colors.red);
          setState(() {
            click=false;
          });
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Quick_buy(p2pdata(2,2))));
        } else {
          setState(() {
            click=false;
          });
          ToastShowClass.toastShowerror(context, data["message"], Colors.red);
        }
      }else {
        setState(() {
          click=false;
        });
        ToastShowClass.toastShowerror(context, data["message"], Colors.red);
      }
    }
    else {
      setState(() {
        click=false;
      });
      ToastShowClass.toastShow(context, 'Something Went Wrong', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Dialog(
        elevation: 0.5,
        backgroundColor: Theme.of(context).hintColor,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Container(
            height: size.height*0.5,
            width: size.width,
            decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(6.0),),
            gradient: LinearGradient(
            colors: [Theme.of(context).hintColor, Theme.of(context).hintColor
            ],
              ),
              border: Border.all(width: 1,color: Theme.of(context).indicatorColor.withOpacity(0.6))
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.only(left:6.0,right: 6.0,top:4.0,bottom: 8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left:6),
                              child: Text(widget.issell?"Sell ":"Buy ",style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 14,fontWeight: FontWeight.w600),),
                            ),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  isLimit=!isLimit;
                                  RupeesController.clear();
                                  CryptoController.clear();
                                });
                                if(isLimit==true){
                                  setState(() {
                                    limitPriceController.text=widget.data!.currency_data['PRICE'].toString();
                                  });
                                }else{
                                  limitPriceController.clear();
                                }
                                print(limitPriceController.text);
                              },
                              child: Container(
                                height:22 ,
                                width:70,
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
                                      Text( isLimit == false?"Market":"Limit",textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Theme.of(context).textTheme.headline1?.color,
                                            fontSize: 8.0,fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      isLimit == false?Icon(Icons.keyboard_arrow_down_sharp,size: 22,color: Theme.of(context).textTheme.headline1?.color,):Icon(Icons.keyboard_arrow_up_sharp,size: 22,color: Theme.of(context).textTheme.headline1?.color,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Visibility(
                          visible: isLimit,
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("At Price USDT",
                                        style: TextStyle(color: Theme
                                            .of(context)
                                            .indicatorColor.withOpacity(0.8),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8,),
                                Container(
                                  height:size.height*0.042 ,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .indicatorColor
                                          .withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(2)),
                                  child: TextFormField(
                                    onChanged: (val) {
                                      if (CryptoController.text.isNotEmpty) {
                                        RupeesController.text = (double.parse(CryptoController.text.toString()) * double.parse(val.toString())).toString();
                                      }else{
                                        RupeesController.clear();
                                        RupeesController.clear();
                                      }
                                    },
                                    controller: limitPriceController,
                                      keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      errorStyle: TextStyle(fontSize: 9,color: ColorsCollectionsDark.greenlightColor),
                                      contentPadding:  EdgeInsets.only(left: 10,bottom: limitpadding?5:17),
                                      hintText: 'you price',
                                      hintStyle: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 10.0,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      color: Theme.of(context).textTheme.headline3?.color,
                                      fontSize: 11.0,
                                    ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          setState(() {
                                            limitpadding=true;
                                          });
                                          return 'enter you price';
                                        }
                                        else {
                                          setState(() {
                                            limitpadding=false;
                                          });
                                          return null;
                                        }
                                      }
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
                            padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Amount ${widget.data!.currency_data["currency_shortName"].toString()}",
                                        style: TextStyle(color: Theme
                                            .of(context)
                                            .indicatorColor.withOpacity(0.8),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,),),
                                      Text(widget.data!.currency_data["currency_name"].toString(),
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
                          height:size.height*0.042,
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .indicatorColor
                                  .withOpacity(0.4),
                              borderRadius: BorderRadius.circular(2)),
                          child: Center(
                            child: TextFormField(
                              onChanged: (value){
                                try {
                                  if (CryptoController.text.isNotEmpty) {
                                    RupeesController.text = isLimit ? (double.parse(value.toString()) * double.parse(limitPriceController.text)).toString()
                                        : (double.parse(value.toString()) * double.parse(currencyPrice.toString())).toString();
                                  }
                                } catch (e) {
                                  ToastShowClass.toastShow(context, "Invalid amount", Colors.red);
                                }
                              },
                              controller: CryptoController,
                                keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                // enabledBorder: InputBorder.none,
                                // disabledBorder: InputBorder.none,
                                 errorBorder: InputBorder.none,
                                errorStyle: TextStyle(fontSize: 10,color: ColorsCollectionsDark.greenlightColor),
                                contentPadding:  EdgeInsets.only(left: 10,bottom: quantitypadding?5:17),
                                //hintText: "Amount ${currencyShortName}",
                                hintText: "0",
                                hintStyle: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 10.0,
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                color: Theme.of(context).textTheme.headline3?.color,
                                fontSize: 11.0,
                              ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    setState(() {
                                      quantitypadding=true;
                                    });
                                    return 'enter quantity';
                                  }
                                  else {
                                    setState(() {
                                      quantitypadding=false;
                                    });
                                    return null;
                                  }
                                }
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
                                      Text("Total USDT",
                                        style: TextStyle(color: Theme
                                            .of(context)
                                            .indicatorColor.withOpacity(0.8),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,),),
                                      Text("0",
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
                            enabled: false,
                            controller: RupeesController,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              errorStyle: TextStyle(fontSize: 8,color: Colors.red),
                              contentPadding:  EdgeInsets.only(left: 10,bottom: 15),
                             // hintText: 'In USDT',
                              hintText: '0',
                              hintStyle: TextStyle(
                                color: Colors.white54,
                                fontSize: 10.0,
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
                            // GestureDetector(
                            //   onTap: (){
                            //     double persendt= (double.parse(Balance.toString())*0.10)/double.parse(currencyPrice.toString());
                            //     print(persendt.toString()+"   "+(double.parse(Balance.toString())*0.10).toString());
                            //     setState(() {
                            //       CryptoController.text=persendt.toString().split(".").first;
                            //       RupeesController.text=(double.parse(Balance.toString())*0.10).toString();
                            //     });
                            //   },
                            //   child: Text("10%",
                            //     style: TextStyle(color: Theme
                            //         .of(context)
                            //         .indicatorColor.withOpacity(0.8),
                            //       fontSize: 10,
                            //       fontWeight: FontWeight.w600,),),
                            // ),
                            GestureDetector(
                              onTap: (){
                               double persendt= (double.parse(Balance.toString())*0.25)/double.parse(currencyPrice.toString());
                               print(persendt.toString()+"   "+(double.parse(Balance.toString())*0.25).toString());
                               setState(() {
                                 CryptoController.text=persendt.toString().split(".").first;
                                 RupeesController.text=(double.parse(Balance.toString())*0.25).toString();
                               });
                              },
                              child: Text("25%",
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .indicatorColor.withOpacity(0.8),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,),),
                            ),
                            GestureDetector(
                              onTap: (){
                                double persendt= ((double.parse(Balance.toString()))*0.50)/double.parse(currencyPrice.toString());
                                print(persendt.toString()+"   "+((double.parse(Balance.toString())*0.50).toString()));
                                setState(() {
                                  CryptoController.text=persendt.toString().split(".").first;
                                  RupeesController.text=((double.parse(Balance.toString())*100)/50).toString();
                                });
                              },
                              child: Text("50%",
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .indicatorColor.withOpacity(0.8),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,),),
                            ),
                            GestureDetector(
                              onTap: (){
                                double persendt= ((double.parse(Balance.toString())*0.75))/double.parse(currencyPrice.toString());
                                print(persendt.toString()+"   "+((double.parse(Balance.toString())*0.75)).toString());
                                setState(() {
                                  CryptoController.text=persendt.toString().split(".").first;
                                  RupeesController.text=((double.parse(Balance.toString())*0.75)).toString();
                                });
                              },
                              child: Text("75%",
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .indicatorColor.withOpacity(0.8),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,),),
                            ),
                            GestureDetector(
                              onTap: (){
                                double persendt= ((double.parse(Balance.toString())*1))/double.parse(currencyPrice.toString());
                                print(persendt.toString()+"   "+(double.parse(Balance.toString())*0.1).toString());
                                setState(() {
                                  CryptoController.text=persendt.toString().split(".").first;
                                  RupeesController.text=((double.parse(Balance.toString())*0.1)).toString();
                                });
                              },
                              child: Text("100%",
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .indicatorColor.withOpacity(0.8),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,),),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Column(
                          children: [
                            Row(
                              children: [
                                Image.asset("assets/images/wallet.png",height: 16,width: 14,color: Theme
                                    .of(context)
                                    .indicatorColor ,),
                                SizedBox(width: 4,),
                                Text(widget.issell?Balance.toString()+" "+widget.data!.pair.toString():Balance.toString()+" "+widget.data!.familycoin.toString(),
                                  style: TextStyle(color: Theme
                                      .of(context)
                                      .indicatorColor.withOpacity(0.8),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,),),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 18,),
                        Container(
                          height:26 ,
                          width: size.width,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors:widget.issell?[
                                  Colors.red,Colors.redAccent
                                ]:[Theme
                                    .of(context)
                                    .hoverColor.withOpacity(0.9),
                                  Theme.of(context)
                                      .hoverColor.withOpacity(0.9)
                                ],
                              ),
                              borderRadius: BorderRadius.circular(2)),
                          child: InkWell(
                            onTap: (){
                              if(_formKey.currentState!.validate()){
                                setState(() {
                                  click=true;
                                });
                                proceedtoBuy();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                click?Center(child:SizedBox(width: 15,height: 15,child: CircularProgressIndicator(color:Theme.of(context).textTheme.headline1?.color,)),)
                                    : Text(widget.issell?"Sell "+widget.data!.currency_data["currency_shortName"].toString():"Buy "+widget.data!.currency_data["currency_shortName"].toString(),textAlign: TextAlign.center,
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
                  ),
                )
              ),
    )
    );
  }
}
