import 'dart:math';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marketApp/Buyer/buyer.dart';
import 'package:marketApp/provider/userProvider.dart';
import 'package:marketApp/widget/checkInternet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ItemView extends StatefulWidget {
int priceProduct;
    String   brandProduct, productName  , sellerID ,productNumber;
    List<NetworkImage> listImgs;
    List  sizes , colors;
    ItemView({this.productName,this.brandProduct,this.priceProduct ,
      this.listImgs , this.sizes ,this.colors , this.sellerID ,this.productNumber});
void showShortToast(String meg ,{Color colors}) {
  Fluttertoast.showToast(
      msg: "$meg",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: colors,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

  @override
  _ItemViewState createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
   int _currentCount=1;
    bool switchVal=false;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    checkInternetConnectivity(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('عرض المنتج' ,style: TextStyle(fontWeight: FontWeight.bold),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ),
        body: Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            // Image.asset('assets/imgs/kyc.png' ,fit: BoxFit.fill,height: 200,
            //   width: MediaQuery.of(context).size.width,),
            getCarousel(imgs: widget.listImgs),
            Container(
              padding: EdgeInsets.all(10),
              child: Text("وصف المنتج",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blueGrey),),
            ),
           Stack(
                children: [
                  SizedBox(
                    child: Container(
                      margin:EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text("${widget.productName}" ,style: TextStyle(
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    height: 1,

                                  ),),
                                  Text("${widget.brandProduct}",style: TextStyle(
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    fontSize: 12,
                                    height: 2,
                                  ),),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${widget.priceProduct}\$', style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),),
                          ),
                          ]
                      ) ,
                 ),
               ),
                  Positioned(
                    top: 0,
                    bottom:10,
                    right: 10,
                    child: Image.asset('assets/imgs/kyc.png'),),
                ],
           ),
           Container(

             padding: EdgeInsets.all(10),
             child: Column(
               children: [
                 Row(
                   children: [
                   Text("الألوان" ,style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 20,
                       color: Colors.blueGrey), )
                 ],),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children:
                         fun(colors: widget.colors),
                    ),
                 ),
                 Row(
                   children: [
                     Text("الأحجام" ,style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 20,
                         color: Colors.blueGrey), )
                   ],),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children:
                     showSizes(sizes: widget.sizes),
                   ),
                 ),


                 Row(
                   children: [
                     Text("الكمية:" ,style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 20,
                         color: Colors.blueGrey), )
                   ],),
                 Container(
                   width: MediaQuery.of(context).size.width/3,
                     padding: EdgeInsets.zero,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20),
                       color: Colors.white,
                       boxShadow: [
                         BoxShadow(
                           color: Colors.grey.withOpacity(0.4),
                           spreadRadius: 5,
                           blurRadius: 7,
                           offset: Offset(0, 2), // changes position of shadow
                         ),
                       ],
                     ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: <Widget>[
                       _createIncrementDicrementButton(icon: Icons.add ,onPressed: _increment),
                       Text('$_currentCount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                       _createIncrementDicrementButton(icon: Icons.remove ,onPressed: _dicrement),
                     ],
                   ),
                 ),
            SizedBox(height: 12,),
            Container(
              margin: EdgeInsets.all(20),

              height: 50.0,
              child: Consumer<Prov>(
                builder: (context ,myProv ,child){
                  return InkWell(
                    highlightColor: Colors.green.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30.0),
                    onTap: () async {
                      SharedPreferences pref=await SharedPreferences.getInstance();
                      String uid=pref.getString('uid');

                      var result = uid==null?  FirebaseAuth.instance.currentUser.uid:uid;

                      if(result !=null) {
                           FirebaseFirestore.instance.collection("userOrders")
                               .where('productNumber',isEqualTo: widget.productNumber)
                                .where('userID',isEqualTo: uid)
                               .snapshots().first.then((value){
                             if(value.docs.length >0) {
                               ItemView().showShortToast(
                                   'هذا المنتج موجود مسبقا في السلة',
                                   colors: Colors.orange);
                               showDialog(
                                 context: context,
                                 builder: (BuildContext context) {
                                   return Directionality(
                                     textDirection: TextDirection.rtl,
                                     child: AlertDialog(
                                       title: const Text("متابعة التسوق"),
                                       content: const Text(
                                           "هل تود الاستمرار في التسوق أو الذهاب لطلب المنتجات؟"),
                                       actions: <Widget>[
                                         FlatButton(
                                             onPressed: () {
                                               Navigator.of(context).pop(false);
                                             },
                                             child: const Text("الاستمرار في التسوق",)),
                                         FlatButton(
                                           onPressed: () {
                                             BuyerPage().goOrderPage(context,orderState: 'temporaryRequest');

                                           },
                                           child: const Text("طلب السلع",style: TextStyle(color:Colors.white )),
                                           color: Colors.lightGreen,
                                         ),
                                       ],
                                     ),
                                   );
                                 },
                               );
                             }

                             else{
                               var phoneNumber ,username , sellerName, sellerPhone;
                               FirebaseFirestore.instance.collection("users")
                                   .where('userid',isEqualTo: uid)
                                   .snapshots().first.then((value){
                                 username=value.docs[0]['username'] ;
                                 phoneNumber=value.docs[0]['phonenumber'] ;

                                 FirebaseFirestore.instance.collection("users")
                                     .where('userid',isEqualTo: widget.sellerID )
                                     .snapshots().first.then((value)   {
                                   sellerPhone=value.docs[0]['phonenumber'] ;
                                   sellerName=value.docs[0]['username'] ;
                                   Random random = new Random();
                                   Random random2 = new Random();

                                   int randomNumber = random.nextInt(10);
                                   int orderId = random2.nextInt(100000*randomNumber);
                                   FirebaseFirestore.instance.collection("userOrders").doc()
                                       .set({
                                     'orderId':orderId,
                                     "userID":result,
                                     'userName':username,
                                     'userPhone':phoneNumber,
                                     'orderState':'temporaryRequest',

                                     'productName':widget.productName,
                                     'productImg':widget.listImgs[0].url.toString(),
                                     'priceProduct':widget.priceProduct,
                                     'productNumber':widget.productNumber,
                                     'quantity':_currentCount,
                                     'sellerID':widget.sellerID,
                                     'sellerName':sellerName,
                                     'sellerPhone':sellerPhone,
                                     'date': FieldValue.serverTimestamp()
                                   });
                                 }) ;
                               }).then((value) {
                                 ItemView().showShortToast('تم إضافة المنتج لسلة' ,
                                     colors:Colors.green);
                                 myProv.setIncremntCountCart();
                                 pref.setInt('numberOfNoti',myProv.getNotiBuyer());
                               }) ;
                             }
                           })  ;
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text(
                              "اضف إلى السلة",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          Icon(Icons.add_shopping_cart, color: Colors.green,),
                        ],
                      ),
                    ),
                  );
                },

              ),
            )
               ],
             ),
           ),
         ]
        ),
      )
    ));
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
            boxFit: BoxFit.fill,
            borderRadius: true,
            dotSpacing: 20,
            autoplay: true,
            dotBgColor: Colors.black.withOpacity(0.5),
            dotIncreasedColor: Colors.blue,
            radius: Radius.circular(20),
            // overlayShadowColors: Colors.blueAccent,
            //\ overlayShadow: true,
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: Duration(milliseconds: 1000),
            dotSize: 7,
            images: imgs

        ),
      ),
    );
  }
  void _increment() {
    setState(() {
      _currentCount++;
    });
  }

  void _dicrement() {
    setState(() {
      if (_currentCount > 1) {
        _currentCount--;
      }
    });
  }
  Widget _createIncrementDicrementButton({IconData icon, Function onPressed}) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints(minWidth: 17.0, minHeight: 32.0),
      onPressed: onPressed,
      elevation: 2.0,
     // fillColor: LightGreyColor,
      child: Icon(
        icon,
       // color: BlackColor,
        size: 18.0,
      ),
      shape: CircleBorder(),
    );
  }

  List<Container> fun({List  colors}){

    List<Container> list=List();

    for(int i =0 ; i<colors.length ; i++){
      list.add(Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey, spreadRadius: 1)],
        ),
        child: CircleAvatar(
          radius: 11.0,
            //42000000
         backgroundColor: Color(int.parse(colors[i])),

        ),
      ));
    }
    return   list;
  }
  List<Container> showSizes({List  sizes}){

    List<Container> list=List();

    for(int i =0 ; i<sizes.length ; i++){
      list.add(Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(blurRadius:1, color: Colors.grey, spreadRadius: 1)],
        ),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20.0,
          child: Text('${sizes[i]}' ,style: TextStyle(

          ),),
        ),
      ));
    }
    return   list;
  }

}
