import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketApp/widget/checkInternet.dart';

class Order extends StatefulWidget {

  String buyerID , sellerID,sellerRout;
  Order({this.buyerID, this.sellerID , this.sellerRout});

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    checkInternetConnectivity(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(' طلبيات العميل' , style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,

      ),

      body:Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            color: Colors.grey.withOpacity(0.2),
            child: fun()),
      )
    );
  }

 Widget fun(){
    return  StreamBuilder(
      stream: FirebaseFirestore.instance.collection('userOrders')
          .where('userID' ,isEqualTo: widget.buyerID)
           .where('sellerID' ,isEqualTo: widget.sellerID)
          .snapshots(),

      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data.docs == null)
          return Center(
            child: Center(child: Text("انتظر قليلا"),),
          );

        if (snapshot.hasError)
          return Center(child: Center(child: Text("تحقق من اتصالك بالانترنت."),),);

        if (snapshot.hasData && snapshot.data.docs.length > 0) {
          return ListView.builder(

            itemCount: snapshot.data.docs.length,
            itemBuilder: (context,index){
              return
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text('رقم الطلبية ${snapshot.data.docs[index]['orderId'] } ',style: TextStyle(color: Colors.blue ,fontWeight: FontWeight.bold,fontSize: 16),),
                          widget.sellerRout!='fromSeller'? ListTile(
                            title: Text(' اسم المشتري:${snapshot.data.docs[index]['userName']}' ,style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle:Text('رقم هاتف المشتري: ${snapshot.data.docs[index]['userPhone']}') ,
                            trailing:  Text('سعر المنتج: ${snapshot.data.docs[index]['priceProduct']}\$'),
                           ):SizedBox.shrink(),
                          Divider(color: Colors.grey,),
                          ListTile(
                            title:  Text('اسم المنتج: ${snapshot.data.docs[index]['productName']}',style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle:  Text('الرقم التسلسلي:${snapshot.data.docs[index]['productNumber']}'),
                            trailing:Text('الكمية: ${snapshot.data.docs[index]['quantity']}'),
                          ),
                          Divider(color: Colors.grey,),
                          widget.sellerRout!='fromSeller'? ListTile(
                            title: Text(' اسم البائع:${snapshot.data.docs[index]['sellerName']}',style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text('رقم هاتف البائع: ${snapshot.data.docs[index]['sellerPhone']}'),
                          ):SizedBox.shrink(),




                       //   Divider(color: Colors.grey,)
                        ],
                      ),
                    ),
                  );
            },
          );
        }
        else {
          return Center(child: Text("هناك مشكلة تواصل مع المدير"),);
        }
      },
    );
 }
}
