import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:investions/Api/ApiCollections.dart';
import 'package:investions/Screen/Credential%20Screen/LoginWidget.dart';
import 'package:investions/Screen/Credential%20Screen/verifyEmail_token.dart';
import 'package:investions/Screen/P2P/P2Pbuy_sell.dart';
import 'package:investions/Screen/Quicky_buy.dart';

import '../../Api/ApiMain.dart';
import '../../Constant/SharedPreferenceClass.dart';
import '../../Constant/ToastClass.dart';

class SignupWidget extends StatefulWidget {
  static const id = "SignupWidget";

  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirm_passwordController = TextEditingController();
  final TextEditingController _refferalCodeController = TextEditingController();
  late bool _passwordVisible;
  late bool _confirmPasswordVisible;
  bool registeredbool  = false;
  late bool agree,agreebool;
  bool name=false,email=false,password= false;
  AnimationController? _controller;

  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }


  @override
  void initState() {
    _controller = AnimationController(
      duration:  Duration(milliseconds: 5000),
      vsync: this,
    );
    _passwordVisible = false;
    _confirmPasswordVisible = false;
    agree = false;
    agreebool = false;

    super.initState();
  }
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    final paramDic = {
      "name": _usernameController.text.toString(),
      "email": _emailController.text.toString(),
      "referral": _refferalCodeController.text.toString(),
      "password": _passwordController.text.toString(),
      "confirm_password": _passwordController.text.toString(),
    };
    print(paramDic);
    try{
      var response =
      await LBMAPIMainClass(ApiCollections.LBM_register, paramDic, "Post");
      var data = json.decode(response.body);
      print(response);
      if (data["status_code"] == '1') {
        setState(() {
          registeredbool = false;
        });
        ToastShowClass.toastShow(context, data["message"], Colors.blue);

        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Verify_tokenEmail(_emailController.text.toString())));
        // }
      } else {
        setState(() {
          registeredbool = false;
          // _controller!.reset();
        });
        ToastShowClass.toastShowerror(context, data["message"], Colors.red);
      }
    }catch(e){
      setState(() {
        registeredbool = false;
      });
      ToastShowClass.toastShowerror(context, e.toString(), Colors.red);
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
                'Sign Up',
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
                    padding:  EdgeInsets.only(left:16.0,right:16.0,top:10.0,bottom: 8.0),
                    child: TextFormField(
                      //autovalidateMode: AutovalidateMode.onUserInteraction,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _usernameController,
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'name is required';
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(fontSize: 12),
                      // onSaved: (input) => _email = input,
                      decoration: InputDecoration(
                        hintText: 'Name',
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
                        prefixIcon:ImageIcon(AssetImage("assets/images/user.png"),size: 18,color: Theme.of(context).indicatorColor,),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left:16.0,right:16.0,top:10.0,bottom: 8.0),
                    child: TextFormField(
                      controller: _emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'Email is required';
                        }else if(EmailValidator.validate(input)==false){
                          return 'Please provide valid Email Address';
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(fontSize: 12),
                      // onSaved: (input) => _email = input,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email id',
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
                        prefixIcon:ImageIcon(AssetImage("assets/images/email.png"),size: 18,color: Theme.of(context).indicatorColor,),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left:16.0,right:16.0,top:10.0,bottom: 8.0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _passwordController,
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'Password is required';
                        }else if(!validateStructure(_passwordController.text)){
                          return 'Enter One Upper case  and capital letter';
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(fontSize: 12),
                      obscureText: !_passwordVisible,
                      // onSaved: (input) => _email = input,
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
                        ),                   ),
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.only(left:16.0,right:16.0,top:10.0,bottom: 8.0),
                    child: TextFormField(
                      controller: _confirm_passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'Confirm Password is required';
                        } else if (_passwordController.text != _confirm_passwordController.text) {
                          return 'The Confirm Password is not match';
                        }else {
                          return null;
                        }
                      },
                      style: TextStyle(fontSize: 12),
                      obscureText: !_confirmPasswordVisible,
                      // onSaved: (input) => _email = input,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
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
                              _confirmPasswordVisible = !_confirmPasswordVisible;
                            });
                          },
                          child: Icon(
                            _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            size: 18,),
                        ),                   ),
                    ),
                  ),
                  SizedBox(height: 12,),
                  Container(
                    margin: EdgeInsets.only(left: 16.0,right: 16.0),
                    height: size.height * 0.07,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                          color:   Theme.of(context).indicatorColor.withOpacity(0.6),
                          width: 1,
                        ),
                        color: Theme
                            .of(context)
                            .cardColor),
                    child: Padding(
                      padding:  EdgeInsets.only(top:10.0,bottom: 8.0),
                      child: TextFormField(
                        controller: _refferalCodeController,
                        // validator: (input) {
                        //   if (input!.isEmpty) {
                        //     return 'Refferal code is required';
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        style: TextStyle(fontSize: 12),
                        // onSaved: (input) => _email = input,
                        decoration: InputDecoration(
                          hintText: 'Refferal code',
                          hintStyle:
                          TextStyle(color: Theme.of(context).indicatorColor, fontSize: 10,),
                          isDense: true,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(16, 4, 10, 8),// control your hints text size
                          errorStyle:TextStyle( height: 0.60,inherit:false,fontSize: 8,color: Colors.red, ),
                          //  prefixIcon:ImageIcon(AssetImage("assets/images/email.png"),size: 18,color: Theme.of(context).indicatorColor,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 0.7,
                        child:  Checkbox(
                          value: agree,
                          onChanged: (value) {
                            setState(() {
                              agree = value ?? false;
                              agreebool = false;
                            });
                          },
                        ),
                      ),

                      InkWell(onTap: (){
                        Navigator.pushNamed(context, "/TermsAndCondition");

                      },
                        child:  Text(
                          'I agree to terms & conditions.',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Theme.of(context).indicatorColor,fontSize: 12),),
                      )
                    ],
                  ),
                  agreebool==false? Container():Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left:24.0),
                        child: Text(
                          'Terms & conditions are required.',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.red,fontSize: 12),),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: size.height*0.08,),
              InkWell(
                onTap: (){
                  if(_formKey.currentState!.validate()){
                    if(agree==true){
                      setState(() {
                        registeredbool = true;
                        agreebool = false;
                        _controller!.forward();
                      });
                      _registerUser();
                    }else{
                      setState(() {
                        agree = false;
                        agreebool = true;
                        _controller!.reset();
                      });
                      ToastShowClass.toastShow(context, "Please check to terms and conditions. ", Colors.red);
                    }
                  }else{
                    setState(() {
                      registeredbool = false;
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
                  child: Center(child: registeredbool==true?SizedBox(height: 15,width: 15,child: CircularProgressIndicator(color: Colors.white),):Text("Sign Up",style: TextStyle(fontSize:12,color: Colors.white,fontWeight: FontWeight.w500),)),
                ),
              ),
              SizedBox(height: size.height*0.02,),

              SizedBox(height: size.height*0.02,),
              Padding(
                padding:  EdgeInsets.only(bottom: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",style: TextStyle(fontSize:12,color: Theme.of(context).selectedRowColor.withOpacity(0.7),fontWeight: FontWeight.w600)),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>LoginWidget()));
                      },
                      child: Text(" login",style: TextStyle(fontSize:11,color: Theme
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
