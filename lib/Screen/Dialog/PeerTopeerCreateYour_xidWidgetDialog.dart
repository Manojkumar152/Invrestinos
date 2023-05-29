
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:investions/Screen/Dialog/PleaseConfirmWidget.dart';
import '../P2P/P2PSellerMatchedMakePayment.dart';


class PeerTopeerCreateYour_xidWidgetDialog extends StatefulWidget {
  static const id = 'PeerTopeerCreateYour_xidWidgetDialog';

  @override
  State<PeerTopeerCreateYour_xidWidgetDialog> createState() => _PeerTopeerCreateYour_xidWidgetDialogState();
}

class _PeerTopeerCreateYour_xidWidgetDialogState extends State<PeerTopeerCreateYour_xidWidgetDialog> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Dialog(
      elevation: 1,
      backgroundColor: Theme
          .of(context)
          .cardColor.withOpacity(0.9),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        height: size.height*0.465,
        width: size.width,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(6.0),),
            gradient: LinearGradient(
              colors: [Theme
                  .of(context)
                  .hintColor,
                Theme
                    .of(context)
                    .hintColor
              ],
            ),
            border: Border.all(width: 1,color: Theme.of(context).hintColor.withOpacity(0.6))
        ),
         child: SingleChildScrollView(
           child: BuyWidget(size),
         ),

      ),
    );
  }

 Widget BuyWidget(Size size) {
    return  Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding:  EdgeInsets.only(left: 10.0,right: 10.0,top: 4.0,bottom: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text( "Create Your Xid",
                  style: TextStyle(color: Theme
                      .of(context)
                      .textTheme
                      .headline2
                      ?.color,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,),),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                    child: Icon(Icons.cancel,size: 24,)),
              ],
            ),

          ),
        ),
        Container(height: 0.5, color: Theme
            .of(context)
            .indicatorColor.withOpacity(0.5),),

        Padding(
          padding:  EdgeInsets.only(left:6.0,right: 6.0,top:4.0,bottom: 8.0),
          child: Column(
            children: [
              SizedBox(height: 16,),
              Container(
                height:size.height*0.13 ,
                width: size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Theme
                          .of(context)
                          .hintColor.withOpacity(0.6),
                        Theme.of(context)
                            .hintColor.withOpacity(0.6)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2)),
              ),

              SizedBox(height: 20,),
              Container(
                height:26 ,
                width: size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .indicatorColor
                        .withOpacity(0.4),
                    borderRadius: BorderRadius.circular(2)),
                child: TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    errorStyle: TextStyle(fontSize: 8,color: Colors.red),
                    contentPadding:  EdgeInsets.only(left: 10,bottom: 15),
                    hintText: 'eg:cryptotrader',
                    hintStyle: TextStyle(
                      color: Theme.of(context)
                          .indicatorColor
                          .withOpacity(0.4),
                      fontSize: 11.0,
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headline3?.color,
                    fontSize: 11.0,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 2.0, right: 4.0,top: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Min 4 character, a-z,and 0-9 only.avoid using real name.",
                      style: TextStyle(color: Theme
                          .of(context)
                          .indicatorColor.withOpacity(0.8),
                        fontSize: 8,
                        fontWeight: FontWeight.w600,),),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  //showDialog(context: context, builder: (BuildContext context)=>PleaseConfirmWidget());

                },
                child: Container(

                  width: size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Theme
                            .of(context)
                            .hoverColor.withOpacity(0.8),
                          Theme.of(context)
                              .hoverColor.withOpacity(0.8)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(2)),
                  child: Padding(
                    padding: const EdgeInsets.only(top:6.0,bottom: 6.0),
                    child: Text("CREATE XID",textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline1?.color,
                          fontSize: 11.0,fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )

        // Container(height: 1, color: Theme
        //     .of(context)
        //     .canvasColor,)
      ],
    );
 }

}
