import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketApp/DartFiles/HomeScreen.dart';
import 'package:marketApp/adminFiles/GridDashBoard.dart';
import 'package:marketApp/adminFiles/dismissable.dart';
import 'package:marketApp/widget/checkInternet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDashboard extends StatefulWidget {
  static var numberOFNoti;
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {


  @override
  initState()   {
    super.initState();
  }

  updateNumberOFNoti()
  {
    FirebaseFirestore.instance.collection('Notices')
        .where('adminRead',isEqualTo: 'unRead').snapshots().first.then((value) {
      setState(() {
        AdminDashboard.numberOFNoti=value.docs.length  ;
      });
    });
  }
  Future<bool> onPressedBack(){
    print("context not found");
    return showDialog(
        context: context,
        builder: (context)=>
            AlertDialog(
              title: Text('هل فعلا تود الخروج من التطبيق ؟',textDirection: TextDirection.rtl,),
              actions: [
                FlatButton(  color: Colors.blueGrey,onPressed: ()=>Navigator.pop(context,true), child: Text('نعم',)),
                FlatButton(onPressed: ()=>Navigator.pop(context,false), child: Text('لا')),

              ],
            )
    );
  }
  @override
  Widget build(BuildContext context) {
    updateNumberOFNoti();
    checkInternetConnectivity(context);
    return WillPopScope(
      onWillPop: onPressedBack,
      child: Scaffold(

        appBar: AppBar(
          title: Text("الصفحة الرئيسية"),
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.logout),onPressed: ()async{
            SharedPreferences pref=await SharedPreferences.getInstance();
            pref.remove('uid');
            pref.remove('email');
            HomeScreen().singOut(context);
          },),
          actions: [
            Badge(
              badgeContent: Text('${AdminDashboard.numberOFNoti}' ,style: TextStyle(color: Colors.white),),
              child:
              IconButton(icon: Icon(Icons.notifications,size: 20,), onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  DismissibleApp(),
                    ));
              }),),

            // IconButton(
            //     icon: Icon(
            //       Icons.search,
            //     ),
            //     onPressed: () {}),
          ],
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height/20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Directionality(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "مرحبا بك في تطبيق محل",
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "الصفحة الرئيسية",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GridDashBoard()
          ],
        ),
      ),
    );
  }
}
