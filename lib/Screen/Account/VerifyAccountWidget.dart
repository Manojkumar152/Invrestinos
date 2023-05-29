import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:investions/Screen/P2P/P2Pbuy_sell.dart';

import '../Dialog/ConfirmDeleteWidget.dart';
import '../DownloadTradeReportWidget.dart';
import '../Setting/FAWidget.dart';
import 'VerifyAccountWidget2.dart';

class VerifyAccountWidget extends StatefulWidget {
  static const id = 'VerifyAccountWidget';

  @override
  State<VerifyAccountWidget> createState() =>_VerifyAccountWidgetState();
}

class _VerifyAccountWidgetState extends State<VerifyAccountWidget> {



  List<CountryModel> countryList=[
    CountryModel("1", "India"),
    CountryModel("2", "Delhi"),
    CountryModel("3", "Kangra"),
    CountryModel("4", "Chandigarh"),
    CountryModel("5", "Goa"),
  ];

   CountryModel? _countryModel;
  List<KycModel> kycList=[
    KycModel("1", ""),
  ];
  KycModel? _kycModel;
  @override
  void initState() {
    _countryModel = countryList[0];
    _kycModel = kycList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,

      body: SingleChildScrollView(
        primary:false,
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Container(
              height: size.height * 0.4,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/dashboard_headerImage.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top:40.0,left: 23),
                child: Align(
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
                      Text("Verify Account",style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height*0.145, left: 16.0, right: 16.0),
              child: Card(
                  elevation: 10,
                  // color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 9,),
                        Row(
                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height:size.height*0.10,
                              width: size.width*0.22,
                              margin: EdgeInsets.only(left: 6,right: 6,top: 4),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).hintColor,
                                  borderRadius: BorderRadius.circular(2),

                              ),
                              child: InkWell(
                                onTap: (){
                               //   Navigator.pushNamed(context, VerifyAccountWidget2.id);
                                 
                                },
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        height:size.height*0.06,
                                        width: size.width*0.18,
                                        //   color: Colors.red,
                                        child: Image.asset("assets/images/email_check.png",)
                                    ),
                                    Center(
                                      child: Text('Email',style: TextStyle(
                                        fontSize: 8,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600,letterSpacing: 0.1,),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                height:size.height*0.01,
                                width: size.width*0.06,
                                //   color: Colors.red,
                                child: Image.asset("assets/images/blueline.png",)
                            ),
                            Container(
                              height:size.height*0.10,
                              width: size.width*0.22,
                              margin: EdgeInsets.only(left: 6,right: 6,top: 4),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).hintColor,
                                  borderRadius: BorderRadius.circular(2),

                              ),
                              child: InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, FAWidget.id);
                                },
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        height:size.height*0.06,
                                        width: size.width*0.18,
                                        //   color: Colors.red,
                                        child: Image.asset("assets/images/email_check.png",)
                                    ),
                                    Center(
                                      child: Text('Security',style: TextStyle(
                                        fontSize: 8,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600,letterSpacing: 0.1,),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                height:size.height*0.01,
                                width: size.width*0.06,
                                //   color: Colors.red,
                                child: Image.asset("assets/images/blueline.png",)
                            ),
                            Container(
                              height:size.height*0.10,
                              width: size.width*0.22,
                              margin: EdgeInsets.only(left: 6,right: 6,top: 4),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).hintColor,
                                  borderRadius: BorderRadius.circular(2),
                                  border:Border.all(color: Theme.of(context).focusColor.withOpacity(0.2)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: ColorsCollectionsDark.lightblueColor.withOpacity(0.2)
                                    )
                                  ]
                              ),
                              child: InkWell(
                                onTap: (){
                                },
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        height:size.height*0.06,
                                        width: size.width*0.18,
                                        //   color: Colors.red,
                                        child: Image.asset("assets/images/welcome.png",)
                                    ),
                                    Center(
                                      child: Text('Welcome',style: TextStyle(
                                        fontSize: 8,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600,letterSpacing: 0.1,),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: size.height,
                          width: size.width,
                          padding: EdgeInsets.only(top:2,bottom:4,),
                          decoration: BoxDecoration(
                            //  color: Theme.of(context).buttonColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                            ),
                            gradient: LinearGradient(
                              colors: [Theme
                                  .of(context)
                                  .cardColor,
                                Theme
                                    .of(context)
                                    .cardColor
                              ],
                            ),

                          ),
                          child: Column(
                            children: [
                              InkWell(
                                onTap:(){

                                },
                                child: Padding(
                                  padding:  EdgeInsets.only(left:8.0,right:8.0,top:30,bottom: 2.0),
                                  child:
                                  Container(
                                    height: size.height*0.82,
                                    //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).hintColor,
                                      borderRadius: BorderRadius.all(Radius.circular(3),),
                                        border:Border.all(color: Theme.of(context).focusColor.withOpacity(0.2)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: ColorsCollectionsDark.lightblueColor.withOpacity(0.2)
                                          )
                                        ]
                                    ),
                                    child:  SingleChildScrollView(

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 10,),
                                          Padding(
                                            padding:  EdgeInsets.only(left: 4.0,right: 10.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text( "Select Your Country",
                                                  style: TextStyle(color: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .headline2
                                                      ?.color,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,),),
                                              ],
                                            ),
                                          ),
                                             SizedBox(height: 12,),
                                          Padding(
                                            padding:  EdgeInsets.only(left:4.0,right: 10.0),
                                            child: Text( "Country",
                                              style: TextStyle(color: Theme
                                                  .of(context)
                                                  .indicatorColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,),),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 6, top: 10, right: 15),
                                            child:
                                                 Container(
                                                  height: 26,
                                                  decoration: BoxDecoration(color:Theme
                                                    .of(context)
                                                    .indicatorColor.withOpacity(0.6),
                                                    borderRadius: BorderRadius.all(Radius.circular(3),),
                                                    gradient: LinearGradient(
                                                      colors: [Theme
                                                          .of(context)
                                                          .indicatorColor.withOpacity(0.6),
                                                        Theme
                                                            .of(context)
                                                            .indicatorColor.withOpacity(0.6)
                                                      ],
                                                    ),
                                                  ),
                                                  child: InputDecorator(
                                                    decoration: InputDecoration(
                                                        isDense: true,
                                                      contentPadding: EdgeInsets.fromLTRB(6, 0, 0, 2),
                                                      //   errorText: _errorBank,
                                                      errorStyle: TextStyle(
                                                          color: Colors.redAccent, fontSize: 10.0),
                                                      // border: OutlineInputBorder(
                                                      //   borderRadius:
                                                      //   BorderRadius.circular(3.0),
                                                      //     borderSide: BorderSide(color: Theme
                                                      //         .of(context)
                                                      //         .indicatorColor.withOpacity(0.1))
                                                      // ),
                                                        border: InputBorder.none
                                                    ),
                                                    child: DropdownButtonHideUnderline(
                                                      child: DropdownButton<CountryModel>(
                                                        style: TextStyle(
                                                          fontSize: 16,

                                                        ),
                                                        hint: Text(
                                                          "Select country",
                                                          style: TextStyle(
                                                            fontFamily: "verdana_regular",
                                                          ),
                                                        ),
                                                        value: _countryModel,
                                                        isExpanded: true,
                                                        isDense: true,
                                                        onChanged: (CountryModel? newValue) {
                                                          setState(() {
                                                            _countryModel = newValue ;
                                                          });
                                                        },
                                                        items: countryList
                                                            .map<DropdownMenuItem<CountryModel>>(
                                                                (CountryModel valueItem) {
                                                              return DropdownMenuItem(
                                                                value: valueItem,
                                                                child: Row(
                                                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(valueItem.countryName,style: TextStyle(color: Theme
                                                                        .of(context)
                                                                        .indicatorColor.withOpacity(1),
                                                                      fontSize: 12 ,),),
                                                                  ],
                                                                ),
                                                              );
                                                            }).toList(),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                          ),

                                          SizedBox(height: 14,),
                                          Padding(
                                            padding:  EdgeInsets.only(left:4.0,right: 10.0),
                                            child: Text( "Type of Kyc",
                                              style: TextStyle(color: Theme
                                                  .of(context)
                                                  .indicatorColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,),),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 6, top: 6, right: 15),
                                            child:
                                            Container(
                                                  height: 26,
                                                  decoration: BoxDecoration( color:Theme
                                                      .of(context)
                                                      .indicatorColor.withOpacity(0.6) ,
                                                    borderRadius: BorderRadius.all(Radius.circular(3),),
                                                    gradient: LinearGradient(
                                                      colors: [Theme
                                                          .of(context)
                                                          .indicatorColor.withOpacity(0.6),
                                                        Theme
                                                            .of(context)
                                                            .indicatorColor.withOpacity(0.6)
                                                      ],
                                                    ),
                                                  ),
                                                  child: InputDecorator(
                                                    decoration: InputDecoration(
                                                      isDense:true,
                                                      contentPadding: EdgeInsets.fromLTRB(6, 0, 0, 2),
                                                      //   errorText: _errorBank,
                                                      // errorStyle: TextStyle(
                                                      //     color: Colors.redAccent, fontSize: 10.0),
                                                      border: InputBorder.none,

                                                    ),
                                                    child: DropdownButtonHideUnderline(
                                                      child: DropdownButton<KycModel>(
                                                        style: TextStyle(
                                                          fontSize: 16,

                                                        ),
                                                        hint: Text(
                                                          "",
                                                          style: TextStyle(
                                                            fontFamily: "verdana_regular",
                                                          ),
                                                        ),
                                                        value: _kycModel,
                                                        isExpanded: true,
                                                        isDense: true,
                                                        onChanged: (KycModel? newValue) {
                                                          setState(() {
                                                            _kycModel = newValue ;
                                                          });
                                                        },
                                                        items: kycList
                                                            .map<DropdownMenuItem<KycModel>>(
                                                                (KycModel valueItem) {
                                                              return DropdownMenuItem(
                                                                value: valueItem,
                                                                child: Row(
                                                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(valueItem.KycModelName,style: TextStyle(color: Theme
                                                                        .of(context)
                                                                        .indicatorColor.withOpacity(1),
                                                                      fontSize: 12 ,),),
                                                                  ],
                                                                ),
                                                              );
                                                            }).toList(),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                          ),
                                          SizedBox(height: 20,),
                                          Row(
                                           // mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: size.height*0.298,
                                                width: size.width*0.379,
                                                margin: EdgeInsets.only(left: 6,right: 2),
                                                //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(3),),
                                                  gradient: LinearGradient(
                                                    colors: [Theme
                                                        .of(context)
                                                        .indicatorColor.withOpacity(0.6),
                                                      Theme
                                                          .of(context)
                                                          .indicatorColor.withOpacity(0.6)
                                                    ],
                                                  ),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text( "Without kyc ",
                                                      style: TextStyle(color: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .headline1
                                                          ?.color,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,),),
                                                    SizedBox(height: 8,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Icon(Icons.check_circle,size: 13,color: Theme.of(context).shadowColor,),
                                                            SizedBox(height: 6,),
                                                            Icon(Icons.check_circle,size: 13,color: Theme.of(context).shadowColor,),
                                                            SizedBox(height: 6,),
                                                            Icon(Icons.cancel,size: 13,color: Theme.of(context).indicatorColor,),
                                                            SizedBox(height: 6,),
                                                            Icon(Icons.cancel,size: 13,color: Theme.of(context).indicatorColor,),
                                                            SizedBox(height: 6,),
                                                            Icon(Icons.cancel,size: 13,color: Theme.of(context).indicatorColor,),
                                                          ],
                                                        ),
                                                        SizedBox(width: 6,),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text( "Deposite Crypto",
                                                              style: TextStyle(color: Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .headline2
                                                                  ?.color,
                                                                fontSize: 8,
                                                                fontWeight: FontWeight.w600,),),
                                                            SizedBox(height: 6,),
                                                            Text( "Trade",
                                                              style: TextStyle(color: Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .headline2
                                                                  ?.color,
                                                                fontSize: 8,
                                                                fontWeight: FontWeight.w600,),),
                                                            SizedBox(height: 6,),
                                                            Text( "Deposite INR",
                                                              style: TextStyle(color: Theme
                                                                  .of(context)
                                                                  .indicatorColor,
                                                                fontSize: 8,
                                                                fontWeight: FontWeight.w600,),),
                                                            SizedBox(height: 6,),
                                                            Text( "P2P",
                                                              style: TextStyle(color: Theme
                                                                  .of(context)
                                                                  .indicatorColor,
                                                                fontSize: 8,
                                                                fontWeight: FontWeight.w600,),),
                                                            SizedBox(height: 6,),
                                                            Text( "Withdraw",
                                                              style: TextStyle(color: Theme
                                                                  .of(context)
                                                                  .indicatorColor,
                                                                fontSize: 8,
                                                                fontWeight: FontWeight.w600,),),

                                                          ],
                                                        ),

                                                      ],
                                                    ),
                                                    SizedBox(height: 10,),

                                                    Container(
                                                      height: 18,
                                                      width: size.width*0.238,
                                                      margin: EdgeInsets.only(left: 4,right: 4,top: 6),
                                                      //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(2),),
                                                        border:Border.all(color: Theme.of(context).focusColor.withOpacity(0.8)),
                                                        // gradient: LinearGradient(
                                                        //   colors: [Theme
                                                        //       .of(context)
                                                        //       .focusColor.withOpacity(0.9),
                                                        //     Theme
                                                        //         .of(context)
                                                        //         .focusColor
                                                        //   ],
                                                        // ),
                                                      ),
                                                      child: Center(
                                                        child: Text( "Skip For Now ",
                                                          style: TextStyle(color: Theme
                                                              .of(context)
                                                              .textTheme.headline1?.color,
                                                            fontSize: 8,
                                                            fontWeight: FontWeight.w400,),),
                                                      ),
                                                    ),
                                                 
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: size.height*0.298,
                                                width: size.width*0.379,
                                                margin: EdgeInsets.only(left: 4,right: 4),
                                                //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(3),),
                                                  gradient: LinearGradient(
                                                    colors: [Theme
                                                        .of(context)
                                                        .indicatorColor.withOpacity(0.6),
                                                      Theme
                                                          .of(context)
                                                          .indicatorColor.withOpacity(0.6)
                                                    ],
                                                  ),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text( "Without kyc ",
                                                      style: TextStyle(color: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .headline1
                                                          ?.color,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,),),
                                                    SizedBox(height: 8,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Icon(Icons.check_circle,size: 13,color: Theme.of(context).shadowColor,),
                                                            SizedBox(height: 6,),
                                                            Icon(Icons.check_circle,size: 13,color: Theme.of(context).shadowColor,),
                                                            SizedBox(height: 6,),
                                                            Icon(Icons.check_circle,size: 13,color: Theme.of(context).shadowColor,),
                                                            SizedBox(height: 6,),
                                                            Icon(Icons.check_circle,size: 13,color: Theme.of(context).shadowColor,),
                                                            SizedBox(height: 6,),
                                                            Icon(Icons.check_circle,size: 13,color: Theme.of(context).shadowColor,),
                                                          ],
                                                        ),
                                                        SizedBox(width: 6,),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text( "Deposite Crypto",
                                                              style: TextStyle(color: Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .headline2
                                                                  ?.color,
                                                                fontSize: 8,
                                                                fontWeight: FontWeight.w600,),),
                                                            SizedBox(height: 6,),
                                                            Text( "Trade",
                                                              style: TextStyle(color: Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .headline2
                                                                  ?.color,
                                                                fontSize: 8,
                                                                fontWeight: FontWeight.w600,),),
                                                            SizedBox(height: 6,),
                                                            Text( "Deposite INR",
                                                              style: TextStyle(color: Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .headline2
                                                                  ?.color,
                                                                fontSize: 8,
                                                                fontWeight: FontWeight.w600,),),
                                                            SizedBox(height: 6,),
                                                            Text( "P2P",
                                                              style: TextStyle(color: Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .headline2
                                                                  ?.color,
                                                                fontSize: 8,
                                                                fontWeight: FontWeight.w600,),),
                                                            SizedBox(height: 6,),
                                                            Text( "Withdraw",
                                                              style: TextStyle(color: Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .headline2
                                                                  ?.color,
                                                                fontSize: 8,
                                                                fontWeight: FontWeight.w600,),),

                                                          ],
                                                        ),

                                                      ],
                                                    ),
                                                    SizedBox(height: 10,),

                                                    InkWell(
                                                      onTap:(){
                                                        Navigator.pushNamed(context, VerifyAccountWidget2.id);
                                                      },
                                                      child: Container(
                                                        height: 18,
                                                        width: size.width*0.238,
                                                        margin: EdgeInsets.only(left: 4,right: 4,top: 6),
                                                        //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.all(Radius.circular(2),),
                                                          gradient: LinearGradient(
                                                            colors: [Theme
                                                                .of(context)
                                                                .focusColor.withOpacity(0.9),
                                                              Theme
                                                                  .of(context)
                                                                  .focusColor
                                                            ],
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Text( "Complete Kyc ",
                                                            style: TextStyle(color: Theme
                                                                .of(context)
                                                                .textTheme.headline1?.color,
                                                              fontSize: 8,
                                                              fontWeight: FontWeight.w600,),),
                                                        ),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),


                            ],
                          ),
                        ),


                      ],
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
class CountryModel{
  String id;
  String countryName;
  CountryModel(this.id,this.countryName);
}
class KycModel{
  String id;
  String KycModelName;
  KycModel(this.id,this.KycModelName);
}