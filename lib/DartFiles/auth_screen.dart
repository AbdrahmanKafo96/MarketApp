import 'package:flutter/material.dart';
import 'package:marketApp/widget/AuthForm.dart';

enum AuthType { login , register}
class AuthScreen extends StatelessWidget {
  final AuthType authType;

  const AuthScreen({Key key, @required this.authType}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.5,
                decoration: BoxDecoration(
                    color: Color(0xFF252839),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    )
                ),
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 50,),
                    // Text("!مرحبا بك" ,
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 28,
                    //     letterSpacing: 1.5,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    Image.asset('assets/imgs/marketLogo.jpg',
                      height: 200,
                    ),
                  ],
                ),
              )
            ],
          ),

          AuthForm(authType: authType ),

        ],
      ),
            ),
    );
  }
}
