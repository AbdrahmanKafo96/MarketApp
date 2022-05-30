import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:marketApp/Buyer/itemView.dart';
import 'package:marketApp/provider/userProvider.dart';
import 'package:marketApp/widget/checkInternet.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';

class ViewProducts extends StatefulWidget {
  String collName, catgsName, filedName;

  ViewProducts({this.collName, this.catgsName, this.filedName});

  @override
  _ViewProductsState createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {
  int minPrice, maxPrice;
  Color mcolor = Colors.white;
  String size, value;

  List<S2Choice<String>> clothes = [
    S2Choice<String>(value: 'XS', title: 'XS'),
    S2Choice<String>(value: 'S', title: 'S'),
    S2Choice<String>(value: 'M', title: 'M'),
    S2Choice<String>(value: 'L', title: 'L'),
    S2Choice<String>(value: 'XL', title: 'XL'),
    S2Choice<String>(value: 'XXL', title: 'XXL'),
    S2Choice<String>(value: 'XXXL', title: 'XXXL'),
  ];
  List<S2Choice<String>> agesChild = [
    S2Choice<String>(value: '0-4mos', title: '0-4mos'),
    S2Choice<String>(value: '6 mos', title: '6 mos'),
    S2Choice<String>(value: '8 mos', title: '8 mos'),
    S2Choice<String>(value: '10-12 mos', title: '10-12 mos'),
    S2Choice<String>(value: '1', title: '1'),
    S2Choice<String>(value: '1.5', title: '1.5'),
    S2Choice<String>(value: '2', title: '2'),
    S2Choice<String>(value: '2.5', title: '2.5'),
    S2Choice<String>(value: '3', title: '3'),
    S2Choice<String>(value: '3.5', title: '3.5'),
    S2Choice<String>(value: '4', title: '4'),
    S2Choice<String>(value: '5', title: '5'),
    S2Choice<String>(value: '5.5', title: '5.5'),
    S2Choice<String>(value: '6', title: '6'),
    S2Choice<String>(value: '6.5', title: '6.5'),
    S2Choice<String>(value: '7', title: '7'),
    S2Choice<String>(value: '7.5', title: '7.5'),
    S2Choice<String>(value: '8', title: '8'),
    S2Choice<String>(value: '9to10', title: '9to10'),
    S2Choice<String>(value: '11to12', title: '11to12'),
  ];

  List<S2Choice<String>> womensShoeSizes = [
    S2Choice<String>(value: '35', title: '35'),
    S2Choice<String>(value: '35.5', title: '35.5'),
    S2Choice<String>(value: '36', title: '36'),
    S2Choice<String>(value: '37', title: '37'),
    S2Choice<String>(value: '37.5', title: '37.5'),
    S2Choice<String>(value: '38', title: '38'),
    S2Choice<String>(value: '38.5', title: '38.5'),
    S2Choice<String>(value: '39', title: '39'),
    S2Choice<String>(value: '40', title: '40'),
    S2Choice<String>(value: '41', title: '41'),
    S2Choice<String>(value: '42', title: '42'),
  ];
  List<S2Choice<String>> mansShoeSizes = [
    S2Choice<String>(value: '39', title: '39'),
    S2Choice<String>(value: '40', title: '40'),
    S2Choice<String>(value: '41', title: '41'),
    S2Choice<String>(value: '42', title: '42'),
    S2Choice<String>(value: '43', title: '43'),
    S2Choice<String>(value: '43.5', title: '43.5'),
    S2Choice<String>(value: '44', title: '44'),
    S2Choice<String>(value: '44.5', title: '44.5'),
    S2Choice<String>(value: '45', title: '45'),
    S2Choice<String>(value: '46', title: '46'),
  ];
  String sex;
  List<S2Choice<String>> sexList = [
    S2Choice<String>(value: 'نساء', title: 'نساء'),
    S2Choice<String>(value: 'رجال', title: 'رجال'),
    S2Choice<String>(value: 'اطفال', title: 'اطفال'),
  ];

  String catg;
  List<S2Choice<String>> catgList=[
    S2Choice<String>(value: 'ملابس', title: 'ملابس'),
    S2Choice<String>(value: 'احذية', title: 'احذية'),
    S2Choice<String>(value: 'اخرى', title: 'اخرى'),
  ];

  List<S2Choice<String>> childrenAges=[
  S2Choice<String>(value: "0-1", title: '0-1'),
  S2Choice<String>(value: "1-2", title: '1-2'),
  S2Choice<String>(value: "2-3", title: '2-3'),
  S2Choice<String>(value: "3-4", title: '3-4'),
  S2Choice<String>(value: "4-5", title: '4-5'),
  S2Choice<String>(value: "5-6", title: '5-6'),
  S2Choice<String>(value: "6-7", title: '6-7'),
  S2Choice<String>(value: "7-8", title: '7-8'),
  S2Choice<String>(value: "8-9", title: '8-9'),
  S2Choice<String>(value: "9-10", title: '9-10'),
  S2Choice<String>(value: "10-11", title: '10-11'),
  S2Choice<String>(value: "11-12", title: '11-12'),
  S2Choice<String>(value: "12-13", title: '12-13'),
  S2Choice<String>(value: "13-14", title: '13-14'),
  S2Choice<String>(value: "14-15", title: '14-15'),
  S2Choice<String>(value: "15-16", title: '15-16'),
  S2Choice<String>(value: "16-17", title: '16-17'),
  S2Choice<String>(value: "17-18", title: '17-18'),
  S2Choice<String>(value: "19-20", title: '19-20'),
  S2Choice<String>(value: "20-21", title: '20-21'),
  S2Choice<String>(value: "21-22", title: '21-22'),
  S2Choice<String>(value: "22-23", title: '22-23'),
  S2Choice<String>(value: "23-24", title: '23-24'),
  S2Choice<String>(value: "2", title: '2'),
  S2Choice<String>(value: "3", title: '3'),
  S2Choice<String>(value: "4", title: '4'),
  S2Choice<String>(value: "5", title: '5'),
  S2Choice<String>(value: "6", title: '6'),
  S2Choice<String>(value: "7", title: '7'),
  S2Choice<String>(value: "8", title: '8'),
  S2Choice<String>(value: "9", title: '9'),
  S2Choice<String>(value: "10", title: '10'),
  S2Choice<String>(value: "11", title: '11'),
  S2Choice<String>(value: "12", title: '12'),
  S2Choice<String>(value: "13", title: '13'),
  S2Choice<String>(value: "14", title: '14'),
  S2Choice<String>(value: "15", title: '15'),
  S2Choice<String>(value: "16", title: '16'),
  S2Choice<String>(value: "17", title: '17'),
  ];

  @override
  Widget build(BuildContext context) {
    checkInternetConnectivity(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("المنتجات" , style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt_rounded, color: Colors.white),
            onPressed: () {
              displayBottomSheet(context);
            },
          ),
        ],
       ),
      body: Directionality(
        child: getViewProducts(context),
        textDirection: TextDirection.rtl,
      ),
    );
  }

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
              builder: (context,mystate)
          {
           return Consumer<Prov>(
              builder: (context, myProv, child) {
                return Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.4,
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(

                                  child: Container(
                                    //      width: MediaQuery.of(context).size.width *0.5,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        setState(() {
                                          minPrice = int.parse(value);
                                        });
                                      },
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.attach_money),
                                          labelText: 'الحد الادنى'),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12,),
                                Expanded(

                                  child: Container(
                                    //  width: MediaQuery.of(context).size.width *0.5,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        mystate(() {
                                          maxPrice = int.parse(value);
                                        });
                                      },
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.attach_money),
                                          labelText: 'الحد الاعلى'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SmartSelect<String>.single(
                                placeholder: 'الصنف حسب النوع',
                                title: 'النوع' ,
                                value: catg,
                                choiceItems: catgList,
                                onChange: (state) {
                                  mystate(() {
                                    catg = state.value;
                                    myProv.myColliction = getResult();
                                  });
                                }),


                            SmartSelect<String>.single(
                                placeholder: 'الصنف حسب القسم',
                                title: 'القسم',
                                value: sex,
                                choiceItems: sexList,
                                onChange: (state) {
                                  mystate(() {

                                    sex = state.value;
                                    print(sex);
                                    myProv.myColliction = getResult();
                                  });
                                }
                            ),

                            SmartSelect<String>.single(
                                placeholder: 'صنف حسب القياس',
                                title: 'القياس',
                                value: size,
                                choiceItems:
                                myProv.myColliction = getResult() ,
                                onChange: (state) =>
                                    mystate(() => size = state.value))
                          ]),
                        ),
                      )),
                ]);
              },
            );
          });
        });
  }
   List  getResult(){
    List list;
  return   list=(sex =='نساء' || sex =='رجال')&&(catg=='ملابس'||catg=='اخرى')?clothes

       :(sex =='نساء' )&&(catg=='احذية')?womensShoeSizes:
   (sex =='رجال' )&&(catg=='احذية')?mansShoeSizes:

   (sex =='اطفال' )&&(catg=='ملابس'||catg=='اخرى')?childrenAges:
   (sex =='اطفال' )&&(catg=='احذية')?agesChild :clothes;
 }
  getViewProducts(BuildContext context) {
    return Consumer<Prov>(
      builder: (context, myProv, child) {
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(widget.collName)
              .where(widget.filedName, isEqualTo: widget.catgsName)
              .where("priceProduct", isLessThanOrEqualTo: maxPrice)
              .where("priceProduct", isGreaterThanOrEqualTo: minPrice)
              .where("state", isEqualTo: sex)
              .where("sizes", arrayContains: size)
               .where('productState' ,isEqualTo: 'Accept')
              .orderBy("priceProduct", descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData || snapshot.data.docs == null)
              return Center(
                child: Center(
                  child: Text("لم يتم إضافة منتجات بعد"),
                ),
              );

            if (snapshot.hasError)
              return Center(
                child: Center(
                  child: Text("تحقق من اتصالك بالانترنت."),
                ),
              );

            if (snapshot.hasData && snapshot.data.docs.length > 0)
              return GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
// imgs  === > pro name  == > brand  =>> price >>   colors =>> quantit == > size
                      List listImgs = List();
                      listImgs = snapshot.data.docs[index]['image'];
                      List<NetworkImage> networkImgs = List<NetworkImage>();

                      for (int i = 0; i < listImgs.length; i++) {
                        networkImgs.add(NetworkImage(listImgs[i]));
                      }
                      List sizes = List();
                      sizes = snapshot.data.docs[index]['sizes'];

                      List colors = List();
                      colors = snapshot.data.docs[index]['colors'];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ItemView(
                                  productName: snapshot.data.docs[index]
                                      ['productName'],
                                  brandProduct: snapshot.data.docs[index]
                                      ['BrandProduct'],
                                  priceProduct: snapshot.data.docs[index]
                                      ['priceProduct'],
                                  listImgs: networkImgs,
                                  sizes: sizes,
                                  colors: colors,
                                  sellerID: snapshot.data.docs[index]['userid'],
                                  productNumber: snapshot.data.docs[index]
                                      ['productNumber'],
                                )),
                      );
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Image.network(
                              snapshot.data.docs[index]['image'][0],

                               width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Divider(
                            height: 5,
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // IconButton(
                                //     icon: Icon(
                                //       Icons.add_shopping_cart,
                                //       color: Colors.green,
                                //     ),
                                //     onPressed: () {}),
                                Text(
                                  " \$${snapshot.data.docs[index]['priceProduct']}",
                                  style: TextStyle(
                                    color: Colors.red,
                                    wordSpacing: 1,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      elevation: 2.0,
                    ),
                  );
                },
              );
            else {
              return Center(
                child: Text("لم يتم إضافة منتجات بعد"),
              );
            }
          },
        );
      },
    );
  }
}
