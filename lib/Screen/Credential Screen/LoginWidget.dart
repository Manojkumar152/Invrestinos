import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:investions/Api/ApiCollections.dart';
import 'package:investions/Screen/Setting/FAWidget.dart';
import 'package:investions/Screen/P2P/P2Pbuy_sell.dart';
import 'package:investions/Screen/Quicky_buy.dart';
import 'package:investions/Screen/Credential%20Screen/SignupWidget.dart';

import '../../Api/ApiMain.dart';
import '../../Constant/CommonClass.dart';
import '../../Constant/SharedPreferenceClass.dart';
import '../../Constant/ToastClass.dart';
import 'EmailVerfiy.dart';
import 'ForgotPassword.dart';

class LoginWidget extends StatefulWidget {
  static const id = "LoginWidget";

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loginbool  = false;
  String? _email, _pass;
  late bool _passwordVisible;
  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }
  Future<void> _login() async {
    final paramDic = {
      "email": _emailController.text.toString(),
      "password": _passwordController.text.toString(),
      // "captcha_response": captchaToken,
    };
    try{
      var response = await LBMAPIMainClass(ApiCollections.LBM_login, paramDic, "Post");
      var data = json.decode(response.body);
      if (data["status_code"] == '1') {
        if (data["data"].containsKey("token")) {
          print(data["data"]["token"].toString());
          SharedPreferenceClass.SetSharedData("token", data['data']['token']);
          SharedPreferenceClass.SetSharedData("name", data['data']['user']['name']);
          SharedPreferenceClass.SetSharedData(
              "email", data['data']['user']['email']);
          SharedPreferenceClass.SetSharedData(
              "profile_image", data['data']['user']['profile_image']);
          SharedPreferenceClass.SetSharedData("isLogin", "true");
          setState(() {
            loginbool = false;
            ToastShowClass.toastShow(context, 'Verified Sucessfully', Colors.blue);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Quick_buy(p2pdata(0,0))));
          });
        }else{
          loginbool = false;
          var logindata = data['data'];
          print(logindata.keys.toString());
          ToastShowClass.toastShow(context, data["message"], Colors.red);
          setState(() {
            loginbool = false;
          });
          Navigator.push(context, MaterialPageRoute(builder: (context) => EmailOTPScreen(fromlogin: true, emailid: _emailController.text.toString(),
          )));
        }
      }else{
        setState(() {
          loginbool = false;
        });
        ToastShowClass.toastShowerror(context, data["message"], Colors.red);
      }
    }
    catch(e){
      setState(() {
        loginbool = false;
      });
      ToastShowClass.toastShowerror(context, "Error", Colors.red);
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
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: size.height*.34,
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
                'Login',
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
                  Padding(
                    padding:  EdgeInsets.only(left: 16.0,right: 16.0,top:10.0,bottom: 8.0),
                    child: TextFormField(
                      controller: _emailController,
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'Email is Required';
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(fontSize: 12),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // onSaved: (input) => _email = input,
                      decoration: InputDecoration(
                        hintText: 'Email id',
                        hintStyle: TextStyle(height:0,color: Theme.of(context).indicatorColor, fontSize: 10,),
                        enabledBorder:OutlineInputBorder(
                          borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        focusedErrorBorder:OutlineInputBorder(
                          borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        border:OutlineInputBorder(
                          borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.5)),
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
                        contentPadding: EdgeInsets.only(top: 10),

                        errorStyle:TextStyle( height: 0.60,inherit:false,fontSize: 8,color: Colors.red, ),
                        prefixIcon:ImageIcon(AssetImage("assets/images/email.png"),size: 18,color: Theme.of(context).indicatorColor,),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding:  EdgeInsets.only(left:16.0,right:16.0,top:10.0,bottom: 8.0),
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'Password is Required';
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: TextStyle(fontSize: 12),
                      // onSaved: (input) => _email = input,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle:
                        TextStyle(color: Theme.of(context).indicatorColor, fontSize: 10,),
                        enabledBorder:OutlineInputBorder(
                          borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        focusedErrorBorder:OutlineInputBorder(
                          borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        border:OutlineInputBorder(
                          borderSide:BorderSide(color:Theme.of(context).indicatorColor.withOpacity(0.5)),
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
                        contentPadding: EdgeInsets.only(top: 10),
                        errorStyle:TextStyle( height: 0.60,inherit:false,fontSize: 8,color: Colors.red, ),
                        prefixIcon:ImageIcon(AssetImage("assets/images/lock.png"),size: 18,color: Theme.of(context).indicatorColor,),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          child: Icon(
                            _passwordVisible ? Icons.visibility : Icons.visibility_off,
                            size: 18,),
                        ),

                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>ForgotPassword()));
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme
                                  .of(context)
                                  .shadowColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height*0.08,),
              InkWell(
                onTap: (){
                  if(_formKey.currentState!.validate()) {
                    setState(() {
                      loginbool = true;
                    });
                    _login();
                  }else{
                    setState(() {
                      loginbool= false;
                    });
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
                        Theme.of(context).dialogBackgroundColor.withOpacity(1)],
                    ),
                  ),
                  child: Center(child: loginbool==true?SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(color: Colors.white),
                  ):Text("Sign In",
                    style: TextStyle(fontSize:12,color: Colors.white,fontWeight: FontWeight.w500),)),
                ),
              ),
              SizedBox(height: size.height*0.02,),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",style: TextStyle(fontSize:12,
                        color: Theme.of(context).selectedRowColor.withOpacity(0.7),fontWeight: FontWeight.w500)),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>SignupWidget()));
                      },
                      child: Text(" Sign up",style: TextStyle(fontSize:10,color: Theme
                          .of(context)
                          .shadowColor,fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
