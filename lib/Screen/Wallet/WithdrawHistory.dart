import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:investions/Api/ApiCollections.dart';
import 'package:investions/Api/ApiMain.dart';

class Withdraw_History extends StatefulWidget {
  const Withdraw_History({Key? key}) : super(key: key);

  @override
  State<Withdraw_History> createState() => _Withdraw_HistoryState();
}

class _Withdraw_HistoryState extends State<Withdraw_History> {
  bool loding=true;
  List datalist=[];
  int pageNumber=1;
  int? totalpage;
  bool loadingpage=false;
  Future<void> getdata(int page)async{
    final param={
      "page":page.toString(),
    };
    var response=await LBMAPIMainClass(ApiCollections.WithdrawHistory, param, "Get");
    var data=jsonDecode(response.body);
    print(data.toString());
    if(data["status_code"]=="1"){
      if(pageNumber==1){
        datalist.clear();
      }
      datalist.addAll(data["data"]["data"]);
      print(datalist.toString());
      totalpage=int.parse(data["data"]["current_page"].toString());
      setState(() {
        loding=false;
      });
    }else{
      setState(() {
        loding=false;
      });
    }
  }
  @override
  void initState() {
    getdata(pageNumber);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          Container(
            height: size.height * 0.3,
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/dashboard_headerImage.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top:50.0,left: 20),
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
                    Text("Withdraw Transaction",style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin:EdgeInsets.only(top: size.height*0.16, left: 14.0, right: 14.0),
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8)
            ),
            child:loding==true?Center(child: CircularProgressIndicator()): NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scroll){
                if(loadingpage && scroll.metrics.pixels==scroll.metrics.maxScrollExtent&&scroll.metrics.axis==Axis.vertical){
                  if(totalpage!=pageNumber){
                    setState(() {
                      loadingpage=false;
                    });
                    pageNumber=pageNumber+1;
                    getdata(pageNumber);
                  }
                }
                return false;
              },
              child: ListView.builder(
                  itemCount: datalist.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context,int index){
                    return withdrawal(size,index);
                  }),
            ),
          ),
        ],
      ),
    );
  }
  Widget withdrawal(Size size,int ind){
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("Symbol : ",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                  Text(datalist[ind]["currency"].toString(),style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 9,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                ],
              ),
              // Row(
              //   children: [
              //     Text("Token Type : ",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
              //     Text("FNX",style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 9,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
              //   ],
              // ),
              Row(
                children: [
                  Text("Amount : ",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                  Text(datalist[ind]["amount"].toString(),style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 9,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                ],
              )
            ],
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("Status : ",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                  Text(datalist[ind]["status"].toString(),style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 9,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                ],
              ), Row(
                children: [
                  Text("Created At : ",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                  Text("FNX",style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 9,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                ],
              ),
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: [
              Text("Token Address : ",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
              Text(datalist[ind]["to_address"].toString(),style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 9,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
            ],
          ),
          Divider(color: Theme.of(context).indicatorColor.withOpacity(0.7),)
        ],
      ),
    );
  }
}
