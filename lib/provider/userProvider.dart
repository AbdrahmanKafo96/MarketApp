import 'package:flutter/foundation.dart';
 import 'package:smart_select/smart_select.dart';

class Prov with ChangeNotifier{

  String name;
  String _userId;
  List nameList;
 List idsList;

 String price;

 int notiBuyer=0;

 setIncremntCountCart({int i}){
   if(i!=null)
     {
       return notiBuyer=i;
     }
   else {
     notiBuyer++;
   }
   notifyListeners();
 }
   decremntCountCart({int i}){

    notifyListeners();
    notiBuyer--;
   }
  int getNotiBuyer()  {
     return  notiBuyer;
 }

 List<S2Choice<String>> myColliction;
  List get getList{
    return nameList;
  }


  String get getUserId {
    // notifyListeners();
    return  _userId;
  }

  set setUserId(String value) {
    _userId = value;
       notifyListeners();
//   setState() or markNeedsBuild() called during build.
  }
  List<String> orderRandomNumbers=List();
}

