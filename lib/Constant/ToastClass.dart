import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ToastShowClass {
  //Display the Toast
  // static void toastShow(
  //     BuildContext context, String ToastValue, Color? _color) {
  //   Fluttertoast.cancel();
  //   Fluttertoast.showToast(
  //       msg: ToastValue,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: _color,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }
  static void toastShow(
      BuildContext context, String ToastValue, Color? _color) {
    showTopSnackBar(context,CustomSnackBar.info(
        message: ToastValue.toString(),
      backgroundColor: ColorsCollectionsDark.cardcolors,
      textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 13,),
    ));
  }
  static void toastShowerror(BuildContext context, String ToastValue, Color? _color) {
    showTopSnackBar(context,CustomSnackBar.error(
      message: ToastValue.toString(),
      backgroundColor: Colors.red,
      textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 13,),
    ));
  }
}