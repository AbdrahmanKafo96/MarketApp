import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:marketApp/SellerFiles/sellerpage.dart';
import 'package:marketApp/widget/checkInternet.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_select/smart_select.dart';
import 'dataSource.dart';

// ignore: must_be_immutable
class Product extends StatefulWidget {
  bool _editState = false;
  String _index;
  String _productQuanFi;

  String _productNameFi;

  String _productNumberFi;
  String _uniformTypeFi;
  List _mySizesFi;

  List _selectedFi;

  String _prodCategory;
  int _priceProduct;
  String _brandProduct;
  String _itemType;

  String get getItemType => _itemType;

  set setItemType(String value) {
    _itemType = value;
  }

  String get getBrandProduct => _brandProduct;

  set setBrandProduct(String value) {
    _brandProduct = value;
  }

  int get getPriceProduct => _priceProduct;

  set setPriceProduct(int value) {
    _priceProduct = value;
  }

  String get getProdCategory => _prodCategory;

  set setProdCategory(String value) {
    _prodCategory = value;
  }

  bool get getEditState => _editState;

  set setEditState(bool value) {
    _editState = value;
  }

  String get getIndex => _index;

  set setIndex(String value) {
    _index = value;
  }

  String get getProductQuanFi => _productQuanFi;

  set setProductQuanFi(String value) {
    _productQuanFi = value;
  }

  String get getProductNameFi => _productNameFi;

  set setProductNameFi(String value) {
    _productNameFi = value;
  }

  String get getProductNumberFi => _productNumberFi;

  set setProductNumberFi(String value) {
    _productNumberFi = value;
  }

  String get getUniformTypeFi => _uniformTypeFi;

  set setUniformTypeFi(String value) {
    _uniformTypeFi = value;
  }

  List<String> get getMySizesFi => _mySizesFi.cast<String>().toList();

  set setMySizesFi(List value) {
    _mySizesFi = value;
  }

  List get getSelectedFi => _selectedFi;

  set setSelectedFi(List value) {
    _selectedFi = value;
  }
  List  _imgLinks;

  List  get getImgLinks => _imgLinks;

  set setImgLinks(List   value) {
    _imgLinks = value ;
  }

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  // String uniformType = "نساء";// for radio button
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int priceProduct;
  String productQuantity,
      productName = "",
      productBrand,
      productNumber; // for products
  List<Asset> images; //for img asset
  List<File> imageFile = List<File>(); //for files
  String _error = '';
  List<String> _mySizes; //for item sizes
  List<String> imgselectedURI; //collect for img links
  Map<String, bool> values = getColorsNames(); // map of colors list
  Map<String, bool> values2 = getCategoryNames();
  Map<String, Widget> valuesIcons = colorsOptions(); //map of colors options
  List<String> selected = List();
  String categorySelected, itemType;

