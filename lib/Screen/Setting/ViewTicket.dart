import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:investions/Api/ApiCollections.dart';
import 'package:investions/Api/ApiMain.dart';
import 'package:investions/Constant/ToastClass.dart';
import 'package:investions/Screen/Setting/TicketReply.dart';

import '../../Constant/CommonClass.dart';

class View_Ticket extends StatefulWidget {
  const View_Ticket({Key? key}) : super(key: key);

  @override
  State<View_Ticket> createState() => _View_TicketState();
}

class _View_TicketState extends State<View_Ticket> {
  List allTicket=[];
  bool loading=true;
  bool nodata=false;

   Future<void>getticket()async{
     final paramDic={
       "":""
     };
     try{
       var resposnse=await LBMAPIMainClass(ApiCollections.ticketget, paramDic,"Get");
       var data=jsonDecode(resposnse.body);
       if(data["status_code"]=="1"){
         setState(() {
           allTicket=data["data"];
           loading= false;
           nodata=false;
         });
         if(allTicket.isEmpty){
           nodata=true;
         }else{
           nodata=false;
         }
       }else{
         setState(() {
           nodata=false;
           loading=false;
         });
       }
     }catch(e){
       setState(() {
         nodata=true;
         loading=false;
       });
       ToastShowClass.toastShow(context,e.toString(),Colors.red);
     }
   }
   @override
  void initState() {
     getticket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body:loading?Center(child:spinIndicator) :Stack(
        children: [
          Container(
            height: size.height*0.3,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/dashboard_headerImage.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.1),
                  InkWell(
                    onTap:(){
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.arrow_back,color: Colors.white),
                        SizedBox(width: 8,),
                        Text("All Ticket", style: TextStyle(fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                      ],
                    ),
                  ),

                ]
            ),
          ),
          Container(
            height: size.height,
            margin: EdgeInsets.only(left: 10,right: 10,top:size.height * 0.20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: ListView.builder(
              itemCount: allTicket.length,
                itemBuilder: (BuildContext context,int index){
              return Container(
                width: size.width,
                margin: EdgeInsets.only(left: 10,right: 10,bottom: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).hintColor.withOpacity(1),
                  borderRadius: BorderRadius.circular(2),
                  //  border: Border.all( color:ColorsCollectionsDark.portfolioBorderColor )
                ),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context,"/TicketDetail",arguments:passdata(allTicket[index]["id"].toString(), allTicket[index]["title"].toString(), allTicket[index]["title"].toString()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(allTicket[index]["category_id"].toString()=="1"?"SAM":"other",style: TextStyle(fontSize: 12,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600),),
                            Text(allTicket[index]["title"].toString(),style: TextStyle(fontSize: 12,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600),),
                          ],
                        ),
                        SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Name:- ",style: TextStyle(fontSize: 11,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),),
                                Text(allTicket[index]["author_name"].toString(),style: TextStyle(fontSize: 11,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Email:- ",style: TextStyle(fontSize: 11,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),),
                                Text(allTicket[index]["author_email"].toString(),style: TextStyle(fontSize: 11,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Date:- ",style: TextStyle(fontSize: 11,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),),
                                Text(DateFormat("dd-MMM-yyyy hh:mm:ss").format(DateTime.parse(allTicket[index]["created_at"].toString())),style: TextStyle(fontSize: 11,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),),
                                //Text(allTicket[index]["created_at"].toString().split("T").first,style: TextStyle(fontSize: 11,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),),
                              ],
                            ),
                            Container(
                              height: 20,
                              width: 40,
                              decoration: BoxDecoration(
                                 color: Colors.green,
                                border: Border.all(color: Colors.green),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(child:Text(allTicket[index]["status"].toString(),style: TextStyle(fontSize: 10,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),),),
                            ),
                          ],
                        ),
                        SizedBox(height: 3,),
                      ],
                    ),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
