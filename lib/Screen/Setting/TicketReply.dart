import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:investions/Api/ApiCollections.dart';

import '../../Api/ApiMain.dart';
import '../../Constant/ToastClass.dart';

class TicketDetail extends StatefulWidget{
  passdata? data;

  TicketDetail(this.data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TicketDetail();
  }
}

class _TicketDetail extends State<TicketDetail>{
  String isLoading="0";
  List<Chat>chatList=[];
  TextEditingController msgController= new TextEditingController();
  String isClicked="0";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChatHistory(widget.data!.id);
  }

  Future<void> getChatHistory(String id) async{
    final paramDic={
      "":""
    };
    print("param"+" "+paramDic.toString());
    var response= await LBMAPIMainClass(ApiCollections.ticketreply+"/"+id, paramDic, "Get");
    var data= json.decode(response.body);
    print("Data"+" "+data.toString());
    if(data["status_code"]=="1"){
      chatList.clear();
      for(int i=0;i<data["data"]["comments"].length;i++){
        chatList.add(Chat(name: data["data"]["comments"][i]["user"]["name"],date:data["data"]["comments"][i]["created_at"],msg: data["data"]["comments"][i]["comment"]));
      }
      print("chat"+' '+chatList.length.toString()+" "+chatList.toString());
      setState(() {
        isLoading="1";
      });
    }else{
      setState(() {
        isLoading="1";
      });
      ToastShowClass.toastShow(context, data["message"].toString(),Colors.orange);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    var width= MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width*0.7,
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .indicatorColor
                          .withOpacity(0.4),
                      borderRadius: BorderRadius.circular(4)),
                  padding: EdgeInsets.only(left:10, right:10),
                  child: TextFormField(
                    style: TextStyle(
                        fontSize: 12,
                        color:Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Comment Field is Empty';
                      }
                      return null;
                    },
                    controller: msgController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Leave Comment Here',
                      hintStyle: TextStyle(
                        color: Theme.of(context).textTheme.headline2?.color,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        isClicked="1";
                      });
                      addComment();
                    }
                  },
                  child: Container(width:80,height:40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color:Color(0xFFe57920)),
                      child:  Center(child: isClicked=="0"? Text('Send',style: TextStyle(color: Colors.white,fontSize: 12.0,fontWeight: FontWeight.bold)):Container(width:20,height:20,child: CircularProgressIndicator(color: Colors.white)))),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              Container(
                height: size.height*0.3,
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
                      SizedBox(height: height * 0.1),
                      InkWell(
                        onTap:(){
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                       //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.arrow_back,color: Colors.white,size: 25,),
                              SizedBox(width: 10),
                              Text(widget.data!.title==null?"":widget.data!.title, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: Colors.white)),
                              //SizedBox(height: 3),
                              // Text(widget.data!.status==null?"Status":"Status:  "+widget.data!.status, style: TextStyle(fontSize: 16.0,
                              //     fontWeight: FontWeight.w700,
                              //     color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                   //   SizedBox(height: height * 0.02),
                    ]
                ),
              ),
              Container(
                  height: size.height,
                  width: size.width,
                  margin: EdgeInsets.only(left: 10,right: 10,top:size.height * 0.20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isLoading=="0"?Center(
                        child: Container(
                            width:20,height:20,child: CircularProgressIndicator(color: Colors.orange)),
                      ):chatList.length.toString()=="0"?Text("No Comment available",style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 16.0,fontWeight: FontWeight.w700)):Container(
                        height: height*0.7,
                        child: ListView.builder(
                          itemCount: chatList.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return chatListItems(context,index);
                          },),
                      )
                  )
              ),
            ],
          )
      ),
    );
  }

  Widget chatListItems(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(chatList[index].name,style: TextStyle(fontSize:12,color:Theme.of(context).textTheme.headline2?.color,fontWeight:FontWeight.w600)),
          Text(chatList[index].msg,style: TextStyle(fontSize:12,color:Theme.of(context).textTheme.headline2?.color,fontWeight:FontWeight.w600)),
          Align(
              alignment: Alignment.centerRight,
              child: Text(DateFormat("dd-MMM-yyyy hh:mm:ss").format(DateTime.parse(chatList[index].date)),style: TextStyle(fontSize:10,color:Theme.of(context).textTheme.headline2?.color,fontWeight:FontWeight.w500))),
          Divider(thickness: 0.3,color: Theme.of(context).textTheme.headline2?.color,),

        ],
      ),
    );
  }

  Future<void> addComment() async{
    final paramDic={
      "ticket_id":widget.data!.id,
      "comment":msgController.text.toString()
    };
    print("param"+" "+paramDic.toString());
    var response= await LBMAPIMainClass(ApiCollections.ticketcomment, paramDic, "Post");
    var data= json.decode(response.body);
    print("Data"+" "+data.toString());
    if(data["status_code"]=="1"){
      setState(() {
        isClicked="0";
        msgController.clear();
      });
      getChatHistory(widget.data!.id);
    }else{
      setState(() {
        isClicked="0";
      });
      ToastShowClass.toastShow(context, data["message"].toString(),Colors.orange);
    }
  }
}

class Chat {
  String name;
  String msg;
  String date;
  Chat({required this.name,required this.msg,required this.date});
}
class passdata{
  String id;
  String title;
  String status;

  passdata(this.id, this.title, this.status);
}