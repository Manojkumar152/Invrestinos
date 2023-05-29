import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:investions/Constant/IntenetError.dart';
import 'package:investions/Constant/MarketDeath_Moadal.dart';
import 'package:investions/Constant/Nodata.dart';
import 'package:provider/provider.dart';

import '../../Api/Provideclass.dart';
import '../../Constant/ColorsCollection.dart';

class PeerToPeer_MatchHistory extends StatefulWidget {
  static const id = 'PeerToPeer_MatchHistory';

  @override
  State<PeerToPeer_MatchHistory> createState() => _PeerToPeer_MatchHistoryState();
}

class _PeerToPeer_MatchHistoryState extends State<PeerToPeer_MatchHistory> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
         physics: NeverScrollableScrollPhysics(),
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
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap: (){
                                Provider.of<providerdata>(context,listen: false).ScoketStop();
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back,color: Colors.white,)),
                          SizedBox(width: 10,),
                          Text("Peer to Peer (P2P)",style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
                margin:EdgeInsets.only(top: size.height*0.18, left: 16.0, right: 16.0),
                elevation: 10,
                color: Theme.of(context).cardColor,
                shadowColor:Theme.of(context).cardColor,
                //color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    )),
                child: Container(
                    height: size.height*0.821,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16)
                    ),
                    // /color: Colors.red,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:EdgeInsets.only(top:0,left: 10),
                          child: Text("Match History",style:TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 12,fontWeight: FontWeight.w500,letterSpacing: 0.2),),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: size.width,
                          height: 35,
                          color: Theme.of(context).hintColor.withOpacity(0.9),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              Container(
                                width: size.width*0.20,
                                child: Center(child: Text("Price",style: TextStyle(fontSize: 10,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),)),
                              ),
                              Container(
                                width: size.width*0.29,
                                child: Center(child: Text("Volume",style: TextStyle(fontSize: 10,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),)),
                              ),
                              Container(
                                width: size.width*0.27,
                                child: Center(child: Text("Time",style: TextStyle(fontSize: 10,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: size.height*0.68,
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(16)
                          ),
                          child:Consumer<providerdata>(
                            builder: (context, snapshot,child){
                              List<orderHistoryModel> listtrade=[];
                             // listtrade=snapshot.gettrade().reversed.toList();
                              listtrade=snapshot.gettrade();
                              return listtrade.length<=0?Center(child: Nodata(),): ListView.builder(
                                itemCount: listtrade.length,
                                  padding: EdgeInsets.only(bottom: 5),
                                  itemBuilder: (BuildContext context,int index){
                                   int ind=index%2;
                                return  Container(
                                  margin: EdgeInsets.only(bottom: 14),
                                  height: 30,
                                  //color:ind ==0?ColorsCollectionsDark.markitlistgreen:ColorsCollectionsDark.markitlist,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: size.width*0.23,
                                        child: Center(child:
                                        Text(listtrade[index].price.toString(),style: TextStyle(fontSize: 10,color:listtrade[index].type.toString() =="Buy"?ColorsCollectionsDark.greenlightColor:Colors.redAccent,fontWeight: FontWeight.w500),)),
                                      ),

                                      Container(
                                        width: size.width*0.24,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                          //  Icon(listtrade[index].type.toString() =="Buy"?Icons.arrow_upward:Icons.arrow_downward,size: 10,color:listtrade[index].type.toString() =="Buy"?ColorsCollectionsDark.greenlightColor:Colors.redAccent ,),
                                    Text(listtrade[index].amount.toString(),style: TextStyle(fontSize: 10,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 5),
                                        width: size.width*0.21,
                                        child: Center(child: Text(listtrade[index].date.toString(),style: TextStyle(fontSize: 10,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),)),
                                      ),
                                    ],
                                  ),
                                );
                              });
                            }
                          ),
                        )
                      ],
                    )
                )
            )
          ],
        ),
      ),
    );
  }
}
