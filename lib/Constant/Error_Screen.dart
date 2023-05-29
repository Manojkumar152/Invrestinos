import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {

  CustomError({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height*0.5,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/serveError.jpg'),
              Text('Oops! Something went wrong!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 21),
              ),
            ],
          ),
        ),
      ),
    );
  }
}