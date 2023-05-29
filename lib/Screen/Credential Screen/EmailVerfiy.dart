// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, unnecessary_new, prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:investions/Screen/P2P/P2Pbuy_sell.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Api/ApiCollections.dart';
import '../../Api/ApiMain.dart';
import '../../Constant/CommonClass.dart';
import '../../Constant/SharedPreferenceClass.dart';
import '../../Constant/ToastClass.dart';
import '../Quicky_buy.dart';


class EmailOTPScreen extends StatefulWidget {
  static const id = 'EmailOTPScreen';
  String emailid;
  bool fromlogin;

  EmailOTPScreen({required this.emailid, required this.fromlogin});
  @override
  EmailOTPScreenState createState() => EmailOTPScreenState();
}

class EmailOTPScreenState extends State<EmailOTPScreen> {
  // getUserInfo() async {
  //   var currency = await SharedPreferenceClass.GetSharedData('Currency');
  //   var name = await SharedPreferenceClass.GetSharedData('name');
  //   var email = await SharedPreferenceClass.GetSharedData('email');
  //   var image = await SharedPreferenceClass.GetSharedData('profile_image');
  //   var status = await SharedPreferenceClass.GetSharedData("isLogin");
  //   var token = await SharedPreferenceClass.GetSharedData('token');
  //   print(token.toString());
  // }

  OtpFieldController otpController = OtpFieldController();
  bool loading = false;
  @override
  void initState() {
    loading = false;
    getApi();
    super.initState();
  }
  getApi() async {
    await getdata();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).hintColor,
      body: loading?Center(child: spinIndicator):SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
          ),
          child:Column(
            children: [
              SizedBox(
                height: height * 0.85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.07,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back)),
                    SizedBox(height: height * 0.1),
                    Text(
                      'Enter 6 Digit code sent to \n ${widget.emailid}',
                      style: TextStyle(
                          color:Theme.of(context).textTheme.headline2?.color,
                          fontSize: 17,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      width: width,
                      padding:
                      EdgeInsets.symmetric(horizontal: width * 0.04),
                      child: OTPTextField(
                          otpFieldStyle: OtpFieldStyle(
                            enabledBorderColor: Colors.grey,
                          ),
                          controller: otpController,
                          length: 6,
                          onChanged: (pin) {
                            print("Changed: " + pin);
                          },
                          onCompleted: (pin) {
                            setState(() {
                              loading = true;
                            });

                            _emailverify(pin);
                          }),
                    ),
                    SizedBox(height: height * 0.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            _resend(widget.emailid);
                          },
                          child: Text(
                            'Didn\'t Receive OTP?Wait 26s',
                            style: TextStyle(
                                color: Theme.of(context).textTheme.headline2?.color,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.21,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.03,
                          vertical: height * 0.02),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).secondaryHeaderColor),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning,
                            color: Colors.orange,
                          ),
                          SizedBox(
                            width: width * 0.06,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Never Share Your Code With Anyone',
                                style: TextStyle(
                                    color: Theme.of(context).textTheme.headline2?.color,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.07,
                width: width * 0.85,
                child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(
                                horizontal: width * 0.1,
                                vertical: height * 0.015)),
                        backgroundColor:
                        MaterialStateProperty.all(Theme.of(context).dialogBackgroundColor)),
                    onPressed: () {
                      if (Platform.isAndroid) {
                        AndroidIntent intent = AndroidIntent(flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
                          action: 'android.intent.action.MAIN', category: 'android.intent.category.APP_EMAIL',);
                        intent.launch().catchError((e) {
                          print('this is error if case ' + e.toString());
                        });
                      } else if (Platform.isIOS) {
                        launch("message://").catchError((e) {
                          print('this is error ' + e.toString());
                        });
                      }
                    },
                    child: Text(
                      'Verify OTP',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline1?.color,
                          fontWeight: FontWeight.w600),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _emailverify(String otp) async {
    final paramDic = {
      "email": widget.emailid.toString(),
      "otp": otp.toString(),
    };
    var response = await LBMAPIMainClass(ApiCollections.LBM_emailverify, paramDic, "Post");
    var data = json.decode(response.body);
    print("data"+data.toString());
    if (data["status_code"] == '1') {
      SharedPreferenceClass.SetSharedData("token", data['data']['token']);
      SharedPreferenceClass.SetSharedData("name", data['data']['user']['name']);
      SharedPreferenceClass.SetSharedData(
          "email", data['data']['user']['email']);
      SharedPreferenceClass.SetSharedData(
          "profile_image", data['data']['user']['profile_image']);
      SharedPreferenceClass.SetSharedData("isLogin", "true");

      setState(() {
        ToastShowClass.toastShow(context, 'Verified Sucessfully', Colors.blue);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Quick_buy(p2pdata(0,0))));
      });
    } else {
      setState(() {
        loading = false;
      });
      ToastShowClass.toastShow(context, 'Verification failed', Colors.red);
    }
  }

  // ignore: unused_element
  Future<void> _resend(id) async {
    final paramDic = {
      "": '',
    };
    var response = await LBMAPIMainClass(ApiCollections.LBM_resendotp + id.toString(), paramDic, "Post");
    var data = json.decode(response.body);
    log('resend otp data before if/else <---->' + data.toString());
    if (data["status_code"] == '1') {
      log('resend otp data  IF case <---->' + data.toString());
      // SharedPreferenceClass.SetSharedData("isLogin", "true");
      // print("second otp    ");
      ToastShowClass.toastShow(
          context, data["data"]['otp'].toString(), Colors.blue);
      // print("second otp    "+ data["data"]['otp'].toString());
      // setState(() {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) =>PhoneScreen() ),
      //   );
      // });
    } else {
      log('resend otp data  else case <---->' + data.toString());
      ToastShowClass.toastShow(context, data["message"], Colors.red);
    }
  }
}
