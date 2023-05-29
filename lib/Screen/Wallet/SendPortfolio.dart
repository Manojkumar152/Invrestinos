import 'package:flutter/material.dart';

class Send_portfolio extends StatefulWidget {
 List passdata=[];

 Send_portfolio({required this.passdata});

  @override
  State<Send_portfolio> createState() => _Send_portfolioState();
}

class _Send_portfolioState extends State<Send_portfolio> {
  TextEditingController Address=TextEditingController();
  TextEditingController Amount=TextEditingController();
  List<type> datalist=[];
  type? coinname;
  @override
  void initState() {
    print(widget.passdata[0].toString());
    datalist.clear();
    for(int i=0;i<widget.passdata[0].length;i++){
      setState(() {
        datalist.add(type(widget.passdata[0][i]["id"].toString(), widget.passdata[0][i]["token_type"].toString()));
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(title: Text("Send"),backgroundColor: Colors.transparent,
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                Text("Destination",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 13,fontWeight: FontWeight.w600),),
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
                SizedBox(height: 15,),
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
                  child: DropdownButtonFormField<type>(
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
                    hint: Text("select address", style: TextStyle(color:Theme.of(context).textTheme.headline2?.color,fontSize: 10,fontWeight: FontWeight.w500,letterSpacing: 0.2),),
                    value: coinname,
                    onChanged: (Value) {
                    },
                    validator: (value) => value==null?'select coin':null,
                    items: datalist.map((type user) {
                      return DropdownMenuItem<type>(
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
                Text("Amount",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontSize: 13,fontWeight: FontWeight.w600),),
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
                      controller: Amount,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline3?.color,fontWeight: FontWeight.w600,
                        fontSize: 11.0,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        errorStyle: TextStyle(fontSize: 10),
                        hintText: "Amount",
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
                SizedBox(height: 15,),
                Divider(
                  color: Theme.of(context).textTheme.headline2?.color,
                  thickness: 0.5,height: 0,
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("0 BNB",style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600,fontSize: 12),),
                    Text("Traansations Fees :- 0.0",style: TextStyle(color: Theme.of(context).buttonColor,fontSize: 10,fontWeight: FontWeight.w600),)
                  ],
                ),
                SizedBox(height: 15,),
                Container(
                  height:28 ,
                  width: size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Theme
                            .of(context)
                            .hoverColor.withOpacity(0.9),
                          Theme
                              .of(context)
                              .hoverColor.withOpacity(0.9)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Send",textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).textTheme.headline1?.color,
                            fontSize: 11.0,fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class type{
  String id;
  String coinname;

  type(this.id,this.coinname);
}
