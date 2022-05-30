import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marketApp/Buyer/itemView.dart';
import 'package:marketApp/provider/userProvider.dart';
import 'package:marketApp/widget/checkInternet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersPage extends StatefulWidget {

String uid  ,orderState;
OrdersPage(this.uid ,{this.orderState});
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
  }
  int    currentCount;
  @override
  Widget build(BuildContext context) {
    checkInternetConnectivity(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => Navigator.of(context).pop(),
    ),
        title: Text( widget.orderState=='temporaryRequest'?"الطلبات المحجوزة":'الطلبيات السابقة'),
        centerTitle: true,
        actions: [
          widget.orderState=='temporaryRequest'? Consumer<Prov>(
      builder: (context, myProv,child){
            return IconButton(icon: Icon(Icons.check ,color: Colors.white,),
                onPressed: ()  async {

              print(myProv.getList);
                  SharedPreferences pref=await SharedPreferences.getInstance();
                  String uid=pref.getString('uid');







              print(myProv.getList);
                  if(myProv.getList !=null) {
                    myProv.orderRandomNumbers.forEach((element) {
                      FirebaseFirestore.instance
                          .collection('userOrders')
                          .doc(element).update({
                        'orderState':'requestDone',
                      });
                    });
                    for (int i = 0; i < myProv.getList.length; i++) {
                      FirebaseFirestore.instance
                          .collection("Notices")
                          .doc()
                          .set({

                              "readState": 'unRead',// for seller
                              "adminRead": 'unRead',//for admin
                              "NoticesName": 'طلبية منتج',
                              'NoticesMessage': ' تم طلب منتج من قبل${myProv.name}',
                              'NoticesNumber': 3,
                              'buyerID': uid,
                              'sellerName': myProv.getList[i],
                              'date': FieldValue.serverTimestamp(),
                             // 'orderId':FieldValue.increment(1),
                              'sellerID': myProv.idsList[i]
                      }).then((value) {
                        ItemView().showShortToast('تم طلب الطلبية بنجاح',
                            colors: Colors.green);
                      });
                    }
                    myProv.nameList=null;


                  } else{
                    ItemView().showShortToast('السلة فارغة' , colors:Colors.grey);
                  }

            },
            );}):SizedBox.shrink()
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Directionality(
            textDirection: TextDirection.rtl,
            child:  getOrders()
        ),
      )
    );
  }

  Widget getOrders(){

              return Consumer<Prov>(
                  builder: (context, myProv,child){
                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('userOrders')
                      .where('userID', isEqualTo:widget.uid )
                      .where('orderState', isEqualTo:widget.orderState )
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data.docs == null)
                      return Center(
                        child: Center(child: Text("لم يتم إضافة منتجات إلى السلة"),),
                      );

                    if (snapshot.hasError)
                      return Center(
                        child: Center(child: Text("تحقق من اتصالك بالانترنت."),),
                      );
                    if (snapshot.hasData && snapshot.data.docs.length > 0) {

                      List<String> names=List() ;
                      List<String> ids=List() ;
                      List<String> numberOrder=List();
                      return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {

                          if(widget.orderState=='temporaryRequest'){
                            names.add(snapshot.data.docs[index]['sellerName']);
                            ids.add(snapshot.data.docs[index]['sellerID']);
                            currentCount= snapshot.data.docs[index]['quantity'];
                            numberOrder.add(snapshot.data.docs[index].id);

                          }

                             if(index==snapshot.data.docs.length-1 &&widget.orderState=='temporaryRequest'){
                               myProv.nameList=names.toSet().toList();
                                myProv.name=snapshot.data.docs[index]["userName"];
                                myProv.idsList=ids.toSet().toList();
                                myProv.orderRandomNumbers=numberOrder;
                             }

                            return Container(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      "${snapshot.data.docs[index]['productName']}",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text("${snapshot.data.docs[index]['priceProduct']}\$" ),

                                    // subtitle:Container(
                                    //   margin: EdgeInsets.only(top: 20),
                                    //   width:100,
                                    //   padding: EdgeInsets.zero,
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(20),
                                    //     color: Colors.white,
                                    //     boxShadow: [
                                    //       BoxShadow(
                                    //         color: Colors.grey.withOpacity(0.4),
                                    //         spreadRadius: 5,
                                    //         blurRadius: 7,
                                    //         offset: Offset(0, 2), // changes position of shadow
                                    //       ),
                                    //     ],
                                    //   ),
                                    //   child: Row(
                                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    //     children: <Widget>[
                                    //       _createIncrementDicrementButton(icon: Icons.add ,onPressed: _increment),
                                    //       Text('$_currentCount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                    //       _createIncrementDicrementButton(icon: Icons.remove ,onPressed: _dicrement),
                                    //     ],
                                    //   ),
                                    // ) ,
                                    leading: Image.network(
                                      snapshot.data.docs[index]['productImg'],width: 50,
                                      fit: BoxFit.fill,
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.remove_shopping_cart,
                                        color: Colors.red,
                                        semanticLabel: "حذف",
                                      ),
                                    onPressed: (){

                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: AlertDialog(
                                              title: const Text("حذف عنصر" ,style: TextStyle(fontWeight: FontWeight.bold),),
                                              content: const Text(
                                                  "هل تريد حذف العنصر من السلة؟"),
                                              actions: <Widget>[
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop(false);
                                                    },
                                                    child: const Text("لا",)),
                                                FlatButton(
                                                  onPressed: ()  {
                                                    FirebaseFirestore.instance.collection("userOrders").doc(
                                                        snapshot.data.docs[index].id.toString()).delete().then((value) async {
                                                      SharedPreferences pref=await SharedPreferences.getInstance();
                                                       myProv.decremntCountCart();
                                                      pref.setInt('numberOfNoti',myProv.getNotiBuyer());
                                                    });
                                                    Navigator.of(context).pop(false);
                                                  },
                                                  child: const Text("حذف",style: TextStyle(color:Colors.white )),
                                                  color: Colors.redAccent,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    ),
                                    onTap: (){
                                      String productNumber=snapshot.data.docs[index]['productNumber'];
                                      FirebaseFirestore.instance.collection("products").
                                          where('productNumber',isEqualTo: productNumber)
                                          .where('userid',isEqualTo: snapshot.data.docs[index]['sellerID'])
                                          .snapshots().first.then(( snapshot){

                                        List listImgs = List();
                                        listImgs = snapshot.docs[0]['image'];
                                        List<NetworkImage> networkImgs = List<NetworkImage>();

                                        for (int i = 0; i < listImgs.length; i++) {
                                          networkImgs.add(NetworkImage(listImgs[i]));
                                        }
                                        List sizes = List();
                                        sizes = snapshot.docs[0]['sizes'];

                                        List colors = List();
                                        colors = snapshot.docs[0]['colors'];
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ItemView(
                                                productName: snapshot.docs[0]['productName'],
                                                brandProduct: snapshot.docs[0]['BrandProduct'],
                                                priceProduct: snapshot.docs[0]['priceProduct'],
                                                listImgs: networkImgs,
                                                sizes: sizes,
                                                colors: colors,

                                                sellerID: snapshot.docs[0]['userid'],
                                                productNumber: snapshot.docs[0]['productNumber'],
                                              )),
                                        );
                                      }).catchError((onError){
                                        showShortToast('لم يعد متوفر هذا المنتج حاليا');
                                      }) ;// end query
                                    },// end on tap
                                  ),
                                  Divider(color: Colors.black.withOpacity(0.5)),
                                ],
                              ),
                            );
                          }
                          );
                    } else {
                      return Center(child: Text("لم يتم إضافة منتجات بعد"),);
                    }
                  },
           );}
              );
  }
  void showShortToast(String meg) {
    Fluttertoast.showToast(
        msg: "$meg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.withOpacity(0.5),
        textColor: Colors.black,
        fontSize: 16.0
    );
  }
}
