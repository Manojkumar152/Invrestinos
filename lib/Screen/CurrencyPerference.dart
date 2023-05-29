import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:investions/Screen/Account/VerifyAccountWidget.dart';

class Currency_Perference extends StatefulWidget {
  static const id = 'Currency_Perference';

  @override
  State<Currency_Perference> createState() => _Currency_PerferenceState();
}

class _Currency_PerferenceState extends State<Currency_Perference> {
  List<CurrencyModel> CurrencyModeList = [
    CurrencyModel("BTC"),
    CurrencyModel("INR"),
    CurrencyModel("IDR"),
    CurrencyModel("RUB"),
    CurrencyModel("UAH"),
    CurrencyModel("NGR"),
    CurrencyModel("SAR"),
    CurrencyModel("EUR"),
    CurrencyModel("TRY"),
    CurrencyModel("WRX"),
  ];
  bool status = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body:SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height * 0.34,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/dashboard_headerImage.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding:  EdgeInsets.only(top:50.0,left: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          Text("Currency Preference",style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                    SizedBox(height: size.height*0.03,),
                    Text("Select Your Preferred Display Currency For All Market",style:TextStyle(color: Colors.grey.shade400,fontSize: 10,fontWeight: FontWeight.w500,letterSpacing: 0.2),),
                  ],
                ),
              ),
            ),
            Card(
                margin:EdgeInsets.only(top: size.height*0.18, left: 16.0, right: 16.0),
                elevation: 0.5,
                color: Theme.of(context).cardColor,
                //shadowColor:Theme.of(context).cardColor,
                //color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    )),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                          padding: EdgeInsets.only(top: 8),
                          itemCount: CurrencyModeList.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (BuildContext context, int index) {
                            return CurrencyLst(context, index);
                          }),

                    Padding(
                      padding: const EdgeInsets.only(left:8.0,top: 60),
                      child: Text("Display Same currency when placing orders?",
                        style: TextStyle(color:Theme.of(context).indicatorColor.withOpacity(0.8),
                            fontWeight: FontWeight.w500,fontSize: 10),),
                    ),

                    Container(
                      height: 40,
                      width: size.width,
                      margin: EdgeInsets.only(top: 14,),
                      decoration: BoxDecoration(
                        color: Theme.of(context).hintColor.withOpacity(1),
                        borderRadius: BorderRadius.circular(2),
                        // border: Border.all( color:ColorsCollectionsDark.portfolioBorderColor )
                      ),
                      child: Padding(
                        padding:  EdgeInsets.only(left:8.0,right: 10,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Display for Orders",style: TextStyle(color:Theme.of(context).selectedRowColor.withOpacity(0.8),fontWeight: FontWeight.w500,fontSize: 12),),
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
                    ),

                    Center(
                      child: Container(
                        height: 36,
                        width: size.width*0.245,
                        margin: EdgeInsets.only(top: 26,),
                        decoration: BoxDecoration(
                          color: Theme.of(context).hintColor.withOpacity(1),
                          borderRadius: BorderRadius.circular(2),
                          // border: Border.all( color:ColorsCollectionsDark.portfolioBorderColor )
                        ),
                      child: Center(
                        child: Text("Reset Values",
                          style: TextStyle(color:Theme.of(context).indicatorColor.withOpacity(0.8),
                              fontWeight: FontWeight.w500,fontSize: 10),),
                      ),
                      ),
                    ),
                    SizedBox(height: 30,),
                  ],
                ) ,
            )
          ],
        ),
      ),
    );
  }

  Widget CurrencyLst(BuildContext context, int i) {
    return SizedBox(
      height: 40,
      child: Column(
        children: [
          Container(
            height: 35,
            width: MediaQuery
                .of(context)
                .size
                .width,
            //  margin: EdgeInsets.only(top: 0,bottom: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(0),),
              gradient: LinearGradient(
                colors: [Theme
                    .of(context)
                    .highlightColor, Theme
                    .of(context)
                    .highlightColor
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 10.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(CurrencyModeList[i].Name, style: TextStyle(color: Theme
                          .of(context)
                          .textTheme
                          .headline2
                          ?.color, fontWeight: FontWeight.w500, fontSize: 11),),

                    ],
                  ),

                ],
              ),
            ),
          ),
          Container(height: 1, color: Theme
              .of(context)
              .canvasColor.withOpacity(0.6),)
        ],
      ),
    );
  }

}
class CurrencyModel{
  String Name ;
  CurrencyModel(this.Name);
}
