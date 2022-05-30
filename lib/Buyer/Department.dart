import 'package:flutter/material.dart';
import 'package:marketApp/Buyer/ViewProducts.dart';

class Department extends StatefulWidget {
  @override
  _DepartmentState createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {
  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
      children: <Widget>[
        InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewProducts(
                    collName: 'products',filedName: 'state',catgsName: 'رجال', )
              ),
            );
          },
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    blurRadius: 20.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: Offset(
                      5.0, // Move to right 10  horizontally
                      5.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              child: GridTile(
                //child: Image.asset("assets/imgs/cover.png"),
                child: Image.asset(
                    "assets/imgs/man.png"
                  ,width: MediaQuery.of(context).size.width,),
                footer: Container(
                  height: 25,
                  color: Colors.black.withOpacity(0.5),
                  child: Text(
                    "رجالي",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewProducts(
                    collName: 'products',filedName: 'state',catgsName: 'نساء', )
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    blurRadius: 20.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: Offset(
                      5.0, // Move to right 10  horizontally
                      5.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              child: GridTile(
                //  child: Image.asset("assets/imgs/cover.png"),
                child: Image.asset(
                    "assets/imgs/women.png" ,
                  width: MediaQuery.of(context).size.width,

                   ),
                footer: Container(
                  height: 25,
                  color: Colors.black.withOpacity(0.5),
                  child: Text(
                    "نسائي",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),

        InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewProducts(
                    collName: 'products',filedName: 'category',catgsName: 'سبورت', )
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    blurRadius: 20.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: Offset(
                      5.0, // Move to right 10  horizontally
                      5.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              child: GridTile(
                 // child: Image.asset("assets/imgs/cover.png"),
                child: Image.asset(
                    "assets/imgs/sport.png"
                  ,width: MediaQuery.of(context).size.width,),

                footer: Container(
                  height: 25,
                  color: Colors.black.withOpacity(0.5),
                  child: Text(
                    "رياضي",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),


        InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewProducts(
                    collName: 'products',filedName: 'state',catgsName: 'اطفال', )
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    blurRadius: 20.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: Offset(
                      5.0, // Move to right 10  horizontally
                      5.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              child: GridTile(
                // child: Image.asset("assets/imgs/cover.png"),
                child: Image.asset(
                    'assets/imgs/child.png'
                  ,width: MediaQuery.of(context).size.width,),
                footer: Container(
                  height: 25,
                  color: Colors.black.withOpacity(0.5),
                  child: Text(
                    "الاطفال",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
