import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:provider/provider.dart';

import '../../Constant/SharedPreferenceClass.dart';
import '../../Constant/Themedata.dart';
import '../../Constant/Themedata.dart';

class AppearanceWidget extends StatefulWidget {
   static const id = 'AppearanceWidget';
  @override
  _AppearanceWidgetState createState() => _AppearanceWidgetState();
}

class _AppearanceWidgetState extends State<AppearanceWidget> {

bool isCheckedwhite = false,isCheckDark = false;
ThemeNotifier theme=ThemeNotifier();
  @override
  void initState() {
    getData();
    super.initState();
  }
  Future<void> getData() async {
    String ThemeMode = await SharedPreferenceClass.GetSharedData("themeMode");
    if (ThemeMode == 'light') {
     setState(() {
       isCheckedwhite = true;
       isCheckDark = false;
     });
      print("Theme-----"+ThemeMode.toString());
    } else {
      setState(() {
        isCheckedwhite = false;
        isCheckDark = true;
      });
      print("Theme-----"+ThemeMode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,

      body: SingleChildScrollView(
        primary:false,
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Container(
              height: size.height * 0.4,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/dashboard_headerImage.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top:40.0,left: 23),
                child: Align(
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
                      Text("Appearance",style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height*0.145, left: 16.0, right: 16.0),
              child: Card(
                elevation: 2,
                // color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: size.height,
                        width: size.width,
                        padding: EdgeInsets.only(top:4,bottom:4,),
                        decoration: BoxDecoration(
                          //  color: Theme.of(context).buttonColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                          gradient: LinearGradient(
                            colors: [Theme
                                .of(context)
                                .cardColor,
                              Theme
                                .of(context)
                                .cardColor
                            ],
                          ),

                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap:() async {
                                Provider.of<ThemeNotifier>(context,listen: false).setLightMode();
                                isCheckedwhite = true;
                                isCheckDark = false;
                                await SharedPreferenceClass.SetSharedData("themeMode","light");
                              },
                              child: Padding(
                                padding:  EdgeInsets.only(left:8.0,right:8.0,top:28,bottom: 8.0),
                                child:
                                Container(
                                  height: 40,
                                  width:size.width,
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
                                    padding: const EdgeInsets.only(left:20.0,right: 8.0),
                                    child: Align(
                                      alignment:Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text( "White Knight",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(color: Theme
                                                .of(context)
                                                .textTheme
                                                .headline2
                                                ?.color,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,),),

                                          GFCheckbox(
                                            size: 20,
                                            activeBorderColor:Theme.of(context).hintColor,
                                            activeBgColor: Theme.of(context).hintColor,
                                            onChanged: (value) {
                                              setState(() async {
                                                Provider.of<ThemeNotifier>(context,listen: false).setLightMode();
                                                isCheckedwhite = value;
                                                isCheckDark = false;
                                                await SharedPreferenceClass.SetSharedData("themeMode","light");
                                              });
                                            },
                                            value: isCheckedwhite,
                                            activeIcon: Icon(Icons.check,color: Theme.of(context).textTheme.headline2?.color,size: 20,),
                                            inactiveBgColor: Theme.of(context).hintColor,
                                            inactiveBorderColor: Theme.of(context).hintColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Container(height: 1, color: Theme
                            //     .of(context)
                            //     .canvasColor,),

                            InkWell(
                              onTap: () async {
                                Provider.of<ThemeNotifier>(context,listen: false).setDarkMode();
                                isCheckDark = true;
                                isCheckedwhite = false;
                                await SharedPreferenceClass.SetSharedData("themeMode","dark");

                              },
                              child: Padding(
                                padding:  EdgeInsets.all(8.0),
                                child:
                                Container(
                                  height: 40,
                                  width:size.width,
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
                                    padding: const EdgeInsets.only(left:20.0,right: 8.0),
                                    child: Align(
                                      alignment:Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text( "Dark Knight",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(color: Theme
                                                .of(context)
                                                .textTheme
                                                .headline2
                                                ?.color,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,),),

                                          GFCheckbox(
                                            size: 20,
                                            activeBorderColor:Theme.of(context).hintColor,
                                            activeBgColor: Theme.of(context).hintColor,
                                            onChanged: (value) {
                                              setState(() async {
                                                Provider.of<ThemeNotifier>(context,listen: false).setDarkMode();
                                                isCheckDark = value;
                                                isCheckedwhite = false;
                                                await SharedPreferenceClass.SetSharedData("themeMode", "dark");

                                              });
                                            },
                                            value: isCheckDark,
                                            activeIcon: Icon(Icons.check,color: Theme.of(context).textTheme.headline2?.color,size: 20,),
                                            inactiveBgColor: Theme.of(context).hintColor,
                                            inactiveBorderColor: Theme.of(context).hintColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                    ],
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

class CustomList {
  String id;
  String Name;

  CustomList(this.id ,this.Name);
}

