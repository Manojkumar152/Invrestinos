import 'dart:convert';

import 'package:flutter/material.dart';

import '../../Api/ApiCollections.dart';
import '../../Api/ApiMain.dart';
import '../../Constant/ToastClass.dart';
import 'LoginWidget.dart';

class Forgot_PasswordDialog extends StatefulWidget {
String? Token;

Forgot_PasswordDialog(this.Token);

  @override
  State<Forgot_PasswordDialog> createState() => _Forgot_PasswordDialogState();
}

class _Forgot_PasswordDialogState extends State<Forgot_PasswordDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _newPasswordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();
   bool _passwordVisible=false;
  bool click=false;
   bool _confirmPasswordVisible=false;
  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
  Future<void> Changepassword()async{
    final paramDic={
      "password":_newPasswordController.text,
      "confirm_password":_confirmPasswordController.text,
      "token":widget.Token.toString(),
    };
    print(paramDic.toString());
    try{
      var  response=await LBMAPIMainClass(ApiCollections.reset, paramDic, "Post");
      var data=jsonDecode(response.body);
      if(data["status_code"]=="1"){
        setState(() {
          click=false;
        });
        Navigator.pushNamedAndRemoveUntil(context, LoginWidget.id, (Route dynamic) => false);
        ToastShowClass.toastShow(context, data["message"].toString(),Colors.red);

      }else{
        setState(() {
          click=false;
        });
        ToastShowClass.toastShowerror(context, data["message"].toString(),Colors.red);
      }
    }catch(e){
      setState(() {
        click=false;
      });
      ToastShowClass.toastShow(context, e.toString().toString(),Colors.red);
    }

  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Dialog(
      elevation: 1,
      backgroundColor: Theme
          .of(context)
          .cardColor.withOpacity(0.9),
      child: Container(
        height: size.height*0.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6),),
            gradient: LinearGradient(
              colors: [Theme
                  .of(context)
                  .hintColor.withOpacity(0.4),
                Theme
                    .of(context)
                    .hintColor.withOpacity(0.4)
              ],
            ),
            border: Border.all(color:Theme
                .of(context)
                .indicatorColor.withOpacity(0.4))
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Center(
                  child: Center(
                    child: Text( "Change Password ",
                      style: TextStyle(color: Theme
                          .of(context)
                          .textTheme
                          .headline2
                          ?.color,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,),),
                  ),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: TextFormField(
                    controller: _newPasswordController,
                    validator: (input) {
                      if (input!.isEmpty) {
                        return "New password is required";
                      }else if(!validateStructure(_newPasswordController.text)){
                        return"Enter one capital and one number digit";
                      } else {
                        return null;
                      }
                    },
                    style: TextStyle(fontSize: 12),
                    obscureText: !_passwordVisible,
                    // onSaved: (input) => _email = input,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: 'New Password',
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
                      contentPadding: EdgeInsets.only(top: 10),// control your hints text size
                      errorStyle:TextStyle(fontSize: 10,color: Colors.red, ),
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
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    validator: (input) {
                      if(input!.isEmpty){
                        return "Confirm password required";
                      } else if (_newPasswordController.text != _confirmPasswordController.text) {
                        return "Confirm password is not match";
                      }else {
                        return null;
                      }
                    },
                    style: TextStyle(fontSize: 12),
                    obscureText: !_confirmPasswordVisible,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    // onSaved: (input) => _email = input,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
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
                      contentPadding: EdgeInsets.only(top: 10),// control your hints text size
                      errorStyle:TextStyle(fontSize: 10,color: Colors.red),
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
                SizedBox(height: 20),
                InkWell(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        click=true;
                      });
                      Changepassword();
                    }
                  },
                  child: Center(
                    child: Container(
                      height: size.height*0.045,
                      width: size.width,
                      margin: EdgeInsets.only(left: 10,right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2),),
                        gradient: LinearGradient(
                          colors: [Theme
                              .of(context)
                              .buttonColor.withOpacity(0.9),
                            Theme.of(context).buttonColor.withOpacity(0.9)
                          ],
                        ),
                      ),
                      child: Center(
                        child:click?SizedBox(height: 15,width: 15,child: CircularProgressIndicator(color: Colors.white),):Text( "Submit",
                          style: TextStyle(color: Theme
                              .of(context)
                              .textTheme
                              .headline1
                              ?.color,
                            fontSize: 8,
                            fontWeight: FontWeight.w600,),),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  setbool(bool name,String message,String mssg){
    if(mssg.toString()==''){
      setState(() {
        name=false;
      });
    }else{
      setState(() {
        name=true;
        message=mssg.toString();
      });
    }
  }
}
