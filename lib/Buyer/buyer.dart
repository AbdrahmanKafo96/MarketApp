import 'package:badges/badges.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:marketApp/Buyer/Department.dart';
 import 'package:marketApp/Buyer/customCatgs.dart';
import 'package:marketApp/Buyer/ordersPage.dart';
import 'package:marketApp/Buyer/viewMarketsData.dart';
import 'package:marketApp/provider/userProvider.dart';
import 'package:marketApp/widget/checkInternet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer.dart';

class BuyerPage extends StatefulWidget {
  goOrderPage(BuildContext context , {String orderState}) async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    String uid=pref.getString('uid');
    if(uid==null)
      uid=FirebaseAuth.instance.currentUser.uid;

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => OrdersPage(uid ,orderState: orderState,)
      ),
    );
  }
  @override
  _BuyerPageState createState() => _BuyerPageState();
}

class _BuyerPageState extends State<BuyerPage> {
  List list =List();
  SharedPreferences sharedPrefs;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
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
    _shoppingCartBadge()   {
    return Consumer<Prov>(

      builder: (context, myProv ,child)   {

        myProv.setIncremntCountCart(i: sharedPrefs.getInt('numberOfNoti')==null?
        0:sharedPrefs.getInt('numberOfNoti'));
        return myProv.getNotiBuyer()>0? Badge(
          position: BadgePosition.topEnd(top: 0, end: 3),
          animationDuration: Duration(milliseconds: 300),
          animationType: BadgeAnimationType.slide,
            badgeContent: Text('${myProv.getNotiBuyer() }',
            style: TextStyle(color: Colors.white),) ,
          child: IconButton(icon: Icon(Icons.shopping_cart,size: 20,), onPressed: () {
            BuyerPage().goOrderPage(context , orderState: "temporaryRequest");

          }),
        ) :IconButton(icon: Icon(Icons.shopping_cart,size: 20,), onPressed: () {
          BuyerPage().goOrderPage(context ,orderState:'temporaryRequest');

        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    checkInternetConnectivity(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: onPressedBack,
        child: Scaffold(
            drawer: getCustomDrawer(context  ),
            appBar: AppBar(
              title: Text('الصفحة الرئيسية' ,style: TextStyle(fontWeight:FontWeight.bold ),),
              actions: [
                sharedPrefs!=null?
                _shoppingCartBadge():
                IconButton(icon: Icon(Icons.shopping_cart,size: 20,), onPressed: () {
                  BuyerPage().goOrderPage(context ,orderState:'temporaryRequest');
                }),

              ],
            ),
            body: ListView(

              children: [
                getCarousel(),
                Container(
                  child: Text(
                    "الأصناف",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blueGrey),
                  ),
                  padding: EdgeInsets.all(10),
                ),
                Container(
                  child: myCustomList(context),
                  height: 100,
                ),
                Container(
                  child: Text(
                    "الأقسام",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blueGrey),
                  ),
                  padding: EdgeInsets.all(10),
                ),
                Department(),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>MarketsData()
                      ),
                    );
                  },
                  child: Container(
                    child: Text(
                      "عرض كل المحلات",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blueGrey),
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget getCarousel({List<NetworkImage> imgs}) {
    return SizedBox(
      height: 200.0,
      // width: 300.0,
      child: Container(
        width: double.infinity,
        //   padding: EdgeInsets.all(10),
        child: Carousel(
            showIndicator: true,
            boxFit: BoxFit.cover,
            borderRadius: true,
            dotSpacing: 20,
            autoplay: true,
            dotBgColor: Colors.black.withOpacity(0.5),
            dotIncreasedColor: Colors.grey,
            radius: Radius.circular(20),
            // overlayShadowColors: Colors.blueAccent,
            //\ overlayShadow: true,
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: Duration(milliseconds: 1000),
            dotSize: 7,
            images: [
              Image.network(
                  "https://zu.edu.ly/upload/newsimage-1580562051489.jpg" ,fit: BoxFit.fill,),
              Image.network(
                  "https://zu.edu.ly/upload/newsimage-1580562051489.jpg",fit: BoxFit.fill,),
              Image.network(
                  "https://zu.edu.ly/upload/newsimage-1580562051489.jpg",fit: BoxFit.fill,),
            ]
            //imgs,
            ),
      ),
    );
  }

}
