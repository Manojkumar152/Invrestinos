import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:investions/Api/ApiCollections.dart';
import '../../Api/ApiMain.dart';
import '../../Constant/ToastClass.dart';
import '../Dialog/ChangePassword.dart';
import 'ForgetPasswordDialog.dart';

class ForgotPassword extends StatefulWidget {
  static const id = "ForgotPassword";

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _otpController = new TextEditingController();
  late bool _passwordVisible;
  late bool _passwordConfirmVisible;
  late bool _visible_OTP;
  bool click=false;



  @override
  void initState() {
    setState(() {
      _passwordVisible = false;
      _passwordConfirmVisible = false;
      _visible_OTP = false;
    });
    super.initState();
  }



  Future<void> forgetpassord(String email) async {
    final paramDic = {
      "email": email.toString(),
    };
    print("email------------"+ paramDic.toString());
   try {
      var response = await LBMAPIMainClass(ApiCollections.LBM_forgetpassword, paramDic, "Post");
      var data = json.decode(response.body);
      print('Forgot Password Response' + data.toString());
      if (data["status_code"] == '1') {
        print("data--------------" + data.toString());
        setState(() {
          click=false;
          _visible_OTP = true;
        });
        ToastShowClass.toastShow(context, data['message'], Colors.black);
      } else {
        setState(() {
          click=false;
        });
        ToastShowClass.toastShowerror(context, data['message'], Colors.red);
      }
    }catch(e){
     setState(() {
       click=false;
     });
     ToastShowClass.toastShowerror(context, e.toString(), Colors.red);
   }
  }

  Future<void> verifyOtp()async{
    final paramDic={
      "token":_otpController.text,
    };
    var response=await LBMAPIMainClass(ApiCollections.validToken, paramDic, "Post");
    var data=jsonDecode(response.body);
    if(data["status_code"]=="1"){
      setState(() {
        click=false;
      });
      showDialog(context: context,
          //  barrierDismissible: true,
          builder: (BuildContext context)=>Forgot_PasswordDialog(_otpController.text.toString()));
      ToastShowClass.toastShow(context, data["message"].toString(),Colors.redAccent);
    }else{
      setState(() {
        click=false;
      });
      ToastShowClass.toastShow(context, data["message"].toString(),Colors.redAccent);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: size.height*.3,
                width: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/dashboard_headerImage.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 40),
                    height: 90.0,
                    width: 90.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/investinosName.png'),
                        fit: BoxFit.contain,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height*0.07,),
              Text(
                'Forgot Password',
                style: TextStyle(
                    fontSize: 18,
                    color: Theme
                        .of(context)
                        .textTheme
                        .headline2
                        ?.color,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: size.height*0.07,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _visible_OTP == false? Padding(
                    padding:  EdgeInsets.only(top:10.0,bottom: 8.0,left: 16.0,right: 16.0),
                    child: TextFormField(
                      controller: _emailController,
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'Email is required';
                        } else {
                          if(EmailValidator.validate(input)) {
                            return null;
                          }else{
                            if(input.contains("@")){
                              return 'Please enter part of following'  +" "+ input.toString()+ " "+'is incomplete.';
                            }else{
                              return 'Please include an @ in the email address.'+" "+ input.toString()+ " "+ " is missing an  @.";
                            }
                          }
                        }

                      },
                      style: TextStyle(fontSize: 12),
                      autocorrect: true,
                      // onSaved: (input) => _email = input,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Email id',
                        hintStyle: TextStyle(color: Theme.of(context).indicatorColor, fontSize: 10,),
                        enabledBorder:OutlineInputBorder(
                          borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        focusedErrorBorder:OutlineInputBorder(
                          borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        border:OutlineInputBorder(
                          borderSide:BorderSide(color: Theme.of(context).indicatorColor.withOpacity(0.6)),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        fillColor:Theme.of(context).cardColor,
                        filled: true,
                        focusedBorder:OutlineInputBorder(
                          borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        errorBorder:OutlineInputBorder(
                          borderSide:BorderSide(color:Colors.red.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(2),
                        ) ,
                        contentPadding: EdgeInsets.fromLTRB(16, 4, 10, 4),// control your hints text size
                        errorStyle:TextStyle(inherit:true,fontSize: 10,color: Colors.red, ),
                        prefixIcon:ImageIcon(AssetImage("assets/images/email.png"),size: 18,color: Theme.of(context).indicatorColor,),
                      ),
                    ),
                  ) :Padding(
                    padding:  EdgeInsets.only(top:10.0,bottom: 8.0,left: 16.0,right: 16.0),
                    child: TextFormField(
                      controller: _otpController,
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'token is required';
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(fontSize: 12),
                      autocorrect: true,
                      // onSaved: (input) => _email = input,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: 'enter token',
                        hintStyle: TextStyle(color: Theme.of(context).indicatorColor, fontSize: 10,),
                        enabledBorder:OutlineInputBorder(
                          borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        focusedErrorBorder:OutlineInputBorder(
                          borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        border:OutlineInputBorder(
                          borderSide:BorderSide(color: Theme.of(context).indicatorColor.withOpacity(0.6)),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        fillColor:Theme.of(context).cardColor,
                        filled: true,
                        focusedBorder:OutlineInputBorder(
                          borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        errorBorder:OutlineInputBorder(
                          borderSide:BorderSide(color:Colors.red.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(2),
                        ) ,
                        contentPadding: EdgeInsets.fromLTRB(16, 4, 10, 4),// control your hints text size
                        errorStyle:TextStyle( height: 0.10,inherit:true,fontSize: 8,color: Colors.red, ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height*0.2,),
              Column(
                children: [
                  _visible_OTP == false? InkWell(
                    onTap: (){
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          click=true;
                        });
                        forgetpassord(_emailController.text.toString());
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16.0,right: 16.0),
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        // border: Border.all(
                        //   color:  Colors.lightBlue,
                        //   width: 1,
                        // ),
                        gradient: LinearGradient(
                          colors: [Theme.of(context).dialogBackgroundColor.withOpacity(1),
                            Theme.of(context).dialogBackgroundColor.withOpacity(1),],
                        ),
                      ),
                      child: Center(child:click?SizedBox(height: 15,width: 15,child: CircularProgressIndicator(color: Colors.white),): Text("Get Token",style: TextStyle(fontSize:12,color: Colors.white,fontWeight: FontWeight.w500),)),
                    ),
                  ):
                  InkWell(
                    onTap: (){
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          click=true;
                        });
                        verifyOtp();
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16.0,right: 16.0),
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        // border: Border.all(
                        //   color:  Colors.lightBlue,
                        //   width: 1,
                        // ),
                        gradient: LinearGradient(
                          colors: [Theme.of(context).dialogBackgroundColor.withOpacity(1),
                            Theme.of(context).dialogBackgroundColor.withOpacity(1),],
                        ),
                      ),
                      child: Center(child:click?SizedBox(height: 15,width: 15,child: CircularProgressIndicator(color: Colors.white),):Text("Verify Token",style: TextStyle(fontSize:12,color: Colors.white,fontWeight: FontWeight.w500),)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height*0.02,),


            ],
          ),
        ),
      ),
    );
  }
}
