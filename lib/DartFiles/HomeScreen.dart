import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketApp/Buyer/buyer.dart';
import 'package:marketApp/SellerFiles/sellerpage.dart';
import 'package:marketApp/adminFiles/AdminDashboard.dart';
import 'package:marketApp/main.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  
  FirebaseAuth firebaseAuth =FirebaseAuth.instance;
    Future<void> singOut(BuildContext context) async {
      SharedPreferences pref=await SharedPreferences.getInstance();
      pref.remove('uid');
      pref.remove('email');

    firebaseAuth.signOut().then((value) =>
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> StartApp()))
    );
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences pref;
  String result;
    String uid;
    userState( )  {
      if(pref!=null)
    uid=pref.getString('uid');
     print("uid is $uid");
    if(uid!="") {
      FirebaseFirestore.instance
          .collection('users')
          .where('userid', isEqualTo: uid)
          .snapshots().first.then((value){
        result = value.docs[0]["state"];
      });
    }
  }

bool _loading=true;
  @override
  initState(){
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _loading = false;
      });
    });
    SharedPreferences.getInstance().then((prefs) {
      setState((){
        pref = prefs;
        userState();
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return  _loading ?
    Scaffold(
      body: Center(
          child: CircularProgressIndicator()),
    ):  Scaffold(
        resizeToAvoidBottomInset: false,
        body:    Container(
             child: result == "admin"
                 ? AdminDashboard()
                 : result == "بائع"
                 ? SellerPage( )
                 : result == "مشتري"
                 ? BuyerPage()
                 : build(context),
           ));


  }
}
