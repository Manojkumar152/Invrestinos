import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:investions/Api/ApiCollections.dart';
import 'package:investions/Api/ApiMain.dart';
import 'package:investions/Constant/Error_Screen.dart';
import 'package:investions/Constant/Nodata.dart';
import '../../Constant/ToastClass.dart';


String param = '';
class OrderWidget extends StatefulWidget {
  static const id = 'OrderWidget';

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget>with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int ind = 0;


  List opendata = [];
  List opendatanew = [];
  final scaffoldState = GlobalKey<ScaffoldState>();
  List limit = [];
  List<Limit> _listlimit = Limit.getlimit();
  Limit? selectedlimit;
  String SelectLimit = '';
  bool low = false;
  var item;
  String interval = "1m";
  String orderid = '';
  String withcurrency = '';
  String currency = '';

  var atpricecontroller = TextEditingController();
  var amountcontroller = TextEditingController();
  var totalcontroller = TextEditingController();

  bool isProgress = false;
  static int pagenumber = 1;
  bool _isTrackProgress = false;
  bool datafetch = false;
  bool nodta=false;
  bool day = false,error=false;
  bool interneterror=false;
  String type = "remaining",per_page = '50';


  @override
  void initState() {
    getOpenData(pagenumber,type,per_page);
    _tabController = TabController(length: 2, vsync:this);
    _tabController.addListener(() {
      setState(() {
        if(_tabController.index==0){
          setState(() {
            isProgress = false;
          });
          getOpenData(pagenumber,"remaining","50");
        }else{
          setState(() {
            isProgress = false;
          });
          getOpenData(pagenumber,"completed","50");
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  Future<void>getOpenData(int pagenumber,String type,String per_page) async {
    try{
      final paramDic = {
        "type": type,
        "page": pagenumber.toString(),
        "per_page": per_page,
      };
      print("paranDic"+paramDic.toString());
      var response = await APIMainClassbinance(ApiCollections.OpenData, paramDic, "Get");
      var data = json.decode(response.body);
      print('response ===' + data.toString());
      opendatanew.clear();
      if (pagenumber == 1) {
        opendata.clear();
      }
      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            isProgress = true;
            error=false;
            opendatanew = data['data']['data'];
            opendata.addAll(opendatanew);
            if(opendata.length>0){
              setState(() {
                nodta=false;
                isProgress = true;
              });
            }else{
              setState(() {
                nodta=true;
                isProgress = true;
              });
            }
            print('Open Data' + opendata.toString());
          });
        }
      } else {
        setState(() {
          pagenumber = pagenumber;
          error=true;
          isProgress = true;
        });
      }
    }catch(e){
      setState(() {
        error=true;
        isProgress = true;
      });
      ToastShowClass.toastShow(context,"Error",Colors.redAccent);
    }
  }

  Future<void> CancelOrder(String orderid) async {
    final paramDic = {
      "": '',
    };
    var response = await LBMAPIMainClass(ApiCollections.cancelorder +orderid.toString(), paramDic, "Post");
    var data = json.decode(response.body);
    opendata.clear();
    if (response.statusCode == 200) {
      setState(() {
        ToastShowClass.toastShow(context, data['message'], Colors.blue);
      });
      ToastShowClass.toastShow(context, data['message'], Colors.blue);
    } else {}
  }

  Future<void> EditOrder(String orderid, String withcurrency) async {
    final paramDic = {
      "at_price": atpricecontroller.text.toString(),
      "currency": currency.toString(),
      "with_currency": withcurrency.toString(),
      "total": totalcontroller.text.toString(),
      "quantity": amountcontroller.text.toString(),
      "order_type": "buy",
      "type": SelectLimit.toString(),
    };
    var response =
    await LBMAPIMainClass(ApiCollections.EditOrder + orderid, paramDic, "Put");
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        ToastShowClass.toastShow(context, data['message'], Colors.blue);
        getOpenData(pagenumber,"remaining","50");
        Navigator.pop(context);
      });
      ToastShowClass.toastShow(context, data['message'], Colors.red);
    } else {}
  }

  void calcuate(String value) {
    totalcontroller.text = (double.parse(atpricecontroller.text.toString()) *
        double.parse(amountcontroller.text.toString()))
        .toString();
  }


  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              " Edit",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      key: scaffoldState,
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
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
                          // InkWell(
                          //     onTap: (){
                          //       Navigator.pop(context);
                          //     },
                          //     child: Icon(Icons.arrow_back,color: Colors.white,)),
                          SizedBox(width: 10,),
                          Text("My Order",style: TextStyle(color: Colors.white,),)
                        ],
                      ),
                    ),
                    SizedBox(height: size.height*0.1,),
                    Container(
                      height: size.height * 0.050,
                      width: size.width,
                      margin: EdgeInsets.only(right: size.width*0.05),
                      decoration: BoxDecoration(
                        color: Theme.of(context).textTheme.headline1?.color,
                        //  color: Colors.red,
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
                          fontSize: 12,
                        ),
                        unselectedLabelColor:Theme.of(context).indicatorColor.withOpacity(1),
                        tabs: [
                          SizedBox(
                            width: size.width * 0.38 ,
                            child: Text(
                              'Open Orders',
                              textAlign: TextAlign.center,style: TextStyle(fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            width:size.width * 0.38,
                            child: Text(
                              'Complete Orders',
                              textAlign: TextAlign.center,style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
                margin:EdgeInsets.only(top: size.height*0.250, left: 16.0, right: 16.0),
                elevation: 0.5,
                color: Theme.of(context).cardColor,
                //color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    )),

                child: Container(
                    height: size.height*0.85,
                    // /color: Colors.red,
                    child:TabBarView(
                      physics: BouncingScrollPhysics(),
                      controller: _tabController,
                      children: [
                        isProgress==false?
                        Center(child: Container(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Theme.of(context).hoverColor,),)):error?CustomError():OpenOrder(size),
                        isProgress==false?Center(child: Container(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Theme.of(context).hoverColor,),)):error?CustomError():CompleteOrder(size),
                      ],
                    )
                )
            )
          ],
        ),
      ),
    );
  }
  Widget CompleteOrder(Size size){
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: size.width*0.18,
                    child: Center(child: Text("PAIR",style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 10,fontWeight: FontWeight.w500),))),
                Container(
                    width: size.width*0.18,
                    child: Center(child: Text("QUANTITY",style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 10,fontWeight: FontWeight.w500),))),
                Container(
                    width: size.width*0.18,
                    child: Center(child: Text(" PRICE",style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 10,fontWeight: FontWeight.w500),))),
                Container(

                    width: size.width*0.18,
                    child: Center(child: Text("STATUS",style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 10,fontWeight: FontWeight.w500),))),
                // Container(
                //     width: size.width*0.1,
                //     child: Center(child: Text(""))),
              ],
            ),
          ),
          SizedBox(height:5,),
          Divider(color: Theme.of(context).indicatorColor.withOpacity(0.8),thickness: 0.3,),
          SizedBox(height: 5,),
          isProgress==false?Center(child: Container(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(color: Theme.of(context).hoverColor,),)):nodta?Nodata(): ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              primary: false,
              itemCount: opendata.length,
              itemBuilder: (BuildContext context,int index){
                return Container(
                  width: size.width,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, "/OrderDetails",arguments:opendata[index]);
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width*0.18,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(opendata[index]['currency'] == null ? "" : opendata[index]['currency'].toString(),
                                    style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w500),),
                                  SizedBox(width: size.width*0.1,child:Divider(color: Theme.of(context).indicatorColor.withOpacity(0.8),thickness: 0.7,height: 3,),),
                                  Text(opendata[index]['with_currency'] == null ? "" : opendata[index]['with_currency'].toString(),
                                    style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 9,fontWeight: FontWeight.w300),)
                                ],
                              ),
                            ),
                            Container(
                              width: size.width*0.18,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(opendata[index]['quantity'] == null ? "" : opendata[index]['quantity'].toString(),
                                    style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w500),),
                                  SizedBox(width: size.width*0.1,child:Divider(color: Theme.of(context).indicatorColor.withOpacity(0.8),thickness: 0.7,height: 3,),),
                                  Text(opendata[index]['at_price'] == null ? "" : opendata[index]['at_price'].toString(),
                                    style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 9,fontWeight: FontWeight.w300),)
                                ],
                              ),
                            ),
                            Container(
                              width: size.width*0.18,
                              child: Center(child: Text(opendata[index]['total'] == null ? "" : opendata[index]['total'].toString(),
                                style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w500),)),

                            ),
                            Container(
                              width: size.width*0.18,
                              child: Center(child: Text(opendata[index]['current_status'] == null ? "" : opendata[index]['current_status'].toString(),
                                style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w500),)),
                            ),
                            // Container(
                            //   width: size.width*0.1,
                            //   child: Align(
                            //       alignment:Alignment.bottomCenter,
                            //       child:Icon(FontAwesomeIcons.circleChevronRight,size: 13,color: Theme.of(context).indicatorColor.withOpacity(1),)),
                            // ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Divider(color: Theme.of(context).indicatorColor.withOpacity(0.8),thickness: 0.3),
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
  Widget OpenOrder(Size size){
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: size.width*0.18,
                    child: Center(child: Text("PAIR",style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 10,fontWeight: FontWeight.w500),))),
                Container(
                    width: size.width*0.18,
                    child: Center(child: Text("QUANTITY",style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 10,fontWeight: FontWeight.w500),))),
                Container(
                    width: size.width*0.18,
                    child: Center(child: Text(" TOTAL",style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 10,fontWeight: FontWeight.w500),))),
                Container(

                    width: size.width*0.18,
                    child: Center(child: Text("STATUS",style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 10,fontWeight: FontWeight.w500),))),
                // Container(
                //     width: size.width*0.1,
                //     child: Center(child: Text(""))),
              ],
            ),
          ),
          SizedBox(height:5,),
          Divider(color: Theme.of(context).indicatorColor.withOpacity(0.8),thickness: 0.3,),
          SizedBox(height: 5,),
          isProgress==false?Center(child: Container(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(color: Theme.of(context).hoverColor,),)):nodta?Nodata():ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              primary: false,
              itemCount: opendata.length,
              itemBuilder: (BuildContext context,int index){
                return GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, "/OrderDetails",arguments:opendata[index]);
                  },
                  child: Column(
                    children: [
                      Dismissible(
                        key: UniqueKey(),
                        confirmDismiss: (direction) async {if (direction == DismissDirection.endToStart) {
                            showDialog(
                                context: context,
                                builder:(BuildContextcontext) {
                                  return AlertDialog(
                                    backgroundColor: Theme.of(context).hintColor,
                                    content: Text("Are you sure you want to delete ?"),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("Cancel",
                                          style: TextStyle(color: Colors.white.withOpacity(1)),),
                                        onPressed:
                                            () {
                                          getOpenData(pagenumber,"remaining","50");
                                          Navigator.of(context).pop();
                                        },
                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent)),
                                      ),
                                      TextButton(
                                        child:
                                        Text(
                                          "Delete",
                                          style: TextStyle(
                                              color:
                                              Colors.white),
                                        ),
                                        onPressed:
                                            () {
                                          orderid = opendata[index]['id'].toString();
                                          CancelOrder(opendata[index]['id'].toString()).then((value) =>
                                              getOpenData(pagenumber,"remaining","50"));
                                          Navigator.pop(context);
                                        },
                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
                                      ),
                                    ],
                                  );
                                });

                          } else if (direction == DismissDirection.startToEnd) {
                            param = opendata[index]['currency'] + opendata[index]['with_currency'];
                            setState(() {
                              atpricecontroller.text =
                              opendata[index]['at_price'];amountcontroller.text = opendata[index]['quantity'].toString();
                              totalcontroller.text = (double.parse(opendata[index]['at_price'].toString()) *
                                  double.parse(amountcontroller.text.toString())).toString();
                            });
                            scaffoldState
                                .currentState!
                                .showBottomSheet(
                                  (context) =>
                                  SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child:
                                      Center(
                                        child: Container(
                                          height: 450,
                                          margin: EdgeInsets.only(left: 10.0,right: 10.0),
                                          decoration: BoxDecoration(color: Theme
                                              .of(context)
                                              .hintColor,
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(4.0), topLeft: Radius.circular(4.0)),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .start,
                                            mainAxisSize:
                                            MainAxisSize
                                                .min,
                                            children: <
                                                Widget>[
                                              Container(
                                                height:
                                                50,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Center(
                                                  child: Text(
                                                    'Buy',
                                                    textAlign: TextAlign.center,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),),
                                                decoration:
                                                BoxDecoration(
                                                  color: Theme
                                                      .of(context)
                                                      .hoverColor,
                                                  borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(4.0),
                                                      topLeft: Radius.circular(4.0)),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left:
                                                    20,
                                                    right:
                                                    20),
                                                child:
                                                Column(
                                                  children: [
                                                    Align(
                                                      alignment: Alignment.topRight,
                                                      child: SizedBox(
                                                        height: 60,
                                                        width: 150,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: DropdownButtonFormField<Limit>(
                                                            hint: Text(
                                                              'Select',
                                                              style: TextStyle(fontSize: 14.0, color: Theme.of(context).textTheme.headline2?.color),
                                                            ),
                                                            value: selectedlimit,
                                                            onChanged: (Value) {
                                                              setState(() {
                                                                selectedlimit = Value;
                                                                SelectLimit = selectedlimit!.name;
                                                              });
                                                            },

                                                            // validator: (value) =>
                                                            // value == null ? 'This Field is required' : null,
                                                            items: _listlimit.map((Limit user) {
                                                              return DropdownMenuItem<Limit>(
                                                                value: user,
                                                                child: Row(
                                                                  children: <Widget>[
                                                                    Text(
                                                                      user.name,
                                                                      style: TextStyle(fontSize: 14.0,color: Theme.of(context).textTheme.headline2?.color),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    //currency_data['FROMSYMBOL']
                                                    SizedBox(
                                                      height: 30,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "AT PRICE",
                                                            style: TextStyle(color: Theme
                                                                .of(context)
                                                                .indicatorColor.withOpacity(0.8),
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w600,),
                                                          ),
                                                          VerticalDivider(
                                                            color: Colors.white38,
                                                          ),
                                                          Text(
                                                            opendata[index]['currency'].toString(),
                                                            style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w600,),
                                                          ),
                                                          SizedBox(width: 10),
                                                          // Text(
                                                          //   "0.36%",
                                                          //   style: TextStyle(color: Colors.greenAccent, fontSize: 15, fontWeight: FontWeight.bold),
                                                          // ),
                                                          // SizedBox(
                                                          //   width: 50,
                                                          // ),
                                                        ],
                                                      ),
                                                    ),

                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 200,
                                                          child: TextField(
                                                            enabled: true,
                                                            onChanged: calcuate,
                                                            decoration: InputDecoration(
                                                              hintText: atpricecontroller.text,
                                                              hintStyle: TextStyle(color: Colors.white),
                                                              border: InputBorder.none,
                                                              focusedBorder: InputBorder.none,
                                                              enabledBorder: InputBorder.none,
                                                              errorBorder: InputBorder.none,
                                                              disabledBorder: InputBorder.none,
                                                            ),
                                                            // style: TextStyle(color: Colors.white),
                                                            autofocus: false,
                                                            keyboardType: TextInputType.number,
                                                            controller: atpricecontroller,
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              print("CLICKED BUTTON ");
                                                              low = true;
                                                              //getprice();
                                                              totalcontroller.text = (double.parse(atpricecontroller.text) * double.parse(amountcontroller.text)).toString();
                                                            });
                                                          },
                                                          child: Positioned(
                                                            right: 20,
                                                            child: Text(
                                                              "LOWEST PRICE",
                                                              style: TextStyle(color: Theme
                                                                  .of(context)
                                                                  .hoverColor.withOpacity(0.9),
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w600,),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(color: Colors.white30),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(
                                                    left:
                                                    20,
                                                    right:
                                                    20),
                                                child:
                                                Column(
                                                  children: [
                                                    //currency_data['FROMSYMBOL']
                                                    SizedBox(
                                                      height: 30,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "AMOUNT",
                                                            style: TextStyle(color: Theme
                                                                .of(context)
                                                                .indicatorColor.withOpacity(0.8),
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w600,),
                                                          ),
                                                          VerticalDivider(
                                                            color: Colors.white38,
                                                          ),
                                                          Text(
                                                            opendata[index]['with_currency'].toString(),
                                                            style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w600,),
                                                          ),
                                                          SizedBox(width: 10),
                                                        ],
                                                      ),
                                                    ),
                                                    TextField(
                                                      onChanged: calcuate,
                                                      decoration: InputDecoration(
                                                        hintText: amountcontroller.text,
                                                        border: InputBorder.none,
                                                        focusedBorder: InputBorder.none,
                                                        enabledBorder: InputBorder.none,
                                                        errorBorder: InputBorder.none,
                                                        disabledBorder: InputBorder.none,
                                                      ),
                                                      autofocus: false,
                                                      keyboardType: TextInputType.number,
                                                      controller: amountcontroller,
                                                    ),
                                                    Divider(
                                                      height: 4,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left:
                                                    20,
                                                    right:
                                                    20),
                                                child:
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 30,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "TOTAL",
                                                            style: TextStyle(color: Theme
                                                                .of(context)
                                                                .indicatorColor.withOpacity(0.8),
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w600,),
                                                          ),
                                                          VerticalDivider(
                                                            color: Colors.white38,
                                                          ),
                                                          Text(
                                                            opendata[index]['currency'].toString(),
                                                            style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w600),
                                                          ),
                                                          SizedBox(width: 10),
                                                        ],
                                                      ),
                                                    ),
                                                    TextField(
                                                      decoration: InputDecoration(
                                                        enabled: false,
                                                        hintText: totalcontroller.text == null ? "0.00" : totalcontroller.text,
                                                        border: InputBorder.none,
                                                        focusedBorder: InputBorder.none,
                                                        enabledBorder: InputBorder.none,
                                                        errorBorder: InputBorder.none,
                                                        disabledBorder: InputBorder.none,
                                                      ),
                                                      autofocus: false,
                                                      controller: totalcontroller,
                                                    ),
                                                    Divider(),
                                                  ],
                                                ),
                                              ),
                                              Center(
                                                  child:
                                                  RaisedButton(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(4)),
                                                    onPressed:
                                                        () {
                                                      orderid =
                                                          opendata[index]['id'].toString();
                                                      withcurrency =
                                                          opendata[index]['with_currency'].toString();
                                                      currency =
                                                          opendata[index]['currency'].toString();
                                                      if (selectedlimit !=
                                                          null) {
                                                        EditOrder(orderid,
                                                            withcurrency);
                                                      } else {
                                                        ToastShowClass.toastShow(
                                                            context,
                                                            "Select Limit",
                                                            Colors.red);
                                                      }
                                                    },
                                                    color: Theme
                                                        .of(context)
                                                        .hoverColor.withOpacity(0.9),
                                                    child: Text(
                                                        "Edit",
                                                        style:
                                                        TextStyle(color: Theme.of(context).textTheme.headline1?.color,fontWeight: FontWeight.w600)),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      )),
                            );
                          }
                          return null;
                        },
                        background: slideRightBackground(),
                        secondaryBackground:
                        slideLeftBackground(),
                        child:Container(
                          width: size.width,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: size.width*0.18,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(opendata[index]['currency'] == null ? "" : opendata[index]['currency'].toString(),
                                          style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w500),),
                                        SizedBox(width: size.width*0.1,child:Divider(color: Theme.of(context).indicatorColor.withOpacity(0.8),thickness: 0.7,height: 3,),),
                                        Text(opendata[index]['with_currency'] == null ? "" : opendata[index]['with_currency'].toString(),
                                          style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 9,fontWeight: FontWeight.w300),)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: size.width*0.18,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(opendata[index]['quantity'] == null ? "" : opendata[index]['quantity'].toString(),
                                          style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w500),),
                                        SizedBox(width: size.width*0.1,child:Divider(color: Theme.of(context).indicatorColor.withOpacity(0.8),thickness: 0.7,height: 3,),),
                                        Text(opendata[index]['at_price'] == null ? "" : opendata[index]['at_price'].toString(),
                                          style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.8),fontSize: 9,fontWeight: FontWeight.w300),)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: size.width*0.18,
                                    child: Center(child: Text(opendata[index]['total'] == null ? "" : opendata[index]['total'].toString(),
                                      style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w500),)),

                                  ),
                                  Container(
                                    width: size.width*0.18,
                                    child: Column(
                                      children: [
                                        Center(child: Text(opendata[index]['current_status'] == null ? "" : opendata[index]['current_status'].toString(),
                                          style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w500),)),
                                        SizedBox(height: 2,),
                                        Container(
                                          height: 17,
                                          width:size.width*0.12,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                            gradient: LinearGradient(colors: [
                                              opendata[index]['order_type'] == "sell" ? Colors.red : Colors.green,
                                              opendata[index]['order_type']== "sell"? Colors.red : Colors.green,
                                            ]),
                                        ),
                                          child: Center(
                                            child: Text(opendata[index]['order_type'].toString(),
                                        style: TextStyle(color: Theme.of(context).textTheme.headline1?.color, fontSize: 10, fontWeight: FontWeight.w600),),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // Container(
                                  //   width: size.width*0.1,
                                  //   child: Align(
                                  //       alignment:Alignment.bottomCenter,
                                  //       child:Icon(FontAwesomeIcons.circleChevronRight,size: 13,color: Theme.of(context).indicatorColor.withOpacity(1),)),
                                  // ),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Divider(color: Theme.of(context).indicatorColor.withOpacity(0.8),thickness: 0.3),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                );
              }),
          SizedBox(height: 47,),
        ],
      ),
    );
  }
}
class Limit {
  String id;
  String name;

  Limit(this.id, this.name);

  static List<Limit> getlimit() {
    return <Limit>[
      Limit('0', 'Limit'),
      Limit('1', 'No Limit'),
    ];
  }
}