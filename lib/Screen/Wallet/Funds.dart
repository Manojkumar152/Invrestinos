import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:investions/Api/ApiCollections.dart';
import 'package:investions/Api/ApiMain.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:investions/Constant/ToastClass.dart';
import 'package:investions/Screen/CurrencyPerference.dart';

import '../../Constant/CommonClass.dart';
import '../../Constant/Error_Screen.dart';
import '../../Constant/Nodata.dart';
import '../Setting/SettingWidget.dart';

class Funds extends StatefulWidget {
  static const id = "Funds";

  @override
  State<Funds> createState() => _FundsState();
}

class _FundsState extends State<Funds> {
  bool status = false,nodata=false;
  List userdata=[];
  List BalanceList=[];
  bool loading=true,showerror=false;
  String Balance="";
  Future<void>getCrypto()async{
    final paramDic = {
      "": '',
    };
    try{
      var response=await APIMainClassbinance(ApiCollections.getcrypto, paramDic,"Get");
      var data=jsonDecode(response.body);
      if(data["status_code"]=="1"){
        setState(() {
          userdata=data["data"];
          loading=false;
          showerror=false;
          Balance=data["total"].toString();
        });
        for(int i=0;i<userdata.length;i++){
          if(double.parse(userdata[i]["c_bal"].toString())>0.0){
            BalanceList.add(userdata[i]);
          }
        }
        print(userdata.toString());
        if(userdata.length<0){
          setState(() {
            loading=false;
            nodata=true;
          });
          ToastShowClass.toastShow(context,"No data",Colors.red);
        }else{
          setState(() {
            nodata=false;
          });
        }
      }else{
        setState(() {
          showerror=true;
        });
        ToastShowClass.toastShow(context,data["message"].toString(),Colors.red);
      }
    }catch(e){
      print(e.toString());
      setState(() {
        loading=false;
        showerror=true;
      });
      ToastShowClass.toastShow(context,e.toString(),Colors.red);
    }
  }
  @override
  void initState() {
    getCrypto();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Container(
              height: size.height*0.33,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/dashboard_headerImage.png'),
                  fit: BoxFit.fill,

                ),

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 40, left: 12.0, right: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap:(){
                            Navigator.pushNamed(context, SettingWidget.id);
                          },
                          child: Icon(Icons.manage_accounts_rounded, color: Theme
                              .of(context)
                              .textTheme
                              .headline1
                              ?.color, size: 25,),
                        ),
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/investinosName.png')
                              )
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            //Navigator.pushNamed(context, Currency_Perference.id);
                          },
                          child: Icon(FontAwesomeIcons.indianRupeeSign, color: Theme
                              .of(context)
                              .textTheme
                              .headline1
                              ?.color, size: 20,),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height*0.05,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Total",
                          style: TextStyle(color: Theme.of(context).textTheme.headline1?.color, fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.2)),
                      Text(" Portfolio Value",
                          style: TextStyle(color: Theme.of(context).textTheme.headline1?.color, fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 0.2)),
                    ],
                  ),
                  SizedBox(height: 4,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(FontAwesomeIcons.dollarSign,size: 12,color: Colors.white,),
                      Text(" "+Balance.toString(), style: TextStyle(color: Theme.of(context).textTheme.headline1?.color, fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.2)),
                    ],
                  ),
                ],
              ),
            ),
            Card(
                margin:EdgeInsets.only(top: size.height*0.29, left: 14.0, right: 14.0),
                elevation: 10,
                color: Theme.of(context).cardColor,
                shadowColor:Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                    height: size.height,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8)
                    ),
                    // /color: Colors.red,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height*0.045,),
                        Padding(
                          padding:  EdgeInsets.only(left: 10,right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("WALLETS-",style: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(1),fontSize: 11,fontWeight: FontWeight.w500,letterSpacing: 0.1),),
                          //    SizedBox(height: 10,),
                              Padding(
                                padding:  EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("Hide Low Balance Wallets",style: TextStyle(color:Theme.of(context).indicatorColor.withOpacity(0.8),fontWeight: FontWeight.w500,fontSize: 9),),
                                    SizedBox(width: 6,),
                                    FlutterSwitch(
                                      width: 35.0,
                                      height: 18.0,
                                      valueFontSize: 10.0,
                                      toggleSize: 15.0,
                                      padding: 1,
                                      value: status,
                                      onToggle: (val) {
                                        setState(() {
                                          status = val;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              // Row(
                              //   children: [
                              //     Text("CONVERT DUST TO WRX",style: TextStyle(color: ColorsCollectionsDark.lightblueColor.withOpacity(0.7),fontSize: 11,fontWeight: FontWeight.w600),),
                              //     SizedBox(width: 5,),
                              //     Icon(FontAwesomeIcons.circleChevronRight,size: 13,color:ColorsCollectionsDark.lightblueColor.withOpacity(0.7),)
                              //   ],
                              // )
                            ],
                          ),
                        ),
                        SizedBox(height: 18,),
                        Container(
                          height: size.height*0.5,
                          child:showerror?CustomError():loading?Center(child:CircularProgressIndicator(color:Colors.orangeAccent),):nodata?Nodata():status?ListView.builder(
                            // shrinkWrap: true,
                            //primary: false,
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.only(bottom: 6),
                              itemCount: BalanceList.length,
                              itemBuilder: (BuildContext context,int index){
                                return GestureDetector(
                                  onTap: (){
                                    showDialog(context: context, builder:(BuildContext context){
                                      return Dialog(
                                        backgroundColor: Theme.of(context).cardColor,
                                        elevation: 4,
                                        child: Container(
                                          height: size.height*0.3,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(6),),
                                              color: Theme.of(context).cardColor,
                                              // gradient: LinearGradient(
                                              //   colors: [Theme.of(context).hintColor.withOpacity(0.4),
                                              //     Theme.of(context).hintColor.withOpacity(0.4)
                                              //   ],
                                              // ),
                                              border: Border.all(color:Theme.of(context).indicatorColor.withOpacity(0.4))
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap:(){
                                                  Navigator.of(context).pop();
                                                  Navigator.pushNamed(context, "/Send_portfolio",arguments:BalanceList[index]["currency_networks"]);
                                               },
                                                child: Container(
                                                  margin: EdgeInsets.only(left: 30.0,right: 30.0),
                                                  height:35,
                                                //  width: size.width*0.2,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    gradient: LinearGradient(
                                                      colors: [ColorsCollectionsDark.blueDarkColor,
                                                        ColorsCollectionsDark.blueDarkColor],
                                                    ),
                                                  ),
                                                  child: Center(child:Text("Send",style: TextStyle(fontSize:11,color: Colors.white,fontWeight: FontWeight.w500),)),
                                                ),
                                              ),
                                              SizedBox(height: 25,),
                                              GestureDetector(
                                                onTap:(){
                                                  Navigator.of(context).pop();
                                                  Navigator.pushNamed(context, "/Receive_portfolio",arguments:BalanceList[index]["currency_networks"]);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(left: 30.0,right: 30.0),
                                                  height:35,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    gradient: LinearGradient(
                                                      colors: [Theme.of(context).buttonColor,
                                                        Theme.of(context).buttonColor],
                                                    ),
                                                  ),
                                                  child: Center(child:Text("Receive",style: TextStyle(fontSize:11,color: Colors.white,fontWeight: FontWeight.w500),)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                  child: Container(
                                    // /height: 60,
                                    width: size.width,
                                    margin: EdgeInsets.only(left: 10,right: 10,bottom: 6),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).hintColor.withOpacity(1),
                                      borderRadius: BorderRadius.circular(2),
                                      //  border: Border.all( color:ColorsCollectionsDark.portfolioBorderColor )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10,top:10,bottom: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 42,
                                                    height: 42,
                                                    decoration: BoxDecoration(
                                                      color: Color(0Xff44526a),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child:CircleAvatar(
                                                      maxRadius: 40,
                                                      backgroundColor: Colors.transparent,
                                                      backgroundImage:NetworkImage(BalanceList[index]["image"].toString()) ,
                                                      //  child: Image.network(userdata[index]["image"].toString()),
                                                    ),
                                                  ),
                                                  SizedBox(width:10,),
                                                  Row(
                                                    children: [
                                                      Text(BalanceList[index]["name"].toString(),style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600,fontSize: 11,letterSpacing: 0.2),),
                                                      SizedBox(width: 6,),
                                                      SizedBox(
                                                        height: 19,
                                                        child: VerticalDivider(color: Theme.of(context).indicatorColor.withOpacity(0.8),thickness: 0.3,width: 0,),
                                                      ),
                                                      SizedBox(width: 8,),
                                                      Text(BalanceList[index]["currency_type"].toString(),style: TextStyle(color:Theme.of(context).indicatorColor.withOpacity(0.8),fontWeight: FontWeight.w400,fontSize: 11,letterSpacing: 0.1),)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text((double.parse(BalanceList[index]["c_bal"].toString())*CommonClass.rate).toStringAsFixed(2),style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 12,fontWeight: FontWeight.w500),),
                                                  SizedBox(height: 4,),
                                                  // Container(
                                                  //   width: 70,
                                                  //   height: 20,
                                                  //   decoration: BoxDecoration(
                                                  //     color: Color(0Xff2dbf5e),
                                                  //     borderRadius: BorderRadius.circular(1),
                                                  //    // border: Border.all(color:Color(0Xff2dbf5e) ),
                                                  //   ),
                                                  //   child: Center(child: Text("+DEPOSIT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 10),)),
                                                  // )
                                                ],
                                              )
                                            ],
                                          ),
                                          // Visibility(
                                          //   visible: status,
                                          //     child:Container(
                                          //       margin: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 10),
                                          //       child: Row(
                                          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //         children: [
                                          //           Column(
                                          //             crossAxisAlignment: CrossAxisAlignment.start,
                                          //             mainAxisAlignment: MainAxisAlignment.center,
                                          //             children: [
                                          //               Text("Invested Value",style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 11,fontWeight: FontWeight.w400),),
                                          //               SizedBox(height: 3,),
                                          //               Text("RS."+userdata[index]["freezed_balance"].toString(),style: TextStyle(fontWeight: FontWeight.w700,color:Theme.of(context).textTheme.headline2?.color,fontSize: 10),)
                                          //             ],
                                          //           ),
                                          //           Column(
                                          //             crossAxisAlignment: CrossAxisAlignment.start,
                                          //             mainAxisAlignment: MainAxisAlignment.center,
                                          //             children: [
                                          //               Text("Current",style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 11,fontWeight: FontWeight.w400),),
                                          //               SizedBox(height: 3,),
                                          //               Text("RS."+userdata[index]["c_price"].toString(),style: TextStyle(fontWeight: FontWeight.w700,color:Theme.of(context).textTheme.headline2?.color,fontSize: 10),)
                                          //             ],
                                          //           ),
                                          //           Column(
                                          //             crossAxisAlignment: CrossAxisAlignment.start,
                                          //             mainAxisAlignment: MainAxisAlignment.center,
                                          //             children: [
                                          //               Text("Total Loss",style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 11,fontWeight: FontWeight.w400),),
                                          //               SizedBox(height: 3,),
                                          //               Text("RS."+userdata[index]["freezed_balance"].toString(),style: TextStyle(fontWeight: FontWeight.w700,color:Theme.of(context).textTheme.headline2?.color,fontSize: 10),)
                                          //             ],
                                          //           )
                                          //         ],
                                          //       ),
                                          //     )
                                          //
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }): ListView.builder(
                             // shrinkWrap: true,
                              //primary: false,
                            physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.only(bottom: 6),
                              itemCount: userdata.length,
                              itemBuilder: (BuildContext context,int index){
                                return GestureDetector(
                                  onTap: (){
                                    showDialog(context: context, builder:(BuildContext context){
                                      return Dialog(
                                        backgroundColor: Theme.of(context).cardColor,
                                        elevation: 4,
                                        child: Container(
                                          height: size.height*0.3,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(6),),
                                              color: Theme.of(context).cardColor,
                                              // gradient: LinearGradient(
                                              //   colors: [Theme.of(context).hintColor.withOpacity(0.4),
                                              //     Theme.of(context).hintColor.withOpacity(0.4)
                                              //   ],
                                              // ),
                                              border: Border.all(color:Theme.of(context).indicatorColor.withOpacity(0.4))
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap:(){
                                                  Navigator.of(context).pop();
                                                  Navigator.pushNamed(context, "/Send_portfolio",arguments:userdata[index]["currency_networks"]);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(left: 30.0,right: 30.0),
                                                  height:35,
                                                  //  width: size.width*0.2,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    gradient: LinearGradient(
                                                      colors: [ColorsCollectionsDark.blueDarkColor,
                                                        ColorsCollectionsDark.blueDarkColor],
                                                    ),
                                                  ),
                                                  child: Center(child:Text("Send",style: TextStyle(fontSize:11,color: Colors.white,fontWeight: FontWeight.w500),)),
                                                ),
                                              ),
                                              SizedBox(height: 25,),
                                              GestureDetector(
                                                onTap:(){
                                                  Navigator.of(context).pop();
                                                  Navigator.pushNamed(context, "/Receive_portfolio",arguments:userdata[index]["currency_networks"]);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(left: 30.0,right: 30.0),
                                                  height:35,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    gradient: LinearGradient(
                                                      colors: [Theme.of(context).buttonColor,
                                                        Theme.of(context).buttonColor],
                                                    ),
                                                  ),
                                                  child: Center(child:Text("Receive",style: TextStyle(fontSize:11,color: Colors.white,fontWeight: FontWeight.w500),)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                  child: Container(
                                    // /height: 60,
                                    width: size.width,
                                    margin: EdgeInsets.only(left: 10,right: 10,bottom: 6),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).hintColor.withOpacity(1),
                                        borderRadius: BorderRadius.circular(2),
                                      //  border: Border.all( color:ColorsCollectionsDark.portfolioBorderColor )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10,top:10,bottom: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 42,
                                                    height: 42,
                                                    decoration: BoxDecoration(
                                                      color: Color(0Xff44526a),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child:CircleAvatar(
                                                      maxRadius: 40,
                                                      backgroundColor: Colors.transparent,
                                                      backgroundImage:NetworkImage(userdata[index]["image"].toString()) ,
                                                    //  child: Image.network(userdata[index]["image"].toString()),
                                                    ),
                                                  ),
                                                  SizedBox(width:10,),
                                                  Row(
                                                    children: [
                                                      Text(userdata[index]["symbol"].toString(),style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600,fontSize: 11,letterSpacing: 0.2),),
                                                      SizedBox(width: 6,),
                                                      // SizedBox(
                                                      //   height: 19,
                                                      //   child: VerticalDivider(color: Theme.of(context).indicatorColor.withOpacity(0.8),thickness: 0.3,width: 0,),
                                                      // ),
                                                      // SizedBox(width: 8,),
                                                      // Text(userdata[index]["currency_type"].toString(),style: TextStyle(color:Theme.of(context).indicatorColor.withOpacity(0.8),fontWeight: FontWeight.w400,fontSize: 11,letterSpacing: 0.1),)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text((double.parse(userdata[index]["c_bal"].toString())*CommonClass.rate).toStringAsFixed(2),style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 12,fontWeight: FontWeight.w500),),
                                                  SizedBox(height: 4,),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    )
                )
            ),
            Container(
              height: 60,
              width: size.width,
              margin: EdgeInsets.only(top: size.height*0.23,left: 20,right: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withOpacity(1),
                borderRadius: BorderRadius.circular(2),
                // border: Border.all( color:ColorsCollectionsDark.portfolioBorderColor )
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     InkWell(
                       onTap: (){
                        Navigator.pushNamed(context, "/Withdraw_History");
                       },
                       child: Container(
                        height: 40,
                        width: size.width*0.35,
                         decoration: BoxDecoration(
                           color: Theme.of(context).dividerColor,
                           borderRadius: BorderRadius.circular(4),
                         ),
                         child: Center(child: Text("Withdraw History",style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.w500),)),
                       ),
                     ),
                     InkWell(
                       onTap: (){
                         Navigator.pushNamed(context, "/Deposit");
                       },
                       child: Container(
                         height: 40,
                         width: size.width*0.35,
                         decoration: BoxDecoration(
                           color: Theme.of(context).dividerColor,
                           borderRadius: BorderRadius.circular(4),
                         ),
                         child: Center(child: Text("Deposit History",style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.w500),)),
                       ),
                     ),
                   ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
