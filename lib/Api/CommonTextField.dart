import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constant/ColorsCollection.dart';

class TextFieldCommon extends StatelessWidget {
   TextEditingController? textcotroller;
   String? hint;
   String? validation;
   Color? hintColor;
   TextInputType? inputType;
   TextInputAction? inputAction;
   ValueChanged? ontap;
   bool? enable;
   bool? validations;
   bool? numbercheck;
   int? numberlength;
   int? minnumberlengtgh;
   String? numbermessage;
   TextFieldCommon({required this.textcotroller, required this.hint, required this.validation, required this.hintColor,this.inputAction,this.inputType,this.ontap,this.enable,this.validations,this.numbercheck,
     this.numberlength,this.numbermessage,this.minnumberlengtgh});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Container(
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
          onTap:()=>ontap,
            enabled: enable,
            inputFormatters: [],
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value){},
            controller: textcotroller,
            keyboardType: inputType,
            decoration: InputDecoration(
              isCollapsed: true,
              errorBorder: InputBorder.none,
              errorStyle: TextStyle(fontSize: 10,color: Colors.red,height: 0.6),
              contentPadding:  EdgeInsets.only(left: 10),
              hintText: hint,
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
             if(validations==false){
               return null;
             }if (value!.isEmpty) {
               return '$validation';
             }if(numbercheck==true){
               if(value.length<minnumberlengtgh! ||value.length>numberlength!){
                 return "$numbermessage";
               }else{
                 return null;
               }
             }
              else {
                return null;
              }
            }
        ),
      ),
    );
  }
}
