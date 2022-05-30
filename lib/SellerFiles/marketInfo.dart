import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketApp/widget/checkInternet.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';


class MarketInfo extends StatefulWidget {
  @override
  _MarketInfoState createState() => _MarketInfoState();
}

class _MarketInfoState extends State<MarketInfo> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  File _image;
  final picker = ImagePicker();
  String _uri, marketName, streetNumber, countrySelected ;
  var result  ;
  var marketNameCon= TextEditingController();
  var streetNumberCon= TextEditingController();
  var countrySelectedCon= TextEditingController();

  bool state=false;
  String idPost;

  Future<void> getUID() async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    String uid=pref.getString('uid');
    result = uid ;
  }
   @override
  void initState() {
    super.initState();
    getUID().then((value) => checkState());

  setState(() {

    print(state);
  });
  }

  @override
  Widget build(BuildContext context) {
    checkInternetConnectivity(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(' بيانات المحل',style: TextStyle(fontWeight: FontWeight.bold),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed:  () {
              var form=_formKey.currentState;
              if(form.validate()) {
                if (state == false)
                  saveData(context);
                else
                  updateForm(context);
              } else{
                _scaffoldKey.currentState.showSnackBar( SnackBar(
                  content: Text('من فضلك ادخل بيانات النموذج بالكامل',
                    //textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,),
                  backgroundColor: Colors.red,
                ) );
              }
            } ,
            icon: Icon(state==true?Icons.edit:Icons.save ,color: Colors.white,),
          )
        ],
       ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin:EdgeInsets.all(10) ,
          padding:EdgeInsets.all(10) ,

            child: SingleChildScrollView(
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap:pickImage ,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [BoxShadow(blurRadius: 10, color: Colors.grey, spreadRadius: 5)],
                              ),
                              child: CircleAvatar(child:RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "تحميل صورة المحل",style: TextStyle(color: Colors.black,fontSize: 12)
                                    ),
                                    WidgetSpan(
                                      child: Icon(Icons.perm_media_sharp ),
                                    ),

                                  ],
                                ),
                              ),
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.green,
                                backgroundImage: _image == null ?  state==true ?NetworkImage(_uri)
                                   :null : FileImage(_image),
                                radius: 80,
                              ),
                            ),
                          ),
                          // GestureDetector(
                          //     onTap: pickImage,
                          //     child: Icon(Icons.perm_media_sharp,color: Colors.green,))
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //     Builder(
                      //       builder: (context) => RaisedButton(
                      //         onPressed: () {
                      //          // uploadImage(context);
                      //         },
                      //        // child: Text('تحميل صورة المحل'),
                      //       ),
                      //     ),]
                      //     )
                      //
                    SizedBox(
                        height: 12,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: marketNameCon,
                              textAlign: TextAlign.right,
                              keyboardType: TextInputType.text,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter
                                    .singleLineFormatter
                              ],
                              onChanged: (value) {
                                marketName=value;
                              },
                              validator: (value) => value.isEmpty
                                  ? 'اسم المحل مطلوب'
                                  : null,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.drive_file_rename_outline,
                                    color: Colors.teal,
                                  ),
                                  labelText: "اسم المحل",
                                  hintText: "ادخل اسم المحل"),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                                TextFormField(
                                  controller: streetNumberCon,
                                   textAlign: TextAlign.right,
                                   keyboardType: TextInputType.text,
                                   inputFormatters: <TextInputFormatter>[
                                     FilteringTextInputFormatter
                                         .singleLineFormatter
                                   ],
                                   onChanged: (value) {
                                     streetNumber=value;
                                   },
                                   validator: (value) => value.isEmpty
                                       ? 'رقم شارع المحل مطلوب'
                                       : null,
                                   decoration: InputDecoration(
                                       prefixIcon: Icon(
                                         Icons.map_outlined,
                                         color: Colors.teal,
                                       ),
                                       labelText: "رقم شارع المحل",
                                       hintText: "ادخل رقم شارع المحل"),
                                 ),
                            SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              controller: countrySelectedCon ,
                              textAlign: TextAlign.right,
                              keyboardType: TextInputType.text,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter
                                    .singleLineFormatter
                              ],
                              onChanged: (value) {
                                countrySelected =value;
                              },
                              validator: (value) => value.isEmpty
                                  ? 'اسم الدولة مطلوب'
                                  : null,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.map_outlined,
                                    color: Colors.teal,
                                  ),
                                  labelText: "الدولة",
                                  hintText: "ادخل اسم الدولة"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),

                      //updateCountry!=null?
                      // Row(
                      //   children: [
                      //     Text("الدولة المختارة سابقا :" ,style: TextStyle(
                      //       fontWeight: FontWeight.bold
                      //     ),),
                      //     Text(updateCountry ,style: TextStyle(
                      //
                      //     ),),
                      //     Divider(color: Colors.grey,)
                      // ],
                      // ):SizedBox.shrink(),
                      SizedBox(height: 12,),



                   ],
                  ),
            ),

        ),
      )
    );
  }


  void pickImage() async {
                var pickedFile = await picker.getImage(source: ImageSource.gallery);

                setState(() {
                  if (pickedFile != null)
                  _image =File(pickedFile.path);
                    print(pickedFile.path);
                });

              }

           Future<void>  uploadImage(BuildContext context) async {
              try {
                _scaffoldKey.currentState.showSnackBar( SnackBar(
                  content: Text('عملية التعديل قيد الانتظار', textDirection: TextDirection.rtl,),backgroundColor: Colors.green,
                ) );

                if(_uri !=null) {
                      FirebaseStorage.instance
                          .refFromURL(_uri)
                          .delete()
                          .catchError((e) => print(e));
                                 }

            if(  _image!=null) {
                    var ref = FirebaseStorage.instance.ref().child(p.basename(_image.path));
                    UploadTask uploadTask = ref.putFile(_image);
                    TaskSnapshot taskSnapshot = await uploadTask;
                    String uri = await taskSnapshot.ref.getDownloadURL();
                    setState(() {
                      _uri = uri;
                    });
                          }
                       } catch (ex) {
                print(ex);
                _scaffoldKey.currentState.showSnackBar( SnackBar(
                  content: Text('حدثت مشكلة', textDirection: TextDirection.rtl,),backgroundColor: Colors.red,
                ) );
              }
              }

            Future<void>  saveData(BuildContext context)   async {
               try{
                 await uploadImage(context);

                 if (result != null  ) {

                   final firestoreInstance =    FirebaseFirestore.instance;
                   firestoreInstance.collection("marketData").doc().set({
                     'userid':result,
                     'countrySelected':countrySelected ,
                     'imageUri':_uri,
                     'marketName':marketName,
                     'streetNumber':streetNumber,
                   } );
                   _scaffoldKey.currentState.showSnackBar( SnackBar(
                     content: Text('تمت عملية الحفظ بنجاح', textDirection: TextDirection.rtl,),backgroundColor: Colors.green,
                   ) );

                 }// end if stm
               }catch(ex){
                 _scaffoldKey.currentState.showSnackBar( SnackBar(
                   content: Text('حدثت مشكلة', textDirection: TextDirection.rtl,),backgroundColor: Colors.red,
                 ) );
               }
  }
     checkState()   {
    print(result);
    // this method for check of state when you come to this page as saver or updater ...
    if(result !=null){
      var snapshots=   FirebaseFirestore.instance.collection('marketData')
           .where('userid', isEqualTo: result).snapshots();
           snapshots.first.then((value) {
             print(value.size);
              if(value.size==1) {
                state=true;
                idPost=value.docs.first.id;
                setDataForm(idPost);
              }
           });
    }
  }
  void setDataForm(String value) {
    FirebaseFirestore.instance.collection('marketData').doc(value)
        .get().then((documentSnapshot)
     {
       marketNameCon.text=documentSnapshot["marketName"];
       countrySelectedCon.text=documentSnapshot["countrySelected"];

       streetNumberCon.text=documentSnapshot["streetNumber"];
          setState(() {
            _uri=documentSnapshot['imageUri'] ;
          });

     }
    );
  }
    Future<void> updateForm(BuildContext context) async {

    await uploadImage(context);
    FirebaseFirestore.instance.collection('marketData').doc(idPost)
        .update({

     
     'imageUri':_uri,
      'marketName':marketNameCon.text,
      'streetNumber':streetNumberCon.text,
      'countrySelected':countrySelectedCon.text,
    });
    _scaffoldKey.currentState.showSnackBar( SnackBar(
      content: Text('تمت عملية التحديث بنجاح', textDirection: TextDirection.rtl,)
      ,backgroundColor: Colors.green,
    ) );
  }

}
