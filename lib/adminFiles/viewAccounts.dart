import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marketApp/adminFiles/AccoutPage.dart';
import 'package:marketApp/widget/checkInternet.dart';

 class ViewAccounts extends StatefulWidget {
   String accountState;
   ViewAccounts({this.accountState});
   @override
   _ViewAccountsState createState() => _ViewAccountsState();
 }

 class _ViewAccountsState extends State<ViewAccounts> {
   @override
   Widget build(BuildContext context) {
     checkInternetConnectivity(context);
     return  Scaffold(
       appBar: AppBar(
         title: Text("مستخدمين النظام",style: TextStyle(fontWeight: FontWeight.bold),),
         leading: IconButton(
           icon: Icon(Icons.arrow_back, color: Colors.white),
           onPressed: () => Navigator.of(context).pop(),
         ),
       ),
       body: StreamBuilder(
         stream:FirebaseFirestore.instance
           .collection('users')
           .where("AccountState", isEqualTo: widget.accountState).snapshots(),
         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
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
             return ListView.builder(
                 padding: EdgeInsets.all(10),
                 itemCount: snapshot.data.docs.length,
                 itemBuilder: (context, index) {

                   return Directionality(
                     textDirection: TextDirection.rtl,
                     child: InkWell(
                       onTap: (){
                         AccountPage user=new AccountPage( );
                         user.setId=snapshot.data.docs[index]['userid'].toString();

                         Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) => user),
                         );
                       },
                       child: Card(

                         elevation: 10.0,
                         clipBehavior: Clip.antiAlias,
                         child: Row(
                           mainAxisAlignment:MainAxisAlignment.start,
                           children: [
                           Padding(padding: EdgeInsets.all(1),child: Icon(Icons.person ,size: 50,color: Colors.blueAccent,)),
                             Expanded (
                             child:
                               Container(color: Colors.grey[50].withOpacity(0.6),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                   Text('اسم المستخدم: ${snapshot.data.docs[index]['username']}',),
                                   Text('رقم الهاتف: ${snapshot.data.docs[index]['phonenumber']}'),
                                   Text('الدولة: ${snapshot.data.docs[index]['country']}'),
                             ],),
                               ),
                           )
                           ,Row(
                              children: [
                                if(this.widget.accountState!="accept")
                               IconButton(tooltip: 'مقبول'
                                   ,icon: Icon(Icons.assignment_turned_in,
                                 color: Colors.green,) , onPressed:(){
                                   FirebaseFirestore.instance.collection('users')
                                     .doc( snapshot.data.docs[index].id.toString()).update({
                                   'AccountState':"accept",
                                 });
                                    }   ),
                               IconButton(tooltip: "غير مقبول",icon: Icon(Icons.clear,color: Colors.red,)
                                   , onPressed: (){
                                     showDialog(
                                         context: context,
                                         builder: (context) {
                                           return AlertDialog(
                                             title: Text("عملية تعطيل الحساب" ,textDirection: TextDirection.rtl,
                                               style: TextStyle(fontWeight: FontWeight.bold),),
                                             content: Text("هل انت متأكد من تعطيل هذا المستخدم" ,textDirection: TextDirection.rtl,),
                                             actions: <Widget>[
                                               FlatButton(

                                                 child: Text('نعم'  ),
                                                 onPressed: () {

                                                   FirebaseFirestore.instance.collection('users')
                                                       .doc( snapshot.data.docs[index].id.toString()).update({
                                                     'AccountState':"unaccept",
                                                   });
                                                   Navigator.of(context).pop();
                                                 },color: Colors.red,
                                               ),

                                               FlatButton(
                                                 child: Text('اغلاق'),
                                                 onPressed: () {
                                                   Navigator.of(context).pop();
                                                 },
                                               )
                                             ],
                                           );
                                         }
                                     );
                                   }),
                             ],
                             )
                         ],),
                       ),
                     ),
                   );
                 });
           else return Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text("لا يوجد مستخدمين جدد حاليا في النظام"),
                 Icon(Icons.clear   ,)
               ],
             ),
           );
         },
       )
     );
   }

 }

