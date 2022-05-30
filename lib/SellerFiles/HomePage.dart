import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marketApp/DartFiles/HomeScreen.dart';
import 'package:marketApp/SellerFiles/marketInfo.dart';
import 'package:marketApp/SellerFiles/addProduct.dart';
import 'package:marketApp/SellerFiles/notifications.dart';
import 'package:marketApp/widget/checkInternet.dart';
import 'package:badges/badges.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //String userUid ;
  Product product =Product();
  int number ;
  List listNumbers = [];
  List imgLinks = [];

  SharedPreferences pref;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
     getUpdate() {
       if(pref.getString('uid')!=null)
    FirebaseFirestore.instance.collection('Notices')
        .where("NoticesNumber", isEqualTo:3)
      .where('readState',isEqualTo: 'unRead')
        .where("sellerID", isEqualTo:pref.getString('uid'))
        .get() .then((value) {
      setState(() {
        number= value.docs.length ;
        print(number);
      });
    });

  }
  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) => setState(() {
          pref = prefs;
          heHaveDataStore(context);
          getUpdate();
        }));


  }
// جزئية الخاصة بتحقق من بيانات المحل هل البائع استكمل بيانات المحل ام لا
  heHaveDataStore(BuildContext context) {
    if (pref != null) {
      String uid = pref.getString('uid');

      if (uid != "") {
        FirebaseFirestore.instance
            .collection('marketData')
            .where('userid', isEqualTo: uid)
            .snapshots()
            .first
            .then((value) {
          int result = value.docs.length;

          if (result == 0) {
            return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      "استكمل بياناتك",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: const Text("من فضلك استكمل بيانات المحل"),
                    actions: <Widget>[

                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MarketInfo()),
                          );
                        },
                        child: const Text("نعم",
                            style: TextStyle(color: Colors.white)),
                        color: Colors.redAccent,
                      ),
                    ],
                  );
                });
          }
        });
      }
    }
    return SizedBox.shrink();
  }
// جزئية خاصة بالبحث....
  Future<void> userData(BuildContext context, String id) async {
    await FirebaseFirestore.instance
        .collection('products')
        .where('userid', isEqualTo: id)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                listNumbers.add(doc["productNumber"]);

              })
            });
  }

  @override
  Widget build(BuildContext context) {
    checkInternetConnectivity(context);
    return Scaffold(
      key: _scaffoldKey,

        appBar: AppBar(
          title: Text('الصفحة الرئيسية' ,style: TextStyle(fontWeight:FontWeight.bold ),),
          leading: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.remove('uid');
              pref.remove('email');
              pref.remove('pass');
              HomeScreen().singOut(context);
            },
          ),
          centerTitle: true,

          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  listNumbers.clear();
                  userData(
                      context, pref != null ? pref.getString('uid') : null);
                  showSearch(
                      context: context,
                      delegate: DataSearchSe(
                          listProNumber: listNumbers, imgLinks: imgLinks));
                }),
            Badge(

              badgeContent: Text('${number!=null?number:""}' ,style: TextStyle(color: Colors.white),),

              child: IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                      Navigator.push(context,
                      MaterialPageRoute(
                      builder: (context) => Notifications(pref.getString('uid'))),
                      );}
                   ),
            ),
          ],
        ),
        body:myLayout());
  }

  Widget myLayout( {String stm}){
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('products')
              .where('userid', isEqualTo: pref != null ? pref.getString('uid') : null)
              .where('productNumber', isEqualTo: stm)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // print('myProv.getUserId===${myProv.getUserId}');
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError)
              return Center(
                  child:
                  Text("هناك خطاء في النظام يرجاء التواصل مع المسؤول"));
            if (snapshot.hasData && snapshot.data.docs.length > 0)
              return GridView.builder(
                  cacheExtent:20.0 ,
                  //controller: ScrollController(initialScrollOffset: 20),
                 // physics: const AlwaysScrollableScrollPhysics (),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                      crossAxisCount:2),
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    String productNumber =
                    snapshot.data.docs[index]['productNumber'];
                    List result;
                    result = snapshot.data.docs[index]['image'];
                    String validLink = result[0].toString().replaceAll("[", "");
                    return Card(
                      elevation: 10.0,
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(

                        onTap: () {
                          print("it's clicked.");
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Image.network(
                                validLink,
                                fit: BoxFit.cover,
                               // height: 150.0,
                                width: MediaQuery.of(context).size.width,

                              //  width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(

                              //  width: MediaQuery.of(context).size.width,

                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  // Row(
                                  //   children: [
                                  // //    Text(' رقم المنتج: $productNumber', style: TextStyle(fontWeight: FontWeight.bold),),
                                  //   ],
                                  // ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.edit ,color: Colors.green,),
                                          onPressed: () {
                                            int price;
                                            String id,
                                                brand,
                                                productName,
                                                productQuantity,
                                                state,
                                                categorySelected,
                                                itemType;
                                            List colors;
                                            List sizes;

                                            product.setEditState = true;
                                            id = snapshot.data.docs[index].id.toString();
                                            colors = snapshot.data.docs[index]['colors'];
                                            productName = snapshot.data.docs[index]['productName'];
                                            productQuantity = snapshot.data.docs[index]['productQuantity'];
                                            sizes = snapshot.data.docs[index]['sizes'];
                                            state = snapshot.data.docs[index]['state'];
                                            price = snapshot.data.docs[index]['priceProduct'];
                                            brand = snapshot.data.docs[index]['BrandProduct'];
                                            categorySelected = snapshot.data.docs[index]['category'];

                                            itemType = snapshot.data.docs[index]['ItemType'];
                                            List links=snapshot.data.docs[index]['image'];
                                            product.setImgLinks=links ;
                                            product.setItemType=itemType;
                                            product.setIndex = id;
                                            product.setPriceProduct =
                                                price;
                                            product.setBrandProduct =
                                                brand;
                                            product.setMySizesFi = sizes;
                                            product.setProductNameFi =
                                                productName;
                                            product.setProductQuanFi =
                                                productQuantity;
                                            product.setProductNumberFi =
                                                productNumber;
                                            product.setUniformTypeFi =
                                                state;
                                            product.setSelectedFi = colors;
                                            product.setProdCategory =
                                                categorySelected;

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                  product),
                                            );
                                          }),
                                      IconButton(
                                        icon: Icon(Icons.delete,color: Colors.red,),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                  "حذف عنصر",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                content: const Text(
                                                    "هل تريد حذف العنصر من القائمة؟"),
                                                actions: <Widget>[
                                                  FlatButton(
                                                      onPressed: () {
                                                        Navigator.of(
                                                            context)
                                                            .pop(false);
                                                      },
                                                      child: const Text(
                                                        "لا",
                                                      )),
                                                  FlatButton(
                                                    onPressed: () {
                                                      FirebaseFirestore
                                                          .instance.collection('products').doc(snapshot.data
                                                          .docs[index].id.toString()).delete()
                                                          .then((value) {
                                                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                                                          content: Text(
                                                            'لقد قمت بحذف المنتج بنجاح',
                                                            textDirection: TextDirection.rtl,
                                                          ),
                                                          backgroundColor: Colors.green,
                                                        ));
                                                      }).catchError((error){
                                                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                                                          content: Text(
                                                            "حدث مشكلة في النظام",
                                                            textDirection: TextDirection.rtl,
                                                          ),
                                                          backgroundColor: Colors.red,
                                                        ));
                                                      });
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: const Text("حذف", style: TextStyle(color: Colors.white)), color: Colors.redAccent,
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),)
                          ],
                        ),
                      ),
                    );
                  });
            else
              return Center(
                child: Text("لا توجد بيانات لك للعرض قم بإضافة منتجاتك"),
              );
          }),
    );
  }

}

class DataSearchSe extends SearchDelegate<String> {
        List listProNumber, imgLinks;

        DataSearchSe({this.listProNumber, this.imgLinks});
        @override
        String get searchFieldLabel => 'ابحث بالرقم التسلسلي للمنتج:';
        @override
        List<Widget> buildActions(BuildContext context) {
          // action for appbar
          return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = "")];
        }

        @override
        Widget buildLeading(BuildContext context) {
      // icon leading
          return IconButton(
              icon: Icon(Icons.arrow_back ,color: Colors.black,),
              onPressed: () {
                close(context, null);
              });
        }

        @override
        Widget buildResults(BuildContext context) {
          // result search...

          return _HomePageState().myLayout(stm: query);
        }

        @override
        Widget buildSuggestions(BuildContext context) {
          //show when someone searchers for something...
          var searchList = query.isEmpty
              ? listProNumber
              : listProNumber
                  .where((element) => element.toString().startsWith(query))
                  .toList();
          return Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.builder(
                itemCount: searchList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                        //leading: Image.network('${imgLinks}'),
                        leading: Icon(Icons.shopping_cart_outlined),
                        title: Text("${searchList[index]}"),
                        onTap: () {
                          query = searchList[index];
                          showResults(context);
                        },
                  );
                }),
          );
        }
}
