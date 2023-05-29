import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'P2P/P2PCancelWidget.dart';

class MarketWidget extends StatefulWidget {
 static const id ='USDTWidget';

  @override
  _MarketWidgetState createState() => _MarketWidgetState();
}

class _MarketWidgetState extends State<MarketWidget> {


  List<ExchnageCoinsList> ExchangesList = [
    ExchnageCoinsList(
        "assets/images/group3.png", "DOGE"," / INR", "Dogecoin", "48.89","",
        Icon(Icons.arrow_downward), "1.41%"),
    ExchnageCoinsList("assets/images/group4.png", "SOL"," / INR", "Solana", "31.81.853","''",
        Icon(Icons.arrow_upward), "1.06%"),

  ];

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                padding: EdgeInsets.only(top: 8),
                itemCount: ExchangesList.length,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (BuildContext context, int index) {
                  return MarketList(context, index,size);
                })
          ],
        ),
      ),
    );

  }
  Widget MarketList(BuildContext context, int i,Size size) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, P2PCancelWidget.id);
      },
      child: Container(
        height: 52,
        //color: Colors.red,
        width:size.width,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              //  margin: EdgeInsets.only(top: 0,bottom: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(0),),
                gradient: LinearGradient(
                  colors: [Theme
                      .of(context)
                      .highlightColor,
                    Theme
                      .of(context)
                      .highlightColor
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 2.0, right: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          child: Image.asset(ExchangesList[i].image),
                        ),
                        SizedBox(width: 2,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(ExchangesList[i].Name, style: TextStyle(color: Theme
                                    .of(context)
                                    .textTheme
                                    .headline2
                                    ?.color, fontWeight: FontWeight.w700, fontSize: 13),),
                                Text(ExchangesList[i].currency, style: TextStyle(color: Theme
                                    .of(context)
                                    .textTheme
                                    .headline3
                                    ?.color, fontWeight: FontWeight.w700, fontSize: 13),),
                              ],
                            ),
                            Text(
                              ExchangesList[i].smallName, style: TextStyle(color: Theme
                                .of(context)
                                .textTheme
                                .headline3
                                ?.color, fontWeight: FontWeight.w500, fontSize: 8),),
                          ],
                        ),

                        SizedBox(width: 2,),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("\u20B9 " + ExchangesList[i].number,
                              style: TextStyle(color: ExchangesList[i].icon.icon ==
                                  Icons.arrow_upward ?Colors.green:Colors.red,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10),),
                          ],
                        ),

                        SizedBox(width: 10,),
                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                            //  color: Theme.of(context).buttonColor,
                            borderRadius: BorderRadius.all(Radius.circular(2.0)),
                            gradient: LinearGradient(
                              colors: [ExchangesList[i].icon.icon ==
                                  Icons.arrow_upward ? Colors.green : Colors.red,
                                ExchangesList[i].icon.icon ==
                                    Icons.arrow_upward ? Colors.green : Colors.red,
                              ],
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 2,),
                              Icon(ExchangesList[i].icon.icon == Icons.arrow_upward ?
                              Icons.arrow_upward : Icons.arrow_downward, size: 12,
                                color:
                                Theme
                                    .of(context)
                                    .textTheme
                                    .headline1
                                    ?.color,),
                              SizedBox(width: 2,),
                              Text(ExchangesList[i].icon.icon == Icons.arrow_upward ?
                              ExchangesList[i].numberpercentage : ExchangesList[i]
                                  .numberpercentage,
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .textTheme
                                    .headline1
                                    ?.color,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),),
                              SizedBox(width: 2,),
                            ],

                          ),
                        ),

                        SizedBox(width: 2,),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            Container(height: 1, color: Theme
                .of(context)
                .canvasColor,)
          ],
        ),
      ),
    );
  }

}

class ExchnageCoinsList{
  String image ;
  String Name;
  String currency;
  String smallName;
  String number;
  String numberprice;
  Icon icon;
  String numberpercentage;


  ExchnageCoinsList(this.image, this.Name,this.currency, this.smallName, this.number,this.numberprice,
      this.icon, this.numberpercentage);
}