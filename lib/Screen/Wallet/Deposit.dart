import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Api/ApiCollections.dart';
import '../../Api/ApiMain.dart';

class Deposit extends StatefulWidget {
  const Deposit({Key? key}) : super(key: key);

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  bool loding=true;
  List datalist=[];
  int pageNumber=1;
  int? totalpage;

  bool loadingpage=false;
  Future<void> getdata(int page)async{
    final param={
      "page":page.toString(),
    };
    var response=await LBMAPIMainClass(ApiCollections.depositHistory, param, "Get");
    var data=jsonDecode(response.body);
    print(data.toString());
    if(data["status_code"]=="1"){
      setState(() {
        loding=false;
      });
      datalist=data["data"]["data"];
      totalpage=int.parse(data["data"]["current_page"].toString());

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
                    Text("Deposit Transaction",style: TextStyle(color: Colors.white),)
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
            child:loding==true?Center(child: CircularProgressIndicator()):  NotificationListener<ScrollNotification>(
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
  Widget withdrawal(Size size,int index){
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("Symbol : ",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 11,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                  Text(datalist[index]["symbol"].toString(),style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                ],
              ), Row(
                children: [
                  Text("Token Type : ",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 11,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                  Text(datalist[index]["chain_type"].toString(),style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                ],
              ),
              Row(
                children: [
                  Text("Amount : ",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 11,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                  Text(datalist[index]["symbol"].toString(),style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
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
                  Text("Status : ",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 11,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                  Text(datalist[index]["status"].toString(),style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                ],
              ), Row(
                children: [
                  Text("Created At : ",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 11,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                  Text(datalist[index]["created_at"].toString().split("T").first,style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                ],
              ),
            ],
          ),
          SizedBox(height: 5,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Token Address : ",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 11,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
              Container(
                  width: size.width*0.611,
                  child: Text(datalist[index]["user_wallet_address"].toString(),style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w600,letterSpacing: 0.2),)),
            ],
          ),
          Divider(color: Theme.of(context).indicatorColor.withOpacity(0.7),)
        ],
      ),
    );
  }
}
