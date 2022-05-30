import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marketApp/Buyer/ViewProducts.dart';
import 'package:marketApp/widget/checkInternet.dart';

class MarketsData extends StatefulWidget {
  @override
  _MarketsDataState createState() => _MarketsDataState();
}

class _MarketsDataState extends State<MarketsData> {
  @override
  Widget build(BuildContext context) {
    checkInternetConnectivity(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("المحلات" , style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
         leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Directionality(
        child: getViewMarkets(),
        textDirection: TextDirection.rtl,
      ),
    );
  }

  getViewMarkets() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("marketData").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data.docs == null)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (snapshot.hasError)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (snapshot.hasData && snapshot.data.docs.length >0)
          return GridView.builder(

            shrinkWrap: true,
            padding: EdgeInsets.all(10),
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: MediaQuery.of(context).size.width / 2,

                child:InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>ViewProducts(
                            collName: 'products',
                             filedName: 'userid',
                            catgsName: snapshot.data.docs[index]['userid'], )
                        // snapshot.data.docs[index]['category'].toString()
                      ),
                    );
                  },
                  child:  Card(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Image.network(  snapshot.data.docs[index]['imageUri'] ,

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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("${snapshot.data.docs[index]['marketName']}",
                                    style: TextStyle(

                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      wordSpacing: 1,
                                      fontSize: 12,
                                      letterSpacing: 1,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    elevation: 2.0,
                  ),
                )
              );
            },
          );
        else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
