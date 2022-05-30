import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketApp/adminFiles/viewAccounts.dart';
import 'package:marketApp/widget/checkInternet.dart';

class GridDashBoard extends StatefulWidget {
  @override
  _GridDashBoardState createState() => _GridDashBoardState();
}

class _GridDashBoardState extends State<GridDashBoard> {

  int  _accountState ,_accountState2;

  Items item1 =
  Items(title: "حسابات نشطة", subTitle:"حسابات تم تفعيلها", img: 'assets/imgs/kyc.png'
      ,stateNumber: 1);
  Items item2 =
  Items(title: "حسابات غير نشطة", subTitle: "حسابات لم يتم تفعيلها",
      img: 'assets/imgs/profile.png',stateNumber: 2);

  // Items item3 = Items(
  //     title: "aaaa", subTitle: "sssssss", img: 'assets/imgs/approve.png',stateNumber: 0);

  Future<void>countDocuments (int initState)   async {
    String accountState='unaccept';
    if(initState ==2) {
      _accountState2=await getCountOfState(accountState);
    }
    if(initState ==1) {
      accountState = "accept";
      _accountState=await getCountOfState(accountState);
    }
  }   // Count of Documents in Collection

  Future<int> getCountOfState(String accountState  ) async {
    int _actState2;
    QuerySnapshot _myDoc = await FirebaseFirestore.instance
        .collection('users')
        .where("AccountState", isEqualTo: accountState)
        .get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    setState(() {
      _actState2 = _myDocCount.length;
      print(_actState2);
    });
    return _actState2;
  }
  @override
  initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    checkInternetConnectivity(context);
    List<Items> myItems = [item1, item2];
    var color = 0xff616161;
      //////////////////////////////////////////////////////////////////////////////d
    //dld
       countDocuments(2);
       countDocuments(1);
    return Flexible(
        child: GridView.count(
          crossAxisCount: 2,
          //shrinkWrap: true,
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(right: 15, left: 15),
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myItems.map((data) {

            return InkWell(
              onTap: ()=> Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>   ViewAccounts(
                        accountState: data.stateNumber==1?"accept":
                        data.stateNumber==2?'unaccept':'')
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(color), borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 42,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Directionality(textDirection: TextDirection.rtl,
                      child: Text (
                        " ${data.stateNumber==1?_accountState:data.stateNumber==2?_accountState2:""} ${data.title}",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                      ),),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.subTitle,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ));
  }
}

class Items {
  String title, subTitle, img ;
  int stateNumber;

  Items({this.title, this.subTitle, this.img , this.stateNumber});
}
