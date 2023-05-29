import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:investions/Api/ApiCollections.dart';
import 'package:investions/Api/CommonTextField.dart';
import 'package:investions/Constant/AttachmentDialog.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:investions/Constant/SharedPreferenceClass.dart';

import '../../Constant/CommonClass.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as https;
import 'package:async/async.dart';

import '../../Constant/ToastClass.dart';

class VerifyAccountWidget2 extends StatefulWidget {
  static const id = 'VerifyAccountWidget2';

  @override
  State<VerifyAccountWidget2> createState() =>_VerifyAccountWidget2State();
}

class _VerifyAccountWidget2State extends State<VerifyAccountWidget2> {

TextEditingController name=TextEditingController();
TextEditingController middle=TextEditingController();
TextEditingController last=TextEditingController();
TextEditingController DOB=TextEditingController();
TextEditingController address=TextEditingController();
TextEditingController DocumnetNo=TextEditingController();
TextEditingController panNo=TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

File? front,back,panImage;
bool isUpdating=false;
  List<String> kycList=[
    "Aadhaar Card","Voter Card","Driving License"
  ];
  String? Documnet_Type,token,Date_send,identity_type,message;
  bool KYCpage=true;
  bool adhaarCardBackbool = false,adhaarCardfront=false;
bool validateStructure(String value){
  String  pattern = r'^[A-Z]{5}[0-9]{4}[A-Z]{1}';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata()async{
    var reponse=await getuser();
    var data=jsonDecode(reponse.body);
    print(data.toString());
    if(data["user_kyc_status"]=="new"){
      setState(() {
        KYCpage=true;
      });
    }else{
      setState(() {
        message=data["user_kyc_status"].toString()=="pending"?"You Kyc is pending for approve":"You Kyc is "+data["user_kyc_status"].toString();
        KYCpage=false;
      });
    }
    token=await SharedPreferenceClass.GetSharedData("token");
    setState(() {
      token=token;
    });
    print(token.toString());
  }


Future<void> updatekyc() async {
  final uri = new Uri.http(ApiCollections.LBM_BaseURL, ApiCollections.kycupdate);
  MultipartRequest request = new http.MultipartRequest('POST', uri);
  request.headers["Accept"]='application/json';
  request.headers['Authorization'] = 'Bearer '+token.toString();
  request.fields['first_name'] = name.text.toString();
  request.fields['middle_name'] = middle.text.toString();
  request.fields['last_name'] = last.text.toString();
  request.fields['date_birth'] = Date_send.toString();
  request.fields['address'] = address.text.toString();
  request.fields['identity_type'] =identity_type.toString();
  request.fields['identity_number'] = DocumnetNo.text.toString();
  request.fields['pan_card_number'] = panNo.text.toString();
  print(request.toString());
  var file1;
  var file2;
  var file3;
  print(request.fields);
  if (front != null) {
    var stream =
    new http.ByteStream(DelegatingStream.typed(front!.openRead()));
    var length = await front!.length();
    file1 = new http.MultipartFile('identity_front_path', stream, length,
        filename: "identity_front_path");
    request.files.add(file1);
    print("LENGTHTHTH " + length.toString());
  }
  if (back != null) {
    var stream =
    new http.ByteStream(DelegatingStream.typed(back!.openRead()));
    var length = await back!.length();
    file2 = new http.MultipartFile('identity_back_path', stream, length, filename: "identity_back_path");
    request.files.add(file2);
  }
  if (panImage != null) {
    var stream = new http.ByteStream(
        DelegatingStream.typed(panImage!.openRead()));
    var length = await panImage!.length();
    file3 = new http.MultipartFile(
        'pan_card_path', stream, length, filename: "pan_card_path");
    request.files.add(file3);
  }
  print("rew"+request.fields.toString()+"  File???"+ request.files.toString());
  // var response= await request.send();
  // print("req "+response.toString());
  // response.stream.transform(utf8.decoder).listen((value) {
  //   Map<String, dynamic> data = jsonDecode(value);
  //   print("Result: ${response.statusCode}");
  //   if (response.statusCode == 200) {
  //     print("done");
  //     ToastShowClass.toastShow(context, 'Success', Colors.blue);
  //     setState(() {
  //       isUpdating = false;
  //     });
  //     Navigator.of(context).pop();
  //   } else {
  //     setState(() {
  //       isUpdating = false;
  //     });
  //     ToastShowClass.toastShowerror(context, response.stream.toString(), Colors.blue);
  //   }
  // });
  var  response = await https.Response.fromStream(await request.send());
  print("Result: ${response.statusCode}");
  if (response.statusCode == 200) {
    print("done");
    var data=jsonDecode(response.body);
    print(data.toString());
    if(data["status_code"]=="1"){
      ToastShowClass.toastShow(context, 'Success', Colors.blue);
      setState(() {
        isUpdating = false;
      });
      Navigator.of(context).pop();
    }else{
      setState(() {
        isUpdating = false;
      });
     // print(data["message"].toString());
      ToastShowClass.toastShowerror(context,data["message"].toString(), Colors.blue);
    }
  } else {
    setState(() {
      isUpdating = false;
    });
    print(response.body.toString());
    ToastShowClass.toastShowerror(context, response.body.toString(), Colors.blue);
  }
}



  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          Container(
            height: size.height * 0.35,
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
          Container(
            height: size.height,
            width: size.width,
            margin: EdgeInsets.only(top:size.height*0.15,left: 20,right: 20),
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
            child:KYCpage==false?Center(child: Text("$message",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 14,fontWeight: FontWeight.w600),),)
             //child
                 :SingleChildScrollView(
             // physics: NeverScrollableScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   PersonalInfo(context,size),
                    DocumentType(context,size),
                    PanCard(context,size),
                    Container(
                      height: size.height*0.223,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      //  margin: EdgeInsets.only(top: 0,bottom: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2),),
                        gradient: LinearGradient(
                          colors: [Theme
                              .of(context)
                              .indicatorColor.withOpacity(0.4),
                            Theme
                                .of(context)
                                .indicatorColor.withOpacity(0.4)
                          ],
                        ),

                      ),
                      child:Padding(
                        padding:  EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text( "Ready to submit your applications? ",
                              style: TextStyle(color: Theme
                                  .of(context)
                                  .textTheme
                                  .headline2
                                  ?.color,
                                fontSize: 8,
                                fontWeight: FontWeight.w600,),),
                            SizedBox(height: 4,),
                            Text( "Please verify the details you're submitting. Once \n "
                                "submitted,you won't be able to change it unless you",
                              style: TextStyle(color: Theme
                                  .of(context)
                                  .indicatorColor,
                                fontSize: 8,
                                fontWeight: FontWeight.w600,),),
                            SizedBox(height: 15,),
                            // Text( "Contact Us ",
                            //   style: TextStyle(color: Theme
                            //       .of(context)
                            //       .shadowColor,
                            //     fontSize: 10,
                            //     fontWeight: FontWeight.w600,),),
                            Center(
                              child: GestureDetector(
                                  onTap: (){
                                    if(_formKey.currentState!.validate()){
                                      if(front ==null|| back==null||panImage==null) {
                                       ToastShowClass.toastShowerror(context,"please select all image",Colors.red);
                                      }else{
                                        setState(() {
                                          isUpdating = true;
                                        });
                                        updatekyc();
                                      }
                                    }
                                  },
                                child: Container(
                                  height: size.height*0.048,
                                  margin: EdgeInsets.only(top:10),
                                  //  margin: EdgeInsets.only(top: 0,bottom: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(3),),
                                    gradient: LinearGradient(
                                      colors: [Theme
                                          .of(context)
                                          .focusColor,
                                        Theme
                                            .of(context)
                                            .focusColor
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text( " ",),
                                        Center(
                                          child: isUpdating?SizedBox(height: 15,width: 15,child: CircularProgressIndicator(color: Colors.white),):Text( "Update",
                                            style: TextStyle(color: Theme
                                                .of(context)
                                                .textTheme
                                                .headline1
                                                ?.color,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,),),
                                        ),
                                        Container(
                                            height: 20,
                                            width: 20,
                                            margin: EdgeInsets.only(right: 5),
                                            child: Icon(Icons.arrow_back_ios_rounded,size: 18,))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),


          )
        ],
      ),
    );
  }

 Widget PersonalInfo(BuildContext context, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.only(left:6.0,right: 10.0,top: 8.0),
          child: Text( "Personal Info",
            style: TextStyle(color: Theme
                .of(context)
                .textTheme
                .headline2
                ?.color,
              fontSize: 12,
              fontWeight: FontWeight.w600,),),
        ),

        Padding(
          padding:  EdgeInsets.only(left:6.0,right: 10.0,top: 8.0),
          child: Text( "First Name",
            style: TextStyle(color: Theme
                .of(context)
                .indicatorColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,),),
        ),

       TextFieldCommon(textcotroller: name, hint: "enter name", validation:"name is required", hintColor:Theme.of(context).textTheme.headline2?.color,),

        Padding(
          padding:  EdgeInsets.only(left:6.0,right: 10.0,top: 8.0),
          child: Text( "Middle Name",
            style: TextStyle(color: Theme
                .of(context)
                .indicatorColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,),),
        ),
        TextFieldCommon(textcotroller: middle, hint: "enter name", validation:"name is required", hintColor:Theme.of(context).textTheme.headline2?.color,validations: false,),
        Padding(
          padding:  EdgeInsets.only(left:6.0,right: 10.0,top: 8.0),
          child: Text( "Last Name",
            style: TextStyle(color: Theme
                .of(context)
                .indicatorColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,),),
        ),
        TextFieldCommon(textcotroller: last, hint: "enter name", validation:"lastname is required", hintColor:Theme.of(context).textTheme.headline2?.color,),

        Padding(
          padding:  EdgeInsets.only(left:6.0,right: 10.0,top: 14.0),
          child: Text( "Date Of Birth(DD-MM_YYY)*",
            style: TextStyle(color: Theme
                .of(context)
                .indicatorColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,),),
        ),
        GestureDetector(
          onTap: () async {

          },
          child: Container(
            height:size.height*0.06,
            width: size.width,
            margin: EdgeInsets.only(left: 5,right: 10,top: 5),
            decoration: BoxDecoration(
                color: Theme.of(context)
                    .indicatorColor
                    .withOpacity(0.4),
                borderRadius: BorderRadius.circular(2)),
            child: Center(
              child: TextFormField(
                  onTap:() async {
                    final DateTime? date= await showDatePicker(context: context,initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2025),
                    );
                    print(date.toString());
                    if(date !=null){
                      setState(() {
                        DOB.text= (DateFormat('dd-MM-yyyy').format(date)).toString();
                        Date_send=date.toString().split(" ").first;
                      });
                      print(DOB.text.toString()+"   "+date.toString());
                    }
                  },
                  enabled: true,
                  readOnly: true,
                  textInputAction:TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (value){},
                  controller:DOB,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    errorBorder: InputBorder.none,
                    errorStyle: TextStyle(fontSize: 10,color: Colors.red,height: 0.6),
                    contentPadding:  EdgeInsets.only(left: 10),
                    hintText: "enter DOB",
                    hintStyle: TextStyle(
                      color: Theme.of(context).textTheme.headline3?.color,
                      fontSize: 10.0,
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline2?.color,
                      fontSize: 11.0,fontWeight: FontWeight.w600
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'DOB required';
                    } else {
                      return null;
                    }
                  }
              ),
            ),
          ),
        ),

        Padding(
          padding:  EdgeInsets.only(left:6.0,right: 10.0,top: 8.0),
          child: Text( "Address*",
            style: TextStyle(color: Theme
                .of(context)
                .indicatorColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,),),
        ),
        TextFieldCommon(textcotroller: address, hint: "enter address", validation:"address is required", hintColor:Theme.of(context).textTheme.headline2?.color,),

      ],
    );
  }
  Widget PanCard(BuildContext context, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.only(left:6.0,right: 10.0,top: 8.0),
          child: Text( "Pan Card",
            style: TextStyle(color: Theme
                .of(context)
                .textTheme
                .headline2
                ?.color,
              fontSize: 12,
              fontWeight: FontWeight.w600,),),
        ),

        Padding(
          padding:  EdgeInsets.only(left:6.0,right: 10.0,top: 8.0),
          child: Text( "Pan Number*",
            style: TextStyle(color: Theme
                .of(context)
                .indicatorColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,),),
        ),
        Container(
          height:size.height*0.06,
          width: size.width,
          margin:  EdgeInsets.only(left:6.0,right: 14.0,top: 8.0),
          decoration: BoxDecoration(
              color: Theme.of(context)
                  .indicatorColor
                  .withOpacity(0.4),
              borderRadius: BorderRadius.circular(2)),
          child: Center(
            child: TextFormField(
              controller: panNo,
              inputFormatters: [LengthLimitingTextInputFormatter(12),],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                isCollapsed: true,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                errorStyle: TextStyle(fontSize: 10,color: Colors.red,height: 0.6),
                contentPadding:  EdgeInsets.only(left: 10,),
                hintText: 'enter number',
                hintStyle: TextStyle(
                  color: Theme.of(context).textTheme.headline2?.color,
                  fontSize: 11.0,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: Theme.of(context).textTheme.headline3?.color,
                fontSize: 11.0,
              ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'document Number is required';
                  }if(!validateStructure(value.toString())){
                    return 'invalid pancard number';
                  }
                  else {
                    return null;
                  }
                }
            ),
          ),
        ),

        Padding(
          padding:  EdgeInsets.only(left:6.0,right: 10.0,top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/download_arrow.png",height: 20,width: 20,),
              SizedBox(width: 2,),
              Padding(
                padding:  EdgeInsets.only(top:8.0),
                child: Text( "Upload Pan Card Front",
                  style: TextStyle(color: Theme
                      .of(context)
                      .textTheme
                      .headline2
                      ?.color,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,),),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding:  EdgeInsets.only(top:8.0),
            child: Container(
              height:70 ,
              width: size.width*0.3679,
              decoration: BoxDecoration(
                  color: Theme.of(context)
                      .indicatorColor
                      .withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2)

              ),
              child: DottedBorder(
                color: Theme.of(context).shadowColor.withOpacity(0.6),
                strokeWidth: 1,
                strokeCap: StrokeCap.butt,
                radius: Radius.circular(2),
                borderType: BorderType.RRect,
                child: Center(
                  child: panImage==null?Container(
                    height:60 ,
                    width: size.width*0.21,
                    margin:  EdgeInsets.only(left:0.0,right: 0.0,top: 0.0,bottom: 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2)),

                    child: Center(
                      child: Icon(Icons.add,size: 60,color:Theme.of(context)
                          .indicatorColor
                          .withOpacity(1) ,),
                    ),
                  ):Container(
                    height:60 ,
                    width: size.width*0.21,
                    margin:  EdgeInsets.only(left:10.0,right: 10.0,top: 8.0,bottom: 8.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .textTheme.headline2?.color,
                        borderRadius: BorderRadius.circular(2)),

                    child: Center(child: Image.file(panImage!)),
                  ),
                ),
              )
            ),
          ),
        ),
        Center(
          child: GestureDetector(
            onTap: (){
              showDialog(context: context, builder:(BuildContext context){
                return Attachment();
              }).then((value){
                panImage=getImage();
                setState(() {
                  panImage=panImage;
                });
              });
            },
            child: Container(
              height: 20,
              width: size.width*0.238,
              margin: EdgeInsets.only(right:14.0,top: 20),
              //  margin: EdgeInsets.only(top: 0,bottom: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2),),
                gradient: LinearGradient(
                  colors: [Theme.of(context)
                      .shadowColor
                      .withOpacity(0.8),
                    Theme.of(context)
                        .shadowColor
                        .withOpacity(0.8)
                  ],
                ),
              ),
              child: Center(
                child: Text( "Capture ",
                  style: TextStyle(color: Theme
                      .of(context)
                      .textTheme.headline1?.color,
                    fontSize: 8,
                    fontWeight: FontWeight.w600,),),
              ),
            ),
          ),
        ),

      ],
    );

  }
  Widget DocumentType(BuildContext context, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.only(left:6.0,right: 10.0,top: 15.0),
          child: Text( "Identity Verifications",
            style: TextStyle(color: Theme
                .of(context)
                .textTheme
                .headline2
                ?.color,
              fontSize: 10,
              fontWeight: FontWeight.w600,),),
        ),

        Padding(
          padding:  EdgeInsets.only(left:6.0,right: 10.0,top: 8.0),
          child: Text( "Document Type",
            style: TextStyle(color: Theme
                .of(context)
                .indicatorColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,),),
        ),
        SizedBox(height: 5,),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
              color: Theme.of(context)
                  .indicatorColor
                  .withOpacity(0.4),
            ),
            height: MediaQuery.of(context).size.height*0.07,
            margin: EdgeInsets.only(left: 5,right: 10),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Center(
                child: DropdownButtonFormField<String>(
                  iconEnabledColor:Theme.of(context).textTheme.headline2?.color,
                  dropdownColor:Theme.of(context).backgroundColor,
                  value:Documnet_Type,
                  items: kycList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        child: Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text(value.toString(),style: TextStyle(fontSize: 12,
                              color:Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    Documnet_Type = newVal;
                    if(Documnet_Type.toString()=="Aadhaar Card"){
                     setState(() {
                       identity_type="aadhaar";
                     });
                    }else if(Documnet_Type.toString()=="Voter Card"){
                      setState(() {
                        identity_type="voter";
                      });
                    }else{
                      setState(() {
                        identity_type="driving";
                      });
                    }
                    setState(() {
                      DocumnetNo.clear();
                    });
                    print(identity_type.toString());
                  },
                  hint: Text('  select document', style:TextStyle(fontSize: 12, color: Theme.of(context).textTheme.headline2?.color)),
                  validator: (value) =>
                  value == null ? '  please select document' : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      //   isCollapsed: true,
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
              ),
            )
        ),

        Padding(
          padding:  EdgeInsets.only(left:6.0,right: 10.0,top: 10.0),
          child: Text( "Document Number* ",
            style: TextStyle(color: Theme
                .of(context)
                .indicatorColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,),),
        ),
        TextFieldCommon(textcotroller: DocumnetNo, hint: "enter number", validation:"document number is required", hintColor:Theme.of(context).textTheme.headline2?.color,inputType:TextInputType.text,numbercheck: true,minnumberlengtgh:12,numberlength: 12,numbermessage: "document number is invalid"),


        Padding(
          padding:  EdgeInsets.only(left:6.0,right: 10.0,top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/download_arrow.png",height: 20,width: 20,),
              SizedBox(width: 2,),
              Padding(
                padding:  EdgeInsets.only(top:8.0),
                child: Text( "Upload Front",
                  style: TextStyle(color: Theme
                      .of(context)
                      .textTheme
                      .headline2
                      ?.color,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,),),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding:  EdgeInsets.only(top:8.0),
            child: Container(
                height:70 ,
                width: size.width*0.3679,
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .indicatorColor
                        .withOpacity(0.4),
                    borderRadius: BorderRadius.circular(2)

                ),
                child: DottedBorder(
                  color: Theme.of(context).shadowColor.withOpacity(0.6),
                  strokeWidth: 1,
                  strokeCap: StrokeCap.butt,
                  radius: Radius.circular(2),
                  borderType: BorderType.RRect,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      front==null?Align(
                        alignment: Alignment.center,
                        child: Container(
                          height:60 ,
                          width: size.width*0.21,
                          margin:  EdgeInsets.only(left:0.0,right: 0.0,top: 0.0,bottom: 8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2)),

                          child: Icon(Icons.add,size: 60,color:Theme.of(context)
                              .indicatorColor
                              .withOpacity(1) ,),
                        ),
                      ): Align(
                        alignment: Alignment.center,
                        child: Container(
                          height:60 ,
                          width: size.width*0.21,
                            margin:  EdgeInsets.only(left:10.0,right: 10.0,top: 8.0,bottom: 8.0),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .textTheme.headline2?.color,
                              borderRadius: BorderRadius.circular(2)),

                          child:Image.file(front!)
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ),
        ),
        Center(
          child: GestureDetector(
            onTap: (){
              showDialog(context: context, builder:(BuildContext context){
                return Attachment();
              }).then((value){
                front=getImage();
                setState(() {
                  front=front;
                });
              });
            },
            child: Container(
              height: 20,
              width: size.width*0.238,
              margin: EdgeInsets.only(right:14.0,top: 20),
              //  margin: EdgeInsets.only(top: 0,bottom: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2),),
                gradient: LinearGradient(
                  colors: [Theme.of(context)
                      .shadowColor
                      .withOpacity(0.8),
                    Theme.of(context)
                        .shadowColor
                        .withOpacity(0.8)
                  ],
                ),
              ),
              child: Center(
                child: Text( "Capture ",
                  style: TextStyle(color: Theme
                      .of(context)
                      .textTheme.headline1?.color,
                    fontSize: 8,
                    fontWeight: FontWeight.w600,),),
              ),
            ),
          ),
        ),


        Padding(
          padding:  EdgeInsets.only(left:6.0,right: 10.0,top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/download_arrow.png",height: 20,width: 20,),
              SizedBox(width: 2,),
              Padding(
                padding:  EdgeInsets.only(top:8.0),
                child: Text( "Upload Back",
                  style: TextStyle(color: Theme
                      .of(context)
                      .textTheme
                      .headline2
                      ?.color,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,),),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding:  EdgeInsets.only(top:8.0),
            child: Container(
                height:70 ,
                width: size.width*0.3679,
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .indicatorColor
                        .withOpacity(0.4),
                    borderRadius: BorderRadius.circular(2)

                ),
                child: DottedBorder(
                  color: Theme.of(context).shadowColor.withOpacity(0.6),
                  strokeWidth: 1,
                  strokeCap: StrokeCap.butt,
                  radius: Radius.circular(2),
                  borderType: BorderType.RRect,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      back==null?Align(
                              alignment: Alignment.center,
                              child: Container(
                              height:60 ,
                              width: size.width*0.21,
                              margin:  EdgeInsets.only(left:0.0,right: 0.0,top: 0.0,bottom: 8.0),
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2)),

                              child: Icon(Icons.add,size: 60,color:Theme.of(context)
                                  .indicatorColor
                                  .withOpacity(1) ,),
                              ),
                              ): Align(
                        alignment: Alignment.center,
                        child: Container(
                          height:60 ,
                          width: size.width*0.21,
                          margin:  EdgeInsets.only(left:10.0,right: 10.0,top: 8.0,bottom: 8.0),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .textTheme.headline2?.color,
                              borderRadius: BorderRadius.circular(2)),

                          child: Image.file(back!),
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ),
        ),
        Center(
          child: GestureDetector(
            onTap: (){
              showDialog(context: context, builder:(BuildContext context){
                return Attachment();
              }).then((value){
                back=getImage();
                setState(() {
                  back=back;
                });
              });
            },
            child: Container(
              height: 20,
              width: size.width*0.238,
              margin: EdgeInsets.only(right:14.0,top: 20),
              //  margin: EdgeInsets.only(top: 0,bottom: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2),),
                gradient: LinearGradient(
                  colors: [Theme.of(context)
                      .shadowColor
                      .withOpacity(0.8),
                    Theme.of(context)
                        .shadowColor
                        .withOpacity(0.8)
                  ],
                ),
              ),
              child: Center(
                child: Text( "Capture ",
                  style: TextStyle(color: Theme
                      .of(context)
                      .textTheme.headline1?.color,
                    fontSize: 8,
                    fontWeight: FontWeight.w600,),),
              ),
            ),
          ),
        ),
      ],
    );
  }
  File getImage(){
    File? image;
    setState(() {
      image = UploadImage!;
        UploadImage=null;
      });
      return image!;
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