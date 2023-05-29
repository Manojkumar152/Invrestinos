import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:investions/Api/ApiMain.dart';

import '../../Api/ApiCollections.dart';
import '../../Api/CommonTextField.dart';
import '../../Constant/ColorsCollection.dart';
import '../../Constant/ToastClass.dart';

class Add_Ticket extends StatefulWidget {
  const Add_Ticket({Key? key}) : super(key: key);

  @override
  State<Add_Ticket> createState() => _Add_TicketState();
}

class _Add_TicketState extends State<Add_Ticket> {
  TextEditingController Title=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController emial=TextEditingController();
  TextEditingController query=TextEditingController();
  List<tickettype> category=[];
  tickettype? categoryvalue;
bool isClicked=false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> getCountry() async{
    final paramDic = {
      "": "",
    };
    print(paramDic);
    var response = await LBMAPIMainClass(ApiCollections.tickettype, paramDic, "Get");
    var data = json.decode(response.body);
    print("res"+response.body);
    if(data["status_code"]=='1'){
      category.clear();
      for(int i=0;i<data["data"].length;i++){
        setState(() {
          category.add(tickettype(data["data"][i]["id"].toString(),data["data"][i]["name"].toString()));
        });
      }
      print("Done");
    }
    else{
      ToastShowClass.toastShow(context,data["message"], Colors.red);
    }
  }

  Future<void> createTicket()async{
    final paramDic={
      "category_id":categoryvalue!.id.toString(),
      "author_email":emial.text.toString(),
      "author_name":name.text.toString(),
      "content":query.text.toString(),
      "title":Title.text.toString(),
    };
    print(paramDic.toString());
    var reeponse=await LBMAPIMainClass(ApiCollections.ticketcreate, paramDic,"Post");
    var data=jsonDecode(reeponse.body);
    if(data["status_code"]=="1"){
      setState(() {
        isClicked=false;
      });
      Navigator.of(context).pop();
      ToastShowClass.toastShow(context,data["message"].toString(),Colors.black87);
    }else{
      setState(() {
        isClicked=false;
      });
      ToastShowClass.toastShow(context,data["message"].toString(),Colors.black87);
    }
  }

  @override
  void initState() {
    getCountry();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
      body:Stack(
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
                        Text("Add Ticket", style: TextStyle(fontSize: 14.0,
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 5,right: 5,top: 20),
                child: Form(
                   key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left: 5),
                        child: Text("Title",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600,fontSize: 12,letterSpacing: 0.2),),
                      ),
                      SizedBox(height: 3,),
                      TextFieldCommon(textcotroller: Title, hint: "enter title", validation:"title required", hintColor: Theme.of(context).textTheme.headline2?.color),
                      SizedBox(height: 10,),
                      Padding(
                        padding:  EdgeInsets.only(left: 5),
                        child: Text("Choose Category",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600,fontSize: 12,letterSpacing: 0.2),),
                      ),
                      SizedBox(height: 8,),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(2.0)),
                            color: Theme.of(context)
                                .indicatorColor
                                .withOpacity(0.4),
                          ),
                          height: MediaQuery.of(context).size.height*0.07,
                          margin: EdgeInsets.only(left: 5,right: 7),
                          child: Center(
                            child: DropdownButtonFormField<tickettype>(
                              iconEnabledColor:Theme.of(context).textTheme.headline2?.color,
                              dropdownColor:Theme.of(context).backgroundColor,
                              value:categoryvalue,
                              items: category.map((tickettype value) {
                                return DropdownMenuItem<tickettype>(
                                  value: value,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width*0.7,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Text(value.name,style: TextStyle(fontSize: 12,
                                          color:Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                categoryvalue = newVal;
                              },
                              hint: Text('select category', style:TextStyle(fontSize: 12, color: Theme.of(context).textTheme.headline2?.color)),
                              validator: (value) =>
                              value == null ? ' Please select category' : null,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                isCollapsed: true,
                                contentPadding: EdgeInsets.only(left: 10),
                                isDense: true,
                                focusedBorder: InputBorder.none,
                                errorStyle: TextStyle(fontSize: 10,color: Colors.red,height: 0.8),
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none
                                //focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                              ),
                              style: TextStyle(color:Theme.of(context).textTheme.headline2?.color, fontSize: 12,fontWeight: FontWeight.w600),
                              isExpanded: true,
                            ),
                          )
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text("Name",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600,fontSize: 12,letterSpacing: 0.2),),
                      ),
                      TextFieldCommon(textcotroller: name, hint: "enter name", validation:"name required", hintColor: Theme.of(context).textTheme.headline2?.color),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text("Email",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600,fontSize: 12,letterSpacing: 0.2),),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        height:size.height*0.06,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .indicatorColor
                                .withOpacity(0.4),
                            borderRadius: BorderRadius.circular(2)),
                        margin: EdgeInsets.only(left: 5,right: 7),
                        child: Center(
                          child: TextFormField(
                              onChanged: (value){
                              },
                              controller: emial,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                isCollapsed: true,
                                errorBorder: InputBorder.none,
                                errorStyle: TextStyle(fontSize: 10,color: Colors.red,height: 0.6),
                                contentPadding:  EdgeInsets.only(left: 10),
                                hintText: "enter email",
                                hintStyle: TextStyle(
                                  color: Theme.of(context).textTheme.headline2?.color,
                                  fontSize: 10.0,
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                color: Theme.of(context).textTheme.headline3?.color,
                                fontSize: 11.0,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email is required';
                                } else if(EmailValidator.validate(emial.text)==false){
                                  return 'enter correct email';
                                }
                                else {
                                  return null;
                                }
                              }
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text("Query",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600,fontSize: 12,letterSpacing: 0.2),),
                      ),
                      TextFieldCommon(textcotroller: query, hint: "Leave a comment here", validation:"comment required", hintColor: Theme.of(context).textTheme.headline2?.color),
                      SizedBox(height: 50,),
                      GestureDetector(
                        onTap: (){
                          if(_formKey.currentState!.validate()){
                            setState(() {
                              isClicked=true;
                            });
                            createTicket();
                          }
                        },
                        child: Container(
                          height: 35,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 10,right: 10,bottom: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              color:Theme
                                  .of(context)
                                  .hoverColor.withOpacity(0.9)),
                          child: Center(
                              child:isClicked==false?Text('Submit',textAlign: TextAlign.center, style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color:Colors.white)):SizedBox(height:15,width:15,child: Center(child: CircularProgressIndicator(color: Colors.white)),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}
class tickettype{
  String id;
  String name;
  tickettype(this.id, this.name);

}
