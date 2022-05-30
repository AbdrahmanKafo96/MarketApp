import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:marketApp/DartFiles/HomeScreen.dart';
import 'package:marketApp/DartFiles/UserModel.dart';
import 'package:marketApp/DartFiles/auth_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketApp/provider/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_select/smart_select.dart';
import 'buttonWidget.dart';
import 'checkInternet.dart';

class AuthForm extends StatefulWidget {
  final AuthType authType;

  const AuthForm({Key key, @required this.authType}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  //AuthBase authBase = AuthBase();
  @override
  void initState() {
    super.initState();
  }

  List<S2Choice<String>> userTypeList = [
    S2Choice<String>(value: 'مشتري', title: 'مشتري'),
    S2Choice<String>(value: 'بائع', title: 'بائع'),

  ];
  // List<String> listCountry = ['libya', 'Turkey'];
  // List<String> listCity = ['tripoli', 'istanuble' ,"bangazi"];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  String countryValue,
   stateValue,
   cityValue;
  // String selectedCou = "libya",
  //     selectedCity = "tripoli",
  String   _email = "",
      _password="",
      repassword,
      state ,
      userNumber,
      username;

      Prov prov;
      String messgae="";
      PhoneNumber phoneNumber = PhoneNumber(isoCode: 'LBY');

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
    await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.phoneNumber = number;
    });
  }
  @override
  Widget build(BuildContext context) {
    prov=Provider.of<Prov>(context );
    checkInternetConnectivity(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Form(
        //onWillPop: ,
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),

                TextFormField(
                  textInputAction: TextInputAction.next,
                // onTap: () {
                //   closeKeyBoard(context);
                // }
                textAlign:TextAlign.right,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => _email = value,
                validator: (value) {
                  if (value.isEmpty) {
                    return "البريد الالكتروني مطلوب";

                  }

                  else if (!RegExp(
                      "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                      .hasMatch(value)) {
                    return 'ادخل بريد إلكتروني سليم';
                  }

                  // validator has to return something :)
                  return null;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.alternate_email,
                      color: Color(0xFF0e7a50),
                    ),

                    labelText: "ادخل بريد إلكتروني",
                    hintText: "example@example.com"),
              ) ,
              SizedBox(
                height: 12,
              ),
            TextFormField(
              //textAlign:TextAlign.right,
              // onTap: () {
              //   closeKeyBoard(context);
              // },
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                setState(() {
                  _password=value;

                });
                widget.authType == AuthType.login ? null :messgae= UserModel.isValidPassword(value);

                if(value=="")
                  messgae="";
              },
              validator: (value) {
                if(value.isEmpty)
                  return"الرمز السري مطلوب";
                if(messgae!=""){
                  return "تأكد من الرمز السري";
                }else
                  return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Color(0xFF0e7a50),
                ),
                labelText: "ادخل الرمز السري",
                hintText: '************',
              ),
              obscureText: true,
            ),
                messgae!=""?Text(messgae ,
                 style: TextStyle(color: Colors.red),):SizedBox.shrink(),
              SizedBox(
                height: 12,
              ),
              widget.authType == AuthType.register
                  ? Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          // textAlign:TextAlign.right,
                          // onTap: () {
                          //   closeKeyBoard(context);
                          // },
                          onChanged: (value) {
                            repassword = value;
                          },
                          validator: (value) {
                            if(value.isEmpty)return'الرمز السري مطلوب';
                            if (repassword != _password) {
                              return 'الرمز السري غير صحيح';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Color(0xFF0e7a50),
                            ),
                            hintText: '************',
                            labelText: "اعد ادخل الرمز السري",
                          ),
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          // onTap: () {
                          //   closeKeyBoard(context);
                          // },
                          textAlign:TextAlign.right,
                          keyboardType: TextInputType.name,
                          onChanged: (value) => username = value,
                          validator: (value) =>
                              value.isEmpty ? 'اسم المستخدم الثلاثي مطلوب' : null,
                           decoration: InputDecoration(
                           prefixIcon: Icon(
                                Icons.person,
                                color: Color(0xFF0e7a50),
                              ),
                              labelText: "ادخل اسم المستخدم الثلاثي",
                              hintText: "من فضلك ادخل اسم المستخدم الثلاثي"),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InternationalPhoneNumberInput(

                                  onInputChanged: (PhoneNumber number) {
                                    userNumber= number.phoneNumber;
                                  },
                                //   onSaved: (value){
                                //     if(value.phoneNumber.isEmpty)
                                //       return'ادخل رقم الهاتف';
                                // },
                                  onInputValidated: (bool value) {
                                    print(value);
                                  },
                                  textAlign: TextAlign.right,
                                  selectorConfig: SelectorConfig(
                                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                                  ),
                                  ignoreBlank: false,
                                  autoValidateMode: AutovalidateMode.disabled,
                                  selectorTextStyle: TextStyle(color: Colors.black),
                                  initialValue: phoneNumber,
                                  textFieldController: controller,

                                  formatInput: false,
                                  keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                  inputBorder: OutlineInputBorder(),
                                  hintText: '092-00000000',
                                  keyboardAction: TextInputAction.next,
                                ),
                              ],
                            ),
                          ),
                        SizedBox(
                          height: 24,
                        ),
                        SelectState(
                          onCountryChanged: (value) {
                            setState(() {
                              countryValue = value;
                            });
                          },
                          onStateChanged:(value) {
                            setState(() {
                              stateValue = value;
                            });
                          },
                          // onCityChanged:(value) {
                          //   setState(() {
                          //     cityValue = value;
                          //   });
                          // },

                        ),


                        SmartSelect<String>.single(
                            modalValidation: (String message){
                            //  Text(state==null?"يجيب اختيار نوع الحساب":"" , style: TextStyle(color: Colors.red,));

                              //return message="يحب اختيار نوع الحساب";
                              return "";
                            },
                            placeholder: 'سجل معنا',
                            title: 'نوع الحساب',
                            value: state,
                            choiceItems: userTypeList,
                            onChange: (ste) {
                               state = ste.value;
                            }),
                        Divider(color: Color(0xFF242b3b),),
                      ],
                    )
                  : SizedBox.shrink(),

              SizedBox(
                height: 20,
              ),
              Consumer<Prov>(
                builder: (context ,myProv ,child){
                  return ButtonWidget(
                    text: widget.authType == AuthType.login
                        ? 'تسجيل الدخول'
                        : 'إنشاء حساب',
                    onPressed: () async {

                      // if(!_formKey.currentState.validate() && widget.authType == AuthType.login)
                      //   showShortToast("تأكد من إدخالك لكلمة المرور والبريد بشكل سليم");



                      if (_formKey.currentState.validate() ) {

                        var result;
                        if (widget.authType == AuthType.login) {
                          try {
                            // ignore: unrelated_type_equality_checks

                            result = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                email: _email, password: _password)
                                .catchError((error){
                              showShortToast("تأكد من البريد الإلكتروني وكلمة المرور");
                            });
                            if (result != null) {
                              SharedPreferences pref=await  SharedPreferences.getInstance();
                              pref.setString('email', _email);
                              
                              pref.setString('uid', FirebaseAuth.instance.currentUser.uid.toString());
                              myProv.setUserId=pref.getString('uid');
                              _onLoading();
                            }
                          } catch (e) {
                            print("the message e =$e");
                          }
                        } // end if stm ......
                        else {
                          result = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                              email: _email, password: _password);
                          if (result != null) {
                            String accountState ="buyerOk";

                            if (state =="بائع")
                              accountState='unaccept';

                            final firestoreInstance = FirebaseFirestore.instance;

                            await firestoreInstance.collection("users").doc().set({
                           //  countryValue;
                           // stateValue;
                           //    cityValue;
                              "AccountState":accountState,
                              "useremail": _email,

                              "country": countryValue,
                              "state": state,
                              "phonenumber": userNumber,
                              "city": stateValue,
                              //'State':stateValue,
                              "username": username,
                              'userid':FirebaseAuth.instance.currentUser.uid,
                            }).then((value) => print("it's save"));
                            // this section for notifications
                            if (state =="بائع") {
                              await firestoreInstance
                                  .collection("Notices")
                                  .doc()
                                  .set({
                                "userid": FirebaseAuth.instance.currentUser.uid,
                                "adminRead": 'unRead',
                                "NoticesName": 'تسجيل بائع جديد',
                                'NoticesMessage':
                                ' لقد قام $username بالتسجيل في النظام ',
                                'NoticesNumber': 1,
                                'date': FieldValue.serverTimestamp()
                              });
                            }
                            SharedPreferences pref=await  SharedPreferences.getInstance();
                            pref.setString('email', _email);
                             
                            pref.setString('uid', FirebaseAuth.instance.currentUser.uid.toString());
                            myProv.setUserId=pref.getString('uid');

                            _onLoading();
                          }
                        }
                      }
                     },
                    textColor: Colors.white,
                    bgColor: 0xFF242b3b,
                  );
                }
              ),
              SizedBox(
                height: 5,
              ),
              FlatButton(
                onPressed: () {

                  if (widget.authType == AuthType.login)

                    Navigator.of(context).pushReplacementNamed('register');
                  else
                    Navigator.of(context).pushReplacementNamed('login');
                },
                child: Text(
                  widget.authType == AuthType.login
                      ? "ليس لديك حساب؟ سجل معنا"
                      : 'هل تملك حساب؟',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void showShortToast(String meg) {
    Fluttertoast.showToast(
        msg: "$meg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  void _onLoading() {
    showDialog(
     // child:Text("يتم تجهيز النظام"),
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  new CircularProgressIndicator(),
                  new Text("انتظر قليلا" ,style: TextStyle(fontSize: 16), ),
                ],
              ),
            ),
          ),
        );
      },
    );

    new Future.delayed(new Duration(seconds: 1), () {
      Navigator.pop(context); //pop dialog
      Navigator.push(context, MaterialPageRoute(builder: (context)=>
          HomeScreen( )));
    });
  }

}
