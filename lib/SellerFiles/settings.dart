import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketApp/SellerFiles/ContactUs.dart';
import 'package:marketApp/SellerFiles/marketInfo.dart';
import 'package:marketApp/SellerFiles/aboutUs.dart';


class SettingPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
          automaticallyImplyLeading: false,
              title: Text("الإعدادت" ,style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
        body:  Container(margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(10),
            
            height: MediaQuery.of(context).size.height/2,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(1.0, 1.0),
                            blurRadius: 4.0,
                            spreadRadius: 0.1,
                            color: Colors.black.withOpacity(0.5)
                        ),
                      ],
                      borderRadius:BorderRadius.all(Radius.circular(5.0)) ,
                      border: Border.all(color:  Color(0xFF242b3b) )
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: FlatButton.icon(icon: Icon(Icons.account_circle ,color: Colors.blueAccent,),
                    label: Text("حساب المستخدم" ,style: TextStyle(fontWeight: FontWeight.bold),),
                    highlightColor: Color(0xFF242b3b).withOpacity(0.5),

                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MarketInfo()),
                      );
                    },
                    color: Colors.white,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(1.0, 1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.1,
                          color: Colors.black.withOpacity(0.5)
                        ),
                      ],
                      border: Border.all(color:Color(0xFF242b3b) ),
                      borderRadius:BorderRadius.all(Radius.circular(5.0))
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: FlatButton.icon(icon: Icon(Icons.supervisor_account,color: Colors.grey),
                    label: Text("عن التطبيق" ,style: TextStyle(fontWeight: FontWeight.bold),),
                    highlightColor:Color(0xFF242b3b).withOpacity(0.5),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AboutUS()
                        ),
                      );
                    },
                    color: Colors.white,
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(color: Colors.white,
                //       boxShadow: [
                //         BoxShadow(
                //             offset: const Offset(1.0, 1.0),
                //             blurRadius: 4.0,
                //             spreadRadius: 0.1,
                //             color: Colors.black.withOpacity(0.5)
                //         ),
                //       ],
                //       border: Border.all(color:Color(0xFF242b3b) ),
                //       borderRadius:BorderRadius.all(Radius.circular(5.0))
                //   ),
                //   width: MediaQuery.of(context).size.width,
                //   child: FlatButton.icon(icon: Icon(Icons.contact_phone,color: Colors.green),
                //     label: Text("تواصل مع مطور التطبيق" ,style: TextStyle(fontWeight: FontWeight.bold),),
                //     highlightColor:Color(0xFF242b3b).withOpacity(0.5),
                //
                //     onPressed: (){
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => Contactus()
                //         ),
                //       );
                //     },
                //     color: Colors.white,
                //   ),
                // ),
                Container(
                  decoration: BoxDecoration(color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(1.0, 1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.1,
                          color: Colors.black.withOpacity(0.5)
                      ),
                    ],
                      border: Border.all(color:Color(0xFF242b3b) ),
                      borderRadius:BorderRadius.all(Radius.circular(5.0)) ,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: FlatButton.icon(icon: Icon(Icons.language,color: Colors.grey),
                    label: Text("اللغة العربية المتوفرة حاليا"),

                    highlightColor:Color(0xFF242b3b).withOpacity(0.5),

                    color: Colors.white,
                  ),
                ),

              ],

          ),
        )
        )
    );
  }
}
