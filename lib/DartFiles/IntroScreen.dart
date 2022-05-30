import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketApp/widget/buttonWidget.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF252839),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(),
              Image.asset('assets/imgs/marketLogo.jpg'),
              ButtonWidget(
                text: 'مرحبا بك',
                onPressed: () {
                  Navigator.of(context).pushNamed('login');
                },
                bgColor: 0xFF17eb8a,
                textColor: Colors.white,
              ),
              // some code here ...
            ],
          ),
        ),
      ),
    );
  }
}
