import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:investions/Api/ApiCollections.dart';
import 'package:investions/Constant/Nodata.dart';
import 'package:investions/Constant/ToastClass.dart';

import '../../../Api/ApiMain.dart';
import 'AddBank.dart';

class BankDetail extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BankDetail();
  }
}

class _BankDetail extends State<BankDetail> {
  List bankData=[];
  bool detail=false;
  int? selected_index;
  String isLoading="0";
  int? clickindex;
  bool nodata=false;
  List<CountryObj> countryList=[];

  @override
  void initState() {
    super.initState();
    getBankDetail();
  }

  Future<void> getBankDetail() async {
    final paramDic = {
      "":"",
    };
    print(paramDic);
    var response;
    response = await LBMAPIMainClass(ApiCollections.getbankdetail, paramDic, "Get");
    var data = json.decode(response.body);
    print("Get_bank_detail"+" "+data.toString());
    if(data["status_code"]=='1'){
      bankData.clear();
      setState(() {
        bankData=data['data'];
        isLoading="1";
      });
      if(bankData.length<=0){
        setState(() {
          nodata=true;
        });
        print("nodata");
      }else{
        setState(() {
          nodata=false;
        });
        print("nodata2");
      }
    }
    else{
      setState(() {
        isLoading="1";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;

    // TODO: implement build
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: height*0.3,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/dashboard_headerImage.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.05),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap:(){
                                Navigator.of(context).pop();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.arrow_back,color: Colors.white),
                                  SizedBox(width: 10,),
                                  Text('Bank Detail', style: TextStyle(fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white)),
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(10),
                                child:  InkWell(
                                  onTap: (){
                                      Navigator.pushNamed(context,"/AddNewBank").then((value) => getBankDetail());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                    ),padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                                    child:Text("Add New",textAlign: TextAlign.center, style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: Colors.black)),
                                  ),
                                )
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02),
                      ]
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left:10.0,right:10.0,),
              child: Container(
                  width: width,
                  decoration:  BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color:Theme.of(context).cardColor),
                  margin: EdgeInsets.only(top:130),
                  height:height,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child:  nodata?Nodata():isLoading=="0"?Center(
                        child: Container(
                            width:20,height:20,child: CircularProgressIndicator(color: Colors.orange))):
                   ListView.builder(
                        itemCount: bankData.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, i) {
                          print(bankData.length.toString());
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  color:Theme.of(context).cardColor,
                                border: Border.all(color:Theme.of(context).indicatorColor)
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(bankData[i]['alias']+'/Bank Account:'+bankData[i]['account_number'],textAlign: TextAlign.center, style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color:Theme.of(context).textTheme.headline2?.color)),
                                      InkWell(
                                          onTap: (){
                                            setState(() {
                                              detail=!detail;
                                              selected_index=i;
                                            });
                                          },
                                          child: Icon(detail==true?Icons.expand_less:Icons.expand_more,color:Theme.of(context).textTheme.headline2?.color,))
                                    ],
                                  ),
                                  Visibility(
                                    visible: detail==true?selected_index==i?true:false:false,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Divider(color: Theme.of(context).textTheme.headline2?.color,),
                                        Text("Your Bank account details for IMPS payments", style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color:Theme.of(context).textTheme.headline2?.color)),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text("Bank Account No :- ", style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color:Theme.of(context).textTheme.headline2?.color)),
                                            SizedBox(width: 4,),
                                            Text(bankData[i]['account_number'], style: TextStyle(
                                                fontSize: 11,fontWeight: FontWeight.w600,
                                                color:Theme.of(context).textTheme.headline2?.color)),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text("IFSC code :- ", style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color:Theme.of(context).textTheme.headline2?.color)),
                                            SizedBox(width: 4,),
                                            Text(bankData[i]['ifsc_code'], style: TextStyle(
                                                fontSize: 11,fontWeight: FontWeight.w600,
                                                color:Theme.of(context).textTheme.headline2?.color)),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text("Verification :- ", style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color:Theme.of(context).textTheme.headline2?.color)),
                                            SizedBox(width: 4,),
                                            Text(bankData[i]['verify_status'].toString(), style: TextStyle(
                                                fontSize: 11,fontWeight: FontWeight.w600,
                                                color:Theme.of(context).textTheme.headline2?.color)),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: InkWell(
                                            onTap: (){
                                              setState(() {
                                                clickindex=i;
                                              });
                                              DeleteAccount(bankData[i]['id'].toString()).then((value) => getBankDetail());
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(top: 8),
                                              width:70,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                              ),
                                              child:Center(
                                                child: clickindex==i?SizedBox(height: 15,width: 15,child: CircularProgressIndicator(color: Colors.white),):Text("Remove", style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 10,
                                                    color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  )
              ),
            ),
          ],
        )
    );
  }
  Future<void>DeleteAccount(String id)async{
    final paramDic={
      "":""
    };
    try{
      var response=await LBMAPIMainClass(ApiCollections.deleteBankAccount+id.toString(), paramDic,"Delete");
      var data=jsonDecode(response.body);
      if(data["status_code"]=="1"){
        setState(() {
          clickindex=-1;
        });
        ToastShowClass.toastShow(context, "Success",Colors.red);
      }else{
        setState(() {
          clickindex=-1;
        });
        ToastShowClass.toastShowerror(context, "Error",Colors.red);
      }
    }catch(e){
      setState(() {
        clickindex=-1;
      });
      ToastShowClass.toastShowerror(context, "Error",Colors.red);
    }
  }
}

class CountryObj {
  String name;
  CountryObj(this.name);
}