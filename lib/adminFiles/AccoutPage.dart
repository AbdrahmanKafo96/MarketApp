import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marketApp/widget/checkInternet.dart';

class AccountPage extends StatefulWidget {
  String _id = "";

  String get getId => _id;

  set setId(String value) {
    _id = value;
  }

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    print(widget.getId);
  }

  @override
  Widget build(BuildContext context) {
    checkInternetConnectivity(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('بيانات المستخدم' ,style: TextStyle(fontWeight: FontWeight.bold),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('marketData')
              .where('userid', isEqualTo: widget.getId)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {


            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError)
              return Center(
                  child: Text("هناك خطاء في النظام يرجاء التواصل مع المسؤول"));

            else if (snapshot.connectionState == ConnectionState.none) {
              return Text("No data");
            }
            if (snapshot.hasData &&snapshot.data.docs.length>0 ) {
              var marketDocument = snapshot.data.docs;

              return ListView.builder(
                itemCount: snapshot.data.docs.length ,
                itemBuilder: (context, index) {

                  String streetNumber=marketDocument[index]["streetNumber"];
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              CircleAvatar(
                                foregroundColor: Colors.green,
                                backgroundImage: NetworkImage(
                                    "${marketDocument[index]["imageUri"]}"),
                                radius: 80,
                              ),
                              // Text(
                              //   "${marketDocument[index]["streetNumber"]} ",
                              //   style: TextStyle(fontWeight: FontWeight.bold),
                              // ),

                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.grey, spreadRadius: 1),
                            ],
                          ),
                          width: MediaQuery.of(context).size.width,
                           height: MediaQuery.of(context).size.height / 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Container(
                              child: Column(
                                children: [
                                  CustomContainer(
                                      icon: Icons.local_mall,
                                      st1: "اسم المحل:",
                                      st2:
                                          '${marketDocument[index]["marketName"].toString()}'),
                                  Divider(
                                    color: Colors.blueGrey,
                                  ),
                                  CustomContainer(
                                      icon: Icons.location_city,
                                      st1: "المنطقة:",
                                      st2:
                                          '${marketDocument[index]["countrySelected"]}'),
                                  Divider(
                                    color: Colors.blueGrey,
                                  ),
                                  //  CustomContainer(icon: Icons.location_city,st1: "رقم الشارع" , st2: '${marketDocument[index]["streetNumber"]}'),
                                  // Divider(color: Colors.blueGrey,),

                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('users')
                                          .where('userid', isEqualTo: widget.getId)
                                          .snapshots(),
                                      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (snapshot.data == null) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                        if (snapshot.hasError)
                                          return Center(
                                              child: Text(
                                                  "هناك خطاء في النظام يرجاء التواصل مع المسؤول"));

                                        if (snapshot.connectionState ==
                                            ConnectionState.none) {
                                          return Text("No data");
                                        }
                                        if (snapshot.hasData ) {
                                          var userDocument = snapshot.data.docs;
                                          return Column(
                                            children: [
                                              CustomContainer(
                                                  icon:
                                                      Icons.person_pin_outlined,
                                                  st1: "اسم البائع:",
                                                  st2:
                                                      '${userDocument[index]["username"]}'),
                                              Divider(
                                                color: Colors.blueGrey,
                                              ),
                                              CustomContainer(
                                                  icon: Icons.alternate_email,
                                                  st1: "الإيميل:",
                                                  st2:
                                                      '${userDocument[index]["useremail"]}'),
                                              Divider(
                                                color: Colors.blueGrey,
                                              ),
                                              CustomContainer(
                                                  icon: Icons.phone,
                                                  st1: "رقم البائع:",
                                                  st2:
                                                      '${userDocument[index]["phonenumber"]}'),
                                              Divider(
                                                color: Colors.blueGrey,
                                              ),
                                              CustomContainer(
                                                  icon: Icons.location_pin,
                                                  st1: "الدولة:",
                                                  st2:
                                                      '${userDocument[index]["country"]}'),
                                              Divider(
                                                color: Colors.blueGrey,
                                              ),
                                              CustomContainer(
                                                  icon: Icons.map_outlined,
                                                  st1: "رقم الشارع:",
                                                  st2:' $streetNumber'
                                                       ),

                                            ],
                                          );
                                        }
                                        return Center(
                                            child: CircularProgressIndicator());
                                      })
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            } else
              return Center(
                child: Text("لم يستكمل البائع  بيانات المحل"),
              );
          }),
    );
  }

  // ignore: non_constant_identifier_names
  Widget CustomContainer(
      {Widget child, IconData icon, String st1, String st2}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.black12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon),
          Text(
            " $st1 ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(" $st2"),
        ],
      ),
    );
  }
}
