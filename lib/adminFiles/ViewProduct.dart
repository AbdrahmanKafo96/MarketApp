import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marketApp/widget/checkInternet.dart';

class ViewProduct extends StatefulWidget {
  String _ProductNum;

  String get getProductNum => _ProductNum;

  set setProductNum(String value) {
    _ProductNum = value;
  }

  @override
  _ViewProductState createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {

  List listImgs;
  @override
  void initState() {
     super.initState();
     listImgs=List();
  }
  void showShortToast(String meg , Color color) {
    Fluttertoast.showToast(
        msg: " $meg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:color,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  @override
  Widget build(BuildContext context) {
    checkInternetConnectivity(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('بيانات المنتج' ,style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(icon: Icon(Icons.remove_done ,color: Colors.white,), onPressed: (){
            var snapshot  =   FirebaseFirestore.instance
                .collection('products')
                .where("productNumber", isEqualTo: widget.getProductNum).snapshots();
            snapshot.first.then((value) {
              FirebaseFirestore.instance
                  .collection('products')
                  .doc(value.docs[0].id
                  .toString())
                  .update({
                'productState': "notAccept",
              });
            }) .whenComplete(() => showShortToast('تم رفض المنتج',Colors.green));

            Navigator.of(context).pop();
          }),
          IconButton(icon: Icon(Icons.done ,color: Colors.white,), onPressed: (){
           var snapshot  =   FirebaseFirestore.instance
                .collection('products')
                .where("productNumber", isEqualTo: widget.getProductNum).snapshots();
           snapshot.first.then((value) {
             FirebaseFirestore.instance
                 .collection('products')
                 .doc(value.docs[0].id
                 .toString())
                 .update({
               'productState': "Accept",
             });
           }) .whenComplete(() => showShortToast('تم قبول المنتج',Colors.green));

           Navigator.of(context).pop();
          }),

        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: StreamBuilder (
        stream: FirebaseFirestore.instance
            .collection('products')
        .where("productNumber", isEqualTo: widget.getProductNum)
            .snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot ){
          if(snapshot.data==null){
            return Center(
                child: CircularProgressIndicator()
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // String id =snapshot.data.docs[0].id;

          List<NetworkImage> networkImgs=List<NetworkImage>();
          listImgs=snapshot.data.docs[0]['image'];
          var timestamp=snapshot.data.docs[0]['date'];
        //  List  selectColors=snapshot.data.docs[0]['colors'];
          timestamp=  DateTime.parse(timestamp.toDate().toString());
          for(int i=0 ; i<listImgs.length;i++)
            {
              networkImgs.add(NetworkImage(listImgs[i]));
            }
          // List<Color> colors=List();
          // for(int i=0;i<selectColors.length;i++){
          //   colors.add( _colorFromHex(selectColors[i]) );
          // }
          // Text('${snapshot.data.docs[0]['productNumber']}')
            return SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,

                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    getCarousel(networkImgs),


                      Container(
                       // color: Colors.red,
                        padding: EdgeInsets.only(top: 10),
                        child: Column(children: [
                          getStyleText("اسم المنتج", "${snapshot.data.docs[0]['productName']}" ),
                           getStyleText("رقم المنتج" ,"${snapshot.data.docs[0]['productNumber']}"),
                           getStyleText("كمية المنتج","${snapshot.data.docs[0]['productQuantity']}"),
                           getStyleText("سعر المنتج","\$ ${snapshot.data.docs[0]['priceProduct']}"),
                           getStyleText("تصنيف المنتج","${snapshot.data.docs[0]['category']}"),
                           getStyleText("تصنيف المنتج حسب الجنس","${snapshot.data.docs[0]['state']}"),
                           getStyleText("ماركة المنتج","${snapshot.data.docs[0]['BrandProduct']}"),
                          getStyleText("تاريخ إضافة المنتج","$timestamp"),
                          getStyleText("الاحجام المتوفرة","${snapshot.data.docs[0]['sizes'].toString()}"),
                       //   getStyleText("الالوان المتفورة  ","${snapshot.data.docs[0]['colors'].toString()}"),
 
                        ],),
                      )

                  ],),
                ),
              ),
            );
        },
      )
    );

  }


  Widget getStyleText(String address ,String sub){

   return  Card(
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    child: Container(
    // decoration: BoxDecoration(
    // border: Border(left: BorderSide(color: Color(0xFF74767f), width: 2)
    // ),),
         child:  ListTile(
            // leading: Icon(Icons.done),
            title: Text(address ,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            //trailing: Icon(Icons.done),
            subtitle:  Text(sub,style: TextStyle(letterSpacing: 2),),
            dense: true,
          ),
    )
    );

  }
  Widget getCarousel(List<NetworkImage> imgs){
    return  SizedBox(
      height: 200.0,
      // width: 300.0,
      child: Container(

     //   padding: EdgeInsets.all(10),
        child: Carousel(
          boxFit: BoxFit.fitHeight,
          autoplay: false,
          overlayShadow: true,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1000),
          //dotSize: 7,
          dotIncreasedColor: Color(0xFF424242),
          dotBgColor: Colors.transparent,
          dotPosition: DotPosition.bottomCenter,
          dotVerticalPadding: 5,
          showIndicator: true,
          indicatorBgPadding: 5.0,
          images:
            imgs,
        ),
      ),
    );
  }
}