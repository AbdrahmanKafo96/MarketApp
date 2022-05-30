import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marketApp/Buyer/buyer.dart';
import 'package:marketApp/DartFiles/HomeScreen.dart';
 import 'package:marketApp/Dartfiles/IntroScreen.dart';
import 'package:marketApp/provider/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DartFiles/auth_screen.dart';
import 'SellerFiles/addProduct.dart';


  Future<void>  main() async {

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    SharedPreferences pref=await SharedPreferences.getInstance();
    String email=pref.getString('email');

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    runApp(
        MultiProvider(providers: [
          ChangeNotifierProvider<Prov>(create:(context)=>Prov(),),],
     child: MaterialApp(
       theme: ThemeData(

         backgroundColor: Color(0xFFFFFFFF),
          shadowColor: Color(0xFF242b3b),

          appBarTheme: AppBarTheme(

            color: Color(0xFF242b3b),
            shadowColor: Color(0xFF242b3b),
            elevation: 1.0,
            centerTitle: true,
          ),
         // data: Theme.of(context).copyWith(
         //     canvasColor: Colors.black,
         //     splashColor: Colors.yellowAccent,
         //     unselectedWidgetColor: Colors.green,
         //     primaryColor: Colors.red,
         //     textTheme: Theme.of(context).textTheme.copyWith(caption: new TextStyle(color: Colors.grey))
         // ),
         hintColor: Color(0xFF74767f),
         inputDecorationTheme: InputDecorationTheme(

           fillColor: Color(0xFFFFFFFF),
           isDense: true,
           contentPadding: EdgeInsets.all(8),
           labelStyle: TextStyle(color: Color(0xFF242b3b),fontWeight: FontWeight.bold) ,
           filled: true,
           enabledBorder: OutlineInputBorder(
             borderSide: BorderSide(color:Colors.grey),
             borderRadius: BorderRadius.circular(25),
           ),
           disabledBorder: OutlineInputBorder(
             borderSide: BorderSide(color: Color(0xFF242b3b)),
             borderRadius: BorderRadius.circular(25),
           ),
           focusedBorder: OutlineInputBorder(
             borderSide: BorderSide(color: Color(0xFF242b3b)),
             borderRadius: BorderRadius.circular(25),
           ),
         ),
       ),
       routes: {
         'login':(context) => AuthScreen(authType:AuthType.login),
         'register':(context) => AuthScreen(authType:AuthType.register),
         'Home':(context) =>HomeScreen(),
         'addProduct':(context) =>Product(),
         'buyer':(context) => BuyerPage(),
       },
       debugShowCheckedModeBanner: false,
       home: email ==null ?StartApp():HomeScreen( ),),
    ));
   // runApp(StartApp());
  }
  class StartApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {

      return  Scaffold(
        body:IntroScreen() ,
      );
    }
  }


