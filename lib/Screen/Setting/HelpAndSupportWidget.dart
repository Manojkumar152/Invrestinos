import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpAndSupportWidget extends StatefulWidget {
   static const id = 'HelpAndSupportWidget';
  @override
  _HelpAndSupportWidgetState createState() => _HelpAndSupportWidgetState();
}

class _HelpAndSupportWidgetState extends State<HelpAndSupportWidget> {


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,

      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Container(
              height: size.height * 0.367,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/dashboard_headerImage.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding:  EdgeInsets.only(top:40.0,left: 23),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                              child: Icon(Icons.arrow_back,color: Colors.white,)),
                          SizedBox(width: 10,),
                          Text("Help & Support",style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height*0.145, left: 16.0, right: 16.0),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left:8.0,right: 8.0,top: 10),
                          child: Container(
                            height: size.height*0.24,
                            width:size.width*0.9,
                            //  margin: EdgeInsets.only(top: 0,bottom: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(2),),
                              gradient: LinearGradient(
                                colors: [Theme
                                    .of(context)
                                    .hintColor,
                                  Theme
                                      .of(context)
                                      .hintColor
                                ],
                              ),
                            ),
                            child:  Padding(
                              padding:  EdgeInsets.only(left:10.0,right: 6.0,top:4.0,bottom: 2.0),
                              child: Padding(
                                padding:  EdgeInsets.only(left:14.0,right: 14.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 6,),
                                    Text( "You control your data and we respect that.",
                                      style: TextStyle(color: Theme
                                          .of(context)
                                          .textTheme
                                          .headline2
                                          ?.color,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,),),
                                    SizedBox(height: 6,),
                                    Text( "For requests regrading",
                                      style: TextStyle(color: Theme
                                          .of(context)
                                          .indicatorColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,),),
                                    SizedBox(height: 6,),
                                    Text( "- Copy of your data",
                                      style: TextStyle(color: Theme
                                          .of(context)
                                          .indicatorColor,
                                        fontSize: 8,
                                        fontWeight: FontWeight.w600,),),
                                    SizedBox(height: 6,),
                                    Text( "- Data export",
                                      style: TextStyle(color: Theme
                                          .of(context)
                                          .indicatorColor,
                                        fontSize: 8,
                                        fontWeight: FontWeight.w600,),),
                                    SizedBox(height: 6,),
                                    Text( "- Data correction",
                                      style: TextStyle(color: Theme
                                          .of(context)
                                          .indicatorColor,
                                        fontSize: 8,
                                        fontWeight: FontWeight.w600,),),
                                    SizedBox(height: 8,),
                                    Text( "Please reach out to us.Out team be happy to help",
                                      style: TextStyle(color: Theme
                                          .of(context)
                                          .indicatorColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, "/Add_Ticket");
                        },
                        child: Padding(
                          padding:  EdgeInsets.only(left:8.0,),
                          child: Container(
                            height: size.height*0.055,
                              width:size.width*0.4,
                            //  margin: EdgeInsets.only(top: 0,bottom: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(2),),
                              gradient: LinearGradient(
                                colors: [Theme
                                    .of(context)
                                    .cardColor,
                                  Theme
                                      .of(context)
                                      .cardColor
                                ],
                              ),
                              border: Border.all(color: Theme.of(context).focusColor.withOpacity(0.4),width: 1.2)
                            ),
                            child:   Center(
                              child: Text( "Contact US",
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .textTheme
                                    .headline2
                                    ?.color,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,),),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context,"/View_Ticket");
                        },
                        child: Padding(
                          padding:  EdgeInsets.only(right: 8.0,),
                          child: Container(
                            height: size.height*0.055,
                            width:size.width*0.4,
                            //  margin: EdgeInsets.only(top: 0,bottom: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(2),),
                                gradient: LinearGradient(
                                  colors: [Theme
                                      .of(context)
                                      .cardColor,
                                    Theme
                                        .of(context)
                                        .cardColor
                                  ],
                                ),
                                border: Border.all(color: Theme.of(context).focusColor.withOpacity(0.4),width: 1.2)
                            ),
                            child:   Center(
                              child: Text("View Tickets",
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .textTheme
                                    .headline2
                                    ?.color,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,),),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                      ],
                    ),
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );

  }


}





