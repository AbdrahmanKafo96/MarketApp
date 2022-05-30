 import 'package:flutter/material.dart';
import 'package:marketApp/Buyer/buyer.dart';
import 'package:marketApp/Buyer/dept.dart';
 import 'package:marketApp/Buyer/viewMarketsData.dart';
import 'package:marketApp/DartFiles/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
 import 'package:marketApp/SellerFiles/aboutUs.dart';



Drawer getCustomDrawer(BuildContext context  ){
   return Drawer(
    child: Column(
      children: <Widget>[
        UserAccountsDrawerHeader(
            accountName: Text("",style:
            TextStyle(fontWeight: FontWeight.bold,
                color: Colors.black,letterSpacing: 2)),
             accountEmail: Text("",
               style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
       //   currentAccountPicture: CircleAvatar(child: Icon(Icons.person_pin ,color: Colors.grey,),backgroundColor: Colors.white,),
          decoration: BoxDecoration(
            color: Color(0xFF242b3b),
            image: DecorationImage(
              image: AssetImage('assets/imgs/drawing.jpg' ),fit: BoxFit.contain
            )
          ),
        ),
        ListTile(
          title: Text("الصفحة الرئيسية" , style: TextStyle(fontWeight: FontWeight.bold),),
          leading: Icon(Icons.home_outlined , color: Color(0xFF37474F),),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BuyerPage()
              ),
            );

          },
        ),
        ListTile(
          title: Text("الاقسام" , style: TextStyle(fontWeight: FontWeight.bold),),
          leading: Icon(Icons.apartment_rounded , color: Color(0xFF37474F),),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>  DeptPage()),
            );
          },
        ),
        ListTile(
          title: Text("المحلات" , style: TextStyle(fontWeight: FontWeight.bold),),
          leading: Icon(Icons.shopping_cart_sharp , color: Color(0xFF37474F),),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MarketsData()),
            );
          },
        ),
        Divider(color: Colors.grey, height: 2,),
        ListTile(
          title: Text("الطلبات المحجوزة" , style: TextStyle(fontWeight: FontWeight.bold),),
          leading: Icon(Icons.add_shopping_cart , color: Color(0xFF37474F),),
          onTap: () {
            BuyerPage().goOrderPage(context ,orderState: 'temporaryRequest');
          },
        ),

        ListTile(
          title: Text("الطلبيات السابقة" , style: TextStyle(fontWeight: FontWeight.bold),),
          leading: Icon(Icons.account_box_outlined , color: Color(0xFF37474F),),
          onTap: (){
            BuyerPage().goOrderPage(context ,orderState: 'requestDone');
          },
        ),
        ListTile(
          title: Text("حول التطبيق" , style: TextStyle(fontWeight: FontWeight.bold),),
          leading: Icon(Icons.account_box_outlined , color: Color(0xFF37474F),),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AboutUS()
              ),
            );
          },
        ),
        // ListTile(
        //   title: Text("معلومات مطور التطبيق" , style: TextStyle(fontWeight: FontWeight.bold),),
        //   leading: Icon(Icons.person_pin_rounded , color: Color(0xFF37474F),),
        //   onTap: (){
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => Contactus()
        //       ),
        //     );
        //   },
        // ),
        ListTile(
          title: Text("تسجيل الخروج" , style: TextStyle(fontWeight: FontWeight.bold),),
          leading: Icon(Icons.login_outlined  , color: Color(0xFF37474F),),
          onTap: () async {

              SharedPreferences pref=await SharedPreferences.getInstance();
              pref.remove('uid');
              pref.remove('email');
              HomeScreen().singOut(context);


          },
        ),
      ],
    ),
  );
}