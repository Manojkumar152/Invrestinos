import 'package:flutter/material.dart';

class InfoTab extends StatefulWidget {

  String highDay;
  String lowDay;
  InfoTab({required this.highDay, required this.lowDay});

  @override
  State<InfoTab> createState() => _InfoTabState();
}

class _InfoTabState extends State<InfoTab> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.062),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Coin Performance', style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 17, letterSpacing: 0.5, fontWeight: FontWeight.w700),),
            SizedBox(height: height * 0.04,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('24H High', style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 15, letterSpacing: 0.5, fontWeight: FontWeight.w700),),
                Text(widget.highDay, style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 13, letterSpacing: 0.5, fontWeight: FontWeight.w600),),
                //Text(st != null ? st.containsKey('h') == true ? st['h'] :  widget.currency_data['HIGHDAY'] : widget.currency_data['HIGHDAY'], style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 13, letterSpacing: 0.5, fontWeight: FontWeight.w600),),
              ],
            ),
            SizedBox(height: height * 0.03, child: Divider(color: Theme.of(context).dividerColor,)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('24H Low', style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 15, letterSpacing: 0.5, fontWeight: FontWeight.w700),),
                Text(widget.lowDay, style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 13, letterSpacing: 0.5, fontWeight: FontWeight.w600),),
                //Text(st != null ? st.containsKey('l') == true ? st['l'] : widget.currency_data['LOWDAY'] : widget.currency_data['LOWDAY'], style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 13, letterSpacing: 0.5, fontWeight: FontWeight.w600),),
              ],
            ),
            SizedBox(height: height * 0.03, child: Divider(color: Theme.of(context).dividerColor,)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('1Y High', style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 15, letterSpacing: 0.5, fontWeight: FontWeight.w700),),
                Text('₹ 54,99,999.00', style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 13, letterSpacing: 0.5, fontWeight: FontWeight.w600),),
              ],
            ),
            SizedBox(height: height * 0.03, child: Divider(color: Theme.of(context).dividerColor,)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('1Y Low', style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 15, letterSpacing: 0.5, fontWeight: FontWeight.w700),),
                Text('₹ 18,00,000.00', style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 13, letterSpacing: 0.5, fontWeight: FontWeight.w600),),
              ],
            ),
            SizedBox(height: height * 0.08),
          ],
        ),
      ),
    );
  }
}
