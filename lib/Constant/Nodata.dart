import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:investions/Constant/ColorsCollection.dart';

class Nodata extends StatelessWidget {
  const Nodata({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Center(
      child:  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height:MediaQuery.of(context).size.height*0.2),
        Container(
          width: 80,height: 100,
          decoration: BoxDecoration(
            //  color: Colors.red,
              image: DecorationImage(
                image: AssetImage("assets/images/nodata2.png"),
              )
          ),
        ),
        Text("No Data",style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.w600),)
      ],
    ),
    );
  }
}
class Nodata2 extends StatelessWidget {
  String title;
  Nodata2(this.title);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height:MediaQuery.of(context).size.height*0.2),
          Container(
            width: 80,height: 100,
            decoration: BoxDecoration(
            //  color: Colors.red,
                image: DecorationImage(
                    image: AssetImage("assets/images/nodata2.png"),
                )
            ),
          ),
          Text("$title",style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.w600),)
        ],
      ),
    );
  }
}
