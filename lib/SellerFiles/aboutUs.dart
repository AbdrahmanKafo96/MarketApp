import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
import 'package:marketApp/widget/checkInternet.dart';
import 'package:url_launcher/url_launcher.dart';
class AboutUS extends StatelessWidget {
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
        body: ListView(
          children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ContactUs(
                      logo: AssetImage('assets/imgs/marketLogo.jpg'  ),
                      email: 'info@almahal-tr.com',
                      companyName: 'تطبيق محل',
                      phoneNumber: "00218910838740",
                      emailText: 'info@almahal-tr.com',
                      phoneNumberText: '00905389621542',
                      instagram: 'almahal2021?igshid=1qsy9ms1vgfje',
                      facebookHandle: 'almahaltr/',
                      tagLine: ': تواصل معنا على',
                      textColor: Colors.grey,
                      cardColor: Colors.white,
                      companyColor: Colors.black,
                      taglineColor: Colors.black,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(right: 10,left: 10),
              child: Card(
                margin: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 25.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.phone_android),
                  title: Text(
                    "00905389621542"  ,
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                  onTap: () {
                    launch('tel:' + "00905389621542");
                  },
                ),

              ),
            ),

          ],
        ),

    );
  }
}
