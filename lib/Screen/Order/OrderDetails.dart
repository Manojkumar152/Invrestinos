import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
List passdata=[];


OrderDetails({required this.passdata});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(title: Text("Order Details"),backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500,fontSize: 15),
        iconTheme: IconThemeData(color: Theme.of(context).textTheme.headline2?.color),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 40,),
              Container(
                height: 40,
                width: size.width,
                margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                decoration: BoxDecoration(
                //  color:Theme.of(context).hintColor.withOpacity(1),
                  gradient: LinearGradient(
                    colors: [Theme.of(context).hintColor.withOpacity(1),Theme.of(context).hintColor]
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Coin",style: TextStyle(color: Theme.of(context).textTheme.headline3?.color,fontWeight: FontWeight.w500,fontSize: 12),),
                      Text(widget.passdata[0]["currency"].toString(),style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600,fontSize: 12),),
                    ],
                  ),
                ),
              ),
              Container(
                height: 40,
                width: size.width,
                margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                decoration: BoxDecoration(
                  //  color:Theme.of(context).hintColor.withOpacity(1),
                    gradient: LinearGradient(
                        colors: [Theme.of(context).hintColor.withOpacity(1),Theme.of(context).hintColor]
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Order",style: TextStyle(color: Theme.of(context).textTheme.headline3?.color,fontWeight: FontWeight.w500,fontSize: 12),),
                      Text(widget.passdata[0]["type"].toString(),style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600,fontSize: 12),),
                    ],
                  ),
                ),
              ),
              Container(
                height: 40,
                width: size.width,
                margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                decoration: BoxDecoration(
                  //  color:Theme.of(context).hintColor.withOpacity(1),
                    gradient: LinearGradient(
                        colors: [Theme.of(context).hintColor.withOpacity(1),Theme.of(context).hintColor]
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Status",style: TextStyle(color: Theme.of(context).textTheme.headline3?.color,fontWeight: FontWeight.w500,fontSize: 12),),
                      Text(widget.passdata[0]["current_status"].toString(),style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600,fontSize: 12),),
                    ],
                  ),
                ),
              ),
              Container(
                height: 40,
                width: size.width,
                margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                decoration: BoxDecoration(
                  //  color:Theme.of(context).hintColor.withOpacity(1),
                    gradient: LinearGradient(
                        colors: [Theme.of(context).hintColor.withOpacity(1),Theme.of(context).hintColor]
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Order Type",style: TextStyle(color: Theme.of(context).textTheme.headline3?.color,fontWeight: FontWeight.w500,fontSize: 12),),
                      Text(widget.passdata[0]["order_type"].toString(),style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600,fontSize: 12),),
                    ],
                  ),
                ),
              ),
              Container(
                height: 40,
                width: size.width,
                margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                decoration: BoxDecoration(
                  //  color:Theme.of(context).hintColor.withOpacity(1),
                    gradient: LinearGradient(
                        colors: [Theme.of(context).hintColor.withOpacity(1),Theme.of(context).hintColor]
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Price",style: TextStyle(color: Theme.of(context).textTheme.headline3?.color,fontWeight: FontWeight.w500,fontSize: 12),),
                      Text(widget.passdata[0]["at_price"].toString(),style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600,fontSize: 12),),
                    ],
                  ),
                ),
              ),
              Container(
                height: 40,
                width: size.width,
                margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                decoration: BoxDecoration(
                  //  color:Theme.of(context).hintColor.withOpacity(1),
                    gradient: LinearGradient(
                        colors: [Theme.of(context).hintColor.withOpacity(1),Theme.of(context).hintColor]
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Quantity",style: TextStyle(color: Theme.of(context).textTheme.headline3?.color,fontWeight: FontWeight.w500,fontSize: 12),),
                      Text(widget.passdata[0]["quantity"].toString(),style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600,fontSize: 12),),
                    ],
                  ),
                ),
              ),
              Container(
                height: 40,
                width: size.width,
                margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                decoration: BoxDecoration(
                  //  color:Theme.of(context).hintColor.withOpacity(1),
                    gradient: LinearGradient(
                        colors: [Theme.of(context).hintColor.withOpacity(1),Theme.of(context).hintColor]
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Created At",style: TextStyle(color: Theme.of(context).textTheme.headline3?.color,fontWeight: FontWeight.w500,fontSize: 12),),
                      Text(widget.passdata[0]["created_at"].toString().split("T").first,style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600,fontSize: 12),),
                    ],
                  ),
                ),
              ),
              Container(
                height: 40,
                width: size.width,
                margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                decoration: BoxDecoration(
                  //  color:Theme.of(context).hintColor.withOpacity(1),
                    gradient: LinearGradient(
                        colors: [Theme.of(context).hintColor.withOpacity(1),Theme.of(context).hintColor]
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Cost",style: TextStyle(color: Theme.of(context).textTheme.headline3?.color,fontWeight: FontWeight.w500,fontSize: 12),),
                      Text("RS. "+widget.passdata[0]["total"].toString(),style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w600,fontSize: 12),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