  var productQuantityCon = TextEditingController();
  var productNameCon = TextEditingController();
  var productNumberCon = TextEditingController();
  var priceProductCon = TextEditingController();
  var productBrandCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    images = List<Asset>();
    collection = getResult();
    _mySizes = List();
    // ignore: unnecessary_statements
    widget.getEditState == true ? updateFields() : null;
    // for item size
    imgselectedURI = List();
  }
  List<String>  networksImage= List();
  updateFields() {
    productQuantityCon.text = widget.getProductQuanFi;
    productNameCon.text = widget.getProductNameFi;
    productNumberCon.text = widget.getProductNumberFi;
    sex = widget.getUniformTypeFi;
    _mySizes.addAll(widget.getMySizesFi);
    selected = widget.getSelectedFi.cast<String>().toList();
    catg = widget.getProdCategory;
    productBrandCon.text = widget.getBrandProduct;
    priceProductCon.text = widget.getPriceProduct.toString();
    typeCatgs = widget.getItemType;

    sizeSelected = _mySizes;

    networksImage=widget.getImgLinks.cast<String>().toList() ;

  }


  // to load imgs from gallery
  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = '';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 250,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;
    setState(() {
      resultList.forEach((imageAsset) async {
        final filePath =
            await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);
        File tempFile = File(filePath);
        if (tempFile.existsSync()) {
          imageFile.add(tempFile);
          _error = error;
        }
      });
      images = resultList;
    });
  }

  //تتبع البوتم شيت الخاص بعرض الالوان
  bool stateFun(String key) {
    for (int i = 0; i < selected.length; i++) {
      if (selected[i] == key) return true;
    }
    return false;
  }

  // method for show bottom sheet for colors ...
  dynamic _settingModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return BottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          onClosing: () {},
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter mystate) => ListView(
                shrinkWrap: true,
                children: values.keys.map((String key) {
                  return new CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    //  title: new Text(key),
                    value: widget._editState == true
                        ? stateFun(key) == true
                            ? values[key] = stateFun(key)
                            : values[key]
                        : values[key],
                    dense: true,
                    secondary: valuesIcons[key],
                    onChanged: (bool value) {
                      mystate(() {
                        if (value == false) selected.remove(key);
                        if (value == true) selected.add(key);
                        values[key] = value;
                      });
                    },
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }

// for category items ... // خاص بالتصنيف
  String catg = 'احذية بوت';

  dynamic _categoryBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return BottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          onClosing: () {},
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter myState) => ListView(
                shrinkWrap: true,
                children: values2.keys.map((String key) {
                  return new RadioListTile(
                    groupValue: catg,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: new Text(key),
                    value: categorySelected != null ? categorySelected : key,
                    dense: true,
                    onChanged: (value) {
                      myState(() {
                        catg = value;
                      });
                    },
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }

  // for upload img
  // ignore: missing_return
  Future<void> _uploadImages(BuildContext context) async {
    try {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          'التحميل قيد الانتظار',
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: Colors.green,
      ));

      imageFile.forEach((f) async {
        f = await compressFile(f);
        var ref = FirebaseStorage.instance.ref().child(p.basename(f.path));
        UploadTask uploadTask = ref.putFile(f);
        TaskSnapshot taskSnapshot = await uploadTask;
        String uri = await taskSnapshot.ref.getDownloadURL();

        imgselectedURI.add(uri);
        //selectedPic.add(  uri);
        if (imageFile.length == imgselectedURI.length) saveToFire(context);
      });
    } catch (ex) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "حدث مشكلة في النظام",
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  // method for send items to firebase...
  Future<void> saveToFire(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String uid = pref.getString('uid');
      var result = uid == null ? FirebaseAuth.instance.currentUser.uid : uid;
      if (result != null && imgselectedURI.length == imageFile.length) {
        String getResult;
        final firestoreInstance = FirebaseFirestore.instance;
        await FirebaseFirestore.instance
            .collection('users')
            .where('userid', isEqualTo: result)
            .get()
            .then((QuerySnapshot querySnapshot) => {
                  querySnapshot.docs.forEach((doc) {
                    getResult = doc["username"];
                  })
                });

        await firestoreInstance.collection("Notices").doc().set({
          "userid": result,
          "adminRead": 'unRead',
          "NoticesName": 'اضافة منتج جديد',
          'NoticesMessage': ' تم إضافة منتج من قبل$getResult',
          'NoticesNumber': 2,
          'productNumber': productNumber,
          'date': FieldValue.serverTimestamp()
        });
        await firestoreInstance.collection("products").doc().set({
          "productName": productName,
          'productState': "notAccept",
          "productQuantity": productQuantity,
          "productNumber": productNumber,
          'priceProduct': priceProduct,
          'BrandProduct': productBrand,
          "state": sex,
          "sizes": sizeSelected,
          'userid': result,
          'colors': selected,
          'category': catg,
          'ItemType': typeCatgs,
          'image': imgselectedURI,
          'date': FieldValue.serverTimestamp()
        }).then((value) => _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(
                'لقد قمت بإضافة المنتج بنجاح',
                textDirection: TextDirection.rtl,
              ),
              backgroundColor: Colors.green,
            )));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  SellerPage()),
        );
      }
    } catch (ex) {}
  }

  //  btn save form
  _saveForm(BuildContext context) {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _uploadImages(context);
    }
  }

  String sex;
  List<S2Choice<String>> sexList = [
    S2Choice<String>(value: 'نساء', title: 'نساء'),
    S2Choice<String>(value: 'رجال', title: 'رجال'),
    S2Choice<String>(value: 'اطفال', title: 'اطفال'),
  ];
  String typeCatgs;
  List<S2Choice<String>> catgList = [
    S2Choice<String>(value: 'ملابس', title: 'ملابس'),
    S2Choice<String>(value: 'احذية', title: 'احذية'),
    S2Choice<String>(value: 'اخرى', title: 'اخرى'),
  ];

  List getResult({String sexx, String type}) {
    if (sexx != null) {
      sex = sexx;
      type = typeCatgs;
    }
    return (sex == 'نساء' || sex == 'رجال') &&
            (typeCatgs == 'ملابس' || typeCatgs == 'اخرى')
        ? clothes
        : (sex == 'نساء') && (typeCatgs == 'احذية')
            ? womensShoeSizes
            : (sex == 'رجال') && (typeCatgs == 'احذية')
                ? mansShoeSizes
                : (sex == 'اطفال') &&
                        (typeCatgs == 'ملابس' || typeCatgs == 'اخرى')
                    ? childrenAges
                    : (sex == 'اطفال') && (typeCatgs == 'احذية')
                        ? agesChild
                        : clothes;
  }

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

  List<S2Choice<String>> childrenAges = [
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
  List<String> sizeSelected;

  List<S2Choice<String>> collection;

  getCarousel({List<String>  list}) {
    List<NetworkImage> links=List();
    if(list!=null)
    {
      list.map((url) {
       return links.add(new NetworkImage(url) ) ;
      }).toList();

    }
    return SizedBox(
      height: 150.0,
      // width: 300.0,
      child: Container(
        width: double.infinity,
        //   padding: EdgeInsets.all(10),
        child: Carousel(
          showIndicator: true,
          boxFit: BoxFit.fill,
          borderRadius: true,
          dotSpacing: 20,
          autoplay: false,
          //dotBgColor: Colors.black.withOpacity(0.5),
          //dotIncreasedColor: Colors.blue,
          radius: Radius.circular(20),
          // overlayShadowColors: Colors.blueAccent,
          //\ overlayShadow: true,
          animationCurve: Curves.fastOutSlowIn,
          //animationDuration: Duration(milliseconds: 1000),
           dotSize: 3,
          images: images.isNotEmpty?
          images.map((img) {
            return AssetThumb(
              asset: img,
              width: 300,
              height: 300,
            );
          }).toList()
          :links,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    checkInternetConnectivity(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,

        appBar: AppBar(
            title: widget._editState == false
                ? Text("أضف منتج جديد",style: TextStyle(fontWeight: FontWeight.bold),)
                : Text("تعديل منتج",style: TextStyle(fontWeight: FontWeight.bold),),
            centerTitle: true,
            automaticallyImplyLeading: false),
        key: _scaffoldKey,
        backgroundColor: Color(0xFFFFFFFF),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: StatefulBuilder(builder: (context, mystate) {
            return ListView(
              children: [
                // ملاحظة كان في سايزد بوكس لو سبب مشكلة في تصميم هني مكانه
                Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      widget._editState == false
                          ? Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Center(
                                      child: _error != ""
                                          ? Text('Error: $_error')
                                          : null),
                                  // Container(
                                  //   width: MediaQuery.of(context).size.width / 2,
                                  //   child: RawMaterialButton(
                                  //
                                  //     textStyle: TextStyle(
                                  //         fontWeight: FontWeight.bold,
                                  //         fontSize: 18,
                                  //         color: Colors.white),
                                  //     hoverColor: Colors.blueAccent,
                                  //     highlightColor: Colors.lightBlueAccent,
                                  //     child: Center(
                                  //         child: Container(
                                  //           color: Colors.blue,
                                  //           width: MediaQuery.of(context).size.width / 2,
                                  //           child: Text(
                                  //             "تحميل الصور",
                                  //             textAlign: TextAlign.center,
                                  //           ),
                                  //         )),
                                  //     onPressed: loadAssets,
                                  //   ),
                                  // ),
                                  FlatButton.icon(
                                    hoverColor: Colors.green.withOpacity(0.5),
                                    highlightColor:
                                        Colors.blue.withOpacity(0.5),
                                    shape: StadiumBorder(),
                                    //new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                    color: Colors.blue,
                                    onPressed: loadAssets,
                                    icon: Icon(
                                      Icons.add_photo_alternate,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      "تحميل الصور",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            )
                          : SizedBox.shrink(),
                      images.length>=1? getCarousel() : SizedBox.shrink(),
                      networksImage.length>=1?getCarousel(list: networksImage):SizedBox.shrink(),
                      SizedBox(
                        height: 30,
                      ),
                      Form(
                          key: _formKey,
                          child: (Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: TextFormField(
                                    controller: productNameCon,
                                    textAlign: TextAlign.right,
                                    onTap: () {

                                    },
                                    keyboardType: TextInputType.text,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter
                                          .singleLineFormatter
                                    ],
                                    onChanged: (value) {
                                      productName = value;
                                    },
                                    validator: (value) => value.isEmpty
                                        ? 'رجاء ادخل اسم المنتج'
                                        : null,
                                    decoration: InputDecoration(
                                      labelStyle:   TextStyle(fontSize: 14 ,fontWeight: FontWeight.bold),
                                        // prefixIcon: Icon(
                                        //   Icons.phone,
                                        //   color: Colors.brown,
                                        // ),
                                        labelText: "اسم المنتج",
                                    //    hintText: "ادخل اسم المنتج من فضلك"
                                    ),
                                  )),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child:
                                    TextFormField(
                                      textAlign: TextAlign.right,
                                      onTap: () {

                                      },
                                      keyboardType: TextInputType.text,
                                      controller: productBrandCon,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter
                                            .singleLineFormatter
                                      ],
                                      onChanged: (value) => productBrand = value,
                                      validator: (value) => value.isEmpty
                                          ? 'رجاء ادخل اسم ماركة المنتج'
                                          : null,
                                      decoration: InputDecoration(
                                          // prefixIcon: Icon(
                                          //   Icons.phone,
                                          //   color: Colors.brown,
                                          // ),
                                          labelText: "ماركة المنتج",
                                        labelStyle:   TextStyle(fontSize: 14 ,fontWeight: FontWeight.bold),
                                        //hintText: "ادخل اسم ماركة المنتج(اختياري)"
                                      ),
                                    ),
                                  )
                                ],
                              ),

                              SizedBox(
                                height: 12,
                              ),
                             Row(
                               children: [
                                 Expanded(
                                   child: TextFormField(
                                     textAlign: TextAlign.right,
                                     onTap: () {

                                     },
                                     keyboardType: TextInputType.number,
                                     controller: productQuantityCon,
                                     inputFormatters: <TextInputFormatter>[
                                       FilteringTextInputFormatter
                                           .singleLineFormatter
                                     ],
                                     onChanged: (value) => productQuantity = value,
                                     validator: (value) => value.isEmpty
                                         ? 'رجاء ادخل الكمية المتوفرة للمنتج'
                                         : null,
                                     decoration: InputDecoration(
                                         // prefixIcon: Icon(
                                         //   Icons.phone,
                                         //   color: Colors.brown,
                                         // ),
                                         labelText: "الكمية المتوفرة",
//                                         hintText: "ادخل الكمية المتوفرة للمنتج",
                                       labelStyle:   TextStyle(fontSize: 14 ,fontWeight: FontWeight.bold),

                                     ),
                                   ),
                                 ),
                                 SizedBox(
                                   width: 12,
                                 ),
                                 Expanded(
                                   child: TextFormField(
                                     textAlign: TextAlign.right,
                                     onTap: () {

                                     },
                                     keyboardType: TextInputType.number,
                                     controller: priceProductCon,
                                     inputFormatters: <TextInputFormatter>[
                                       FilteringTextInputFormatter
                                           .singleLineFormatter
                                     ],
                                     onChanged: (value) =>
                                     priceProduct = int.parse(value),
                                     validator: (value) => value.isEmpty
                                         ? 'رجاء ادخل سعرالمنتج'
                                         : null,
                                     decoration: InputDecoration(
                                         // prefixIcon: Icon(
                                         //   Icons.attach_money,
                                         //   color: Colors.brown,
                                         // ),
                                         labelText: "سعرالمنتج",
                                       labelStyle:   TextStyle(fontSize: 14 ,fontWeight: FontWeight.bold),
                                       //    hintText: "ادخل سعر المنتج"
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                              SizedBox(
                                height: 12,
                              ),
                              TextFormField(

                                controller: productNumberCon,
                                textAlign: TextAlign.right,
                                onTap: () {

                                },
                                keyboardType: TextInputType.text,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .singleLineFormatter
                                ],
                                onChanged: (value) =>
                                productNumber = value,
                                validator: (value) => value.isEmpty
                                    ? 'رجاء ادخل رقم المنتج'
                                    : null,
                                decoration: InputDecoration(
                                    // prefixIcon: Icon(
                                    //   Icons.phone,
                                    //   color: Colors.brown,
                                    // ),
                                    labelText: "رقم المنتج",
                                //    hintText: "ادخل رقم المنتج"
                                  labelStyle:   TextStyle(fontSize: 14 ,fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ))),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.color_lens_rounded),
                                color: Colors.redAccent,
                                iconSize: 48,
                                tooltip: 'حدد لون المنتج',
                                onPressed: () {
                                  _settingModalBottomSheet(context);
                                },
                              ),
                              Text('لون المنتج',)
                            ],
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.category),
                                color: Colors.orange,
                                iconSize: 48,
                                tooltip: 'حدد صنف المنتج',
                                onPressed: () {
                                  _categoryBottomSheet(context);
                                },
                              ),
                              Text('صنف المنتج')
                            ],
                          ),
                          // RaisedButton(
                          //     child: Text('اختر تصنيف المنتج'),
                          //     onPressed:(){
                          //       _categoryBottomSheet(context);
                          //     }
                          // )
                        ],
                      ),
                      SmartSelect<String>.single(
                          placeholder: 'تنصيف الثياب حسب النوع',
                          title: 'تصنيف الثياب',
                          value: typeCatgs,
                          choiceItems: catgList,
                          onChange: (state) {
                            mystate(() {
                              typeCatgs = state.value;
                              collection = getResult();
                              if (sizeSelected != null) sizeSelected.clear();
                            });
                          }),
                      Divider(),
                      SmartSelect<String>.single(
                          placeholder: 'تنصيف الاقسام حسب الجنس',
                          title: 'تصنيف الاقسام',
                          value: sex,
                          choiceItems: sexList,
                          onChange: (state) {
                            mystate(() {
                              sex = state.value;
                              collection = getResult();
                              if (sizeSelected != null) sizeSelected.clear();
                            });
                          }),
                      Divider(),
                      SmartSelect<String>.multiple(
                          placeholder: 'صنف حسب القياس',
                          title: 'القياس',
                          value: sizeSelected,
                          choiceItems: widget._editState == false
                              ? collection
                              : collection =
                                  getResult(sexx: sex, type: typeCatgs),
                          onChange: (state) => mystate(() {
                                sizeSelected = state.value;
                                //collection=getResult();
                              })),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: RaisedButton.icon(
                          color: Color(0xFF19d291),
                          icon: Icon(
                            Icons.save_alt,
                          ),
                          highlightColor: Colors.lightGreen,
                          onPressed: () => widget.getEditState == true
                              ? updateProduct(widget.getIndex)
                              : _saveForm(context),
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(0.0),
                          label: Text(
                              widget.getEditState == true
                                  ? 'تعديل البيانات'
                                  : 'حفظ',
                              style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              shrinkWrap: true,
            );
          }),
        ));
  }

  updateProduct(String id) async {
    //List myUpdateSize=[];
    await FirebaseFirestore.instance.collection('products').doc(id).update({
      'productName': productNameCon.text.toString(),
      'productNumber': productNumberCon.text.toString(),
      'productQuantity': productQuantityCon.text.toString(),
      'sizes': sizeSelected,
      'state': sex,
      'colors': selected,
      'category': catg,
      'priceProduct': int.parse(priceProductCon.text),
      'BrandProduct': productBrandCon.text.toString(),
      'ItemType': typeCatgs
    }).then((value) => _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            'لقد قمت بتعديل المنتج بنجاح',
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: Colors.green,
        ))).catchError((){
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          'حدثت مشكلة في التعديل',
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: Colors.green,
      ));
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  SellerPage()),
    );
  }
}
