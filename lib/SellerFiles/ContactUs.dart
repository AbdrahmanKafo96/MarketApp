
import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
import 'package:marketApp/widget/checkInternet.dart';

class Contactus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    checkInternetConnectivity(context);
    return   Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),

        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ContactUs(
            logo: AssetImage('assets/imgs/programmerlogo.png'),
            email: 'abdrahmankafo@gmail.com',
            companyName: '',
            githubUserName: 'AbdrahmanKafo96',
            linkedinURL: 'https://www.linkedin.com/in/abdrahman-kafo-945b331b5/',
            tagLine: 'Flutter Developer',
            twitterHandle: 'https://twitter.com/AbdrhmaKa?s=09&fbclid=IwAR2iPo1YUQSjMd5lsrhAYhp0l5oM6vXOvZFYcFxL05rBvwRo7zQMxJSuypE',
            textColor: Colors.black,
            cardColor: Colors.white,
            companyColor: Colors.black,
            taglineColor: Colors.black,
          ),
        ),

    );
  }
}
