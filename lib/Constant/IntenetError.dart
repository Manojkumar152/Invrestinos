import 'package:flutter/material.dart';

class InternetError extends StatefulWidget {
  const InternetError({Key? key}) : super(key: key);

  @override
  State<InternetError> createState() => _InternetErrorState();
}

class _InternetErrorState extends State<InternetError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: [
              Icon(Icons.wifi_off,size: 50,color: Colors.white,),
              Text("Connection failed: Please check your network settings. ")
            ],
          ),
        ),
      ),
    );
  }
}
