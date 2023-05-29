import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'SendPortfolio.dart';

class Receive_portfolio extends StatefulWidget {
  List passdata=[];


  Receive_portfolio({required this.passdata});

  @override
  State<Receive_portfolio> createState() => _Receive_portfolioState();
}

class _Receive_portfolioState extends State<Receive_portfolio> {
  TextEditingController Address=TextEditingController();
  List<type2> datalist=[];
  type2? coinname;
  bool show=false;
  String depositlimit="",walletaddress='',walletname='';
  @override
  void initState() {
    print(widget.passdata[0].toString());
    datalist.clear();
    for(int i=0;i<widget.passdata[0].length;i++){
      setState(() {
        datalist.add(type2(widget.passdata[0][i]["address"].toString(), widget.passdata[0][i]["token_type"].toString(),widget.passdata[0][i]["deposit_min"].toString()));
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).cardColor,
    appBar: AppBar(title: Text("Receive"),backgroundColor: Colors.transparent,
    titleTextStyle: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500,fontSize: 15),
    iconTheme: IconThemeData(color: Theme.of(context).textTheme.headline2?.color),),
    body: Container(
                height:size.height*0.6,
                width: size.width,
                margin: EdgeInsets.only(left: 20,right: 20,top: size.height*0.1),
                //alignment: Alignment.center,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color:Theme.of(context).hintColor.withOpacity(1),
                ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    //border: Border.all(color:Theme.of(context).indicatorColor.withOpacity(0.5),width: 2),
                    image: DecorationImage(
                        image: AssetImage("assets/images/investinosName.png",),
                        alignment: Alignment.center
                      //  fit: BoxFit.fill
                    )
                ),
              ),
            ),
            SizedBox(height: 10,),
            Divider(
              color: Theme.of(context).textTheme.headline2?.color,
              thickness: 0.5,height: 0,
            ),
            SizedBox(height: 10,),
            Text("Token",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 13,fontWeight: FontWeight.w600),),
            SizedBox(height: 10,),
            Container(
              height:40,
              width: size.width,
              margin: EdgeInsets.only(),
              decoration: BoxDecoration(
                  border: Border.all(color:Theme.of(context).indicatorColor.withOpacity(0.1)),
                  color: Theme.of(context)
                      .indicatorColor
                      .withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2)
              ),
              child: DropdownButtonFormField<type2>(
                isExpanded: true,
                dropdownColor:Colors.black54,
                iconDisabledColor: Colors.grey,
                style: TextStyle(color:Colors.black87),
                iconEnabledColor:Theme.of(context).textTheme.headline2?.color,
                decoration:  InputDecoration(
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 7,bottom: 5),
                  errorStyle: TextStyle(fontSize: 10),
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                ),
                hint: Text("select wallet", style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 11,fontWeight: FontWeight.w500,letterSpacing: 0.2),),
                value: coinname,
                onChanged: (Value) {
                  setState(() {
                    coinname=Value;
                    Address.text=coinname!.id.toString();
                    depositlimit=coinname!.minideposit.toString();
                    walletname=coinname!.coinname.toString();
                    show=true;
                  });
                },
                validator: (value) => value==null?'select wallet':null,
                items: datalist.map((type2 user) {
                  return DropdownMenuItem<type2>(
                    value: user,
                    child: Row(
                      children: <Widget>[
                        Text("  "+user.coinname.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Theme.of(context).textTheme.headline1?.color),),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10,),
            Text("wallet Address",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 13,fontWeight: FontWeight.w600),),
            SizedBox(height: 10,),
            Container(
              height:40,
              width: size.width,
              margin: EdgeInsets.only(),
              decoration: BoxDecoration(
                  border: Border.all(color:Theme.of(context).indicatorColor.withOpacity(0.1)),
                  color: Theme.of(context)
                      .indicatorColor
                      .withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2)
              ),
              child: TextFormField(
                  controller: Address,
                  enabled: false,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headline3?.color,fontWeight: FontWeight.w600,
                    fontSize: 11.0,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorStyle: TextStyle(fontSize: 10),
                    hintText: "wallet Address",
                    hintStyle: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w500,letterSpacing: 0.2),
                    contentPadding: EdgeInsets.only(left: 8,bottom: 10),
                  ),
                  //  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Amount';
                    }
                    else {
                      return null;
                    }
                  }
              ),
            ),
            SizedBox(height: 30,),
            Divider(
              color: Theme.of(context).textTheme.headline2?.color,
              thickness: 0.5,height: 0,
            ),
            SizedBox(height: 20,),
            Visibility(
              visible: show,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("Min Deposit : ",style: TextStyle(fontSize: 10,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w700),),
                      Text(depositlimit+" "+walletname,style: TextStyle(fontSize: 11,color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600),),

                    ],
                  ),
                  QrImage(
                    data: Address.text.toString(),
                    version: QrVersions.auto,
                    size: size.height*0.13,
                    gapless: false,
                     backgroundColor: Colors.white,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    )
    );


  }
}
class type2{
  String id;
  String coinname;
  String minideposit;

  type2(this.id,this.coinname,this.minideposit);
}
