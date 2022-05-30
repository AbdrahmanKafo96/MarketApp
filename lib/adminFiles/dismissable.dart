import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketApp/adminFiles/ViewProduct.dart';
import 'package:marketApp/adminFiles/orders.dart';
import 'package:marketApp/adminFiles/viewAccounts.dart';
import 'package:marketApp/widget/checkInternet.dart';

class DismissibleApp extends StatefulWidget {
  @override
  _DismissibleAppState createState() => new _DismissibleAppState();
}

class _DismissibleAppState extends State<DismissibleApp> {
  // List<String> _values = ['One', 'Two', 'Three', 'Four', 'Five'];
  var colorVar=Colors.grey.withOpacity(0.5);
  @override
  Widget build(BuildContext context) {
    checkInternetConnectivity(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('إشعارات'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),

        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Notices').orderBy('date',descending: true)
              //.where("readState", isEqualTo:'unRead')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            if(snapshot.hasError)
              return Center(child: Text("هناك خطاء في النظام يرجاء التواصل مع المسؤول"));
            if(snapshot.hasData && snapshot.data.docs.length>0)
            return ListView.separated(
                itemCount: snapshot.data.docs.length,
                padding: const EdgeInsets.all(5.0),
                separatorBuilder: (context, index) => Divider(
                      color: Colors.black,
                    ),

                itemBuilder: (context, index) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Dismissible(

                    key: UniqueKey(),
                      background: Container(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.delete, color: Colors.white),
                              Text('حذف العنصر',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),

                      confirmDismiss: (DismissDirection direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: AlertDialog(
                                title: const Text("تأكيد الحذف"),
                                content: const Text(
                                    "هل تود حذف هذا الإشعار؟"),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('Notices')
                                            .doc(snapshot.data.docs[index].id.toString())
                                            .delete()
                                            .then((value) {
                                          print("the record is deleted");
                                        });
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text("حذف")),
                                  FlatButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text("إلغاء"),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      // onDismissed: (DismissDirection direction) {
                      //   if (direction == DismissDirection.startToEnd) {
                      //     print("Add to favorite");
                      //   } else {
                      //     print('Remove item');
                      //   }
                      //
                      //   setState(() {
                      //     _values.removeAt(index);
                      //   });
                      // },

                      // ملاحظة هل يبي نمسحه بعد ما يقراها او لا

                      child: Column(
                        children: [
                          Container(
                            color:snapshot.data.docs[index]['adminRead']=='unRead'?
                            colorVar:Colors.white12,
                            child: ListTile(
                              onTap: (){
                                if(snapshot.data.docs[index]['adminRead']=='unRead')
                                { FirebaseFirestore.instance
                                    .collection('Notices')
                                    .doc(snapshot.data.docs[index].id
                                    .toString())
                                    .update({
                                  'adminRead': "Read",
                                })
                                    .then((value) => print("User Updated"))
                                    .catchError((error) =>
                                    print(
                                        "Failed to update user: $error"));
                                }

                                if(snapshot.data.docs[index]['NoticesNumber']==1)
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewAccounts(
                                          accountState: 'unaccept',
                                        )),
                                  );
                                }
                                if(snapshot.data.docs[index]['NoticesNumber']==2){
                                  var prod= new ViewProduct();

                                  prod.setProductNum=snapshot.data.docs[index]['productNumber'];
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => prod),
                                  );}

                                if(snapshot.data.docs[index]['NoticesNumber']==3)
                                {
                                  String sellerID=snapshot.data.docs[index]['sellerID'];
                                  String buyerID=snapshot.data.docs[index]['buyerID'];

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Order(sellerID: sellerID,buyerID: buyerID,)),
                                  );
                                }
                              },// end ontap,
                              //ملاحظة يمكن اضافة رقم الاشعار لتحديد نوع الاشعار
                              leading: Icon(
                                snapshot.data.docs[index]['NoticesNumber']==2?Icons.add_shopping_cart:Icons.person, size: 50 ,color: Colors.green,),
                              title: Text(snapshot.data.docs[index]['NoticesName'] ,style: TextStyle(fontWeight: FontWeight.bold),),
                              subtitle: Text(snapshot.data.docs[index]['NoticesMessage']),
                            ),

                          ),
                        //  Divider(color: Colors.grey,)
                        ],
                      ),
                    ),
                  );
                });
            else return Center(
            child:  Text("لا توجد بيانات لك للعرض  "),
            );
          }
        ),
      ),
    );
  }
}
