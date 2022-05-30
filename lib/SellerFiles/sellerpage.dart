import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:marketApp/SellerFiles/marketInfo.dart';
import 'package:marketApp/SellerFiles/addProduct.dart';
import 'package:marketApp/SellerFiles/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';

// ignore: must_be_immutable
class SellerPage extends StatefulWidget {
  int currentIndex=0;
  @override
  _SellerPageState createState() => _SellerPageState();
}
class _SellerPageState extends State<SellerPage> {
  int currentIndex=0;
  int documentsLenght;
  SharedPreferences pref;
  var tabs=[
  HomePage( ),
    Product() ,
  SettingPages(),
  ] ;
  @override
    initState()  {
     super.initState();
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

    return WillPopScope(
      onWillPop: onPressedBack,
      child: Scaffold(
         resizeToAvoidBottomInset: false,

        body: tabs[currentIndex] ,
        bottomNavigationBar: CurvedNavigationBar(
          index: widget.currentIndex,
         // height: MediaQuery.of(context).size.height /10,
          backgroundColor:Color(0xFFFFFFFF),

          color:Color(0xFF363742),

           buttonBackgroundColor:Color(0xFF15e887),

          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 900),
          onTap: (index) {
            setState(() {
              currentIndex = index;
              print(index);
            });
          },
          items: <Widget>[
            Icon(Icons.home, size: 25,color: Colors.white,),
            Icon(Icons.add, size: 25,color: Colors.white,),
            Icon(Icons.settings, size: 25,color: Colors.white,),
          ],
        ),
 ),
    );
  }

    heHaveDataStore() {
    if(pref!=null)
      {
        String uid=pref.getString('uid');

        if(uid!="") {
          FirebaseFirestore.instance
              .collection('marketData')
              .where('userid', isEqualTo: uid)
              .snapshots().first.then((value){
                      int result = value.docs.length;
                      print("the reslut is $result");
                      if(true)
                        {
                         return AlertDialog(
                            title: const Text("استكمل بياناتك" ,style: TextStyle(fontWeight: FontWeight.bold),),
                            content: const Text(
                                "من فضلك استكمل بيانات المحل"),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text("لا",)),
                              FlatButton(
                                onPressed: ()  {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MarketInfo()),
                                  );
                                },
                                child: const Text("نعم",style: TextStyle(color:Colors.white )),
                                color: Colors.redAccent,
                              ),
                            ],
                          );
                        }

                    });
        }
      }
    return SizedBox.shrink();
  }

}
