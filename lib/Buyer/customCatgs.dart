 import 'package:flutter/material.dart';
import 'package:marketApp/Buyer/ViewProducts.dart';
Widget myCustomList(BuildContext context){
  return ListView (
        shrinkWrap: true,
        reverse: true,
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: [
            Container(
            width: 100,
            height: 100,
            //Text(snapshot.data.docs[index]['categoryName'] snapshot.data.docs[index]['photoLink'].toString()
            child:  SizedBox(
              child: ListTile(
                title: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset("assets/imgs/2.png"  ),),

                subtitle: Text("احذية بوت",textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black,fontSize: 12),),
                onTap: (){
                  // print(snapshot.data.docs[index]['category'].toString());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>ViewProducts(
                        collName: 'products',filedName: 'category',
                        catgsName:"احذية بوت",
                      ),
                      // snapshot.data.docs[index]['category'].toString()
                    ),
                  );
                },
              ),
             )
           ),
          Container(
              width: 100,
              height: 100,
              //Text(snapshot.data.docs[index]['categoryName'] snapshot.data.docs[index]['photoLink'].toString()
              child:  SizedBox(
                child: ListTile(
                  title:  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/imgs/3.png"  ),),

                  subtitle: Text("احذية رسمية",textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black,fontSize: 12),),
                  onTap: (){
                    // print(snapshot.data.docs[index]['category'].toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>ViewProducts(
                          collName: 'products',filedName: 'category',
                          catgsName:"احذية رسمية",
                        ),
                        // snapshot.data.docs[index]['category'].toString()
                      ),
                    );
                  },
                ),
              )
          ),
          Container(
              width: 100,
              height: 100,
              //Text(snapshot.data.docs[index]['categoryName'] snapshot.data.docs[index]['photoLink'].toString()
              child:  SizedBox(
                child: ListTile(
                  title:  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/imgs/4.png"  ),),

                  subtitle: Text("احذية سبورت",textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black,fontSize: 12),),
                  onTap: (){
                    // print(snapshot.data.docs[index]['category'].toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>ViewProducts(
                          collName: 'products',filedName: 'category',
                          catgsName:"احذية سبورت",
                        ),
                        // snapshot.data.docs[index]['category'].toString()
                      ),
                    );
                  },
                ),
              )
          ),Container(
              width: 100,
              height: 100,
              //Text(snapshot.data.docs[index]['categoryName'] snapshot.data.docs[index]['photoLink'].toString()
              child:  SizedBox(
                child: ListTile(
                  title:  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/imgs/1.png"  ),),

                  subtitle: Text("احذية سندل",textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black,fontSize: 12),),
                  onTap: (){
                    // print(snapshot.data.docs[index]['category'].toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>ViewProducts(
                          collName: 'products',filedName: 'category',
                          catgsName:"احذية سندل",
                        ),
                        // snapshot.data.docs[index]['category'].toString()
                      ),
                    );
                  },
                ),
              )
          ),Container(
              width: 100,
              height: 100,
              //Text(snapshot.data.docs[index]['categoryName'] snapshot.data.docs[index]['photoLink'].toString()
              child:  SizedBox(
                child: ListTile(
                  title:   CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/imgs/6.png"  ),),

                  subtitle: Text("سبورت",textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black,fontSize: 12),),
                  onTap: (){
                    // print(snapshot.data.docs[index]['category'].toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>ViewProducts(
                          collName: 'products',filedName: 'category',
                          catgsName:"سبورت",
                        ),
                        // snapshot.data.docs[index]['category'].toString()
                      ),
                    );
                  },
                ),
              )
          ),Container(
              width: 100,
              height: 100,
              //Text(snapshot.data.docs[index]['categoryName'] snapshot.data.docs[index]['photoLink'].toString()
              child:  SizedBox(
                child: ListTile(
                  title: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/imgs/7.png"  ),),

                  subtitle: Text("داخلي",textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black,fontSize: 12),),
                  onTap: (){
                    // print(snapshot.data.docs[index]['category'].toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>ViewProducts(
                          collName: 'products',filedName: 'category',
                          catgsName:"داخلي",
                        ),
                        // snapshot.data.docs[index]['category'].toString()
                      ),
                    );
                  },
                ),
              )
          ),Container(
              width: 100,
              height: 100,
              //Text(snapshot.data.docs[index]['categoryName'] snapshot.data.docs[index]['photoLink'].toString()
              child:  SizedBox(
                child: ListTile(
                  title:  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/imgs/10.png"  ),),

                  subtitle: Text("بجامات",textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black,fontSize: 12),),
                  onTap: (){
                    // print(snapshot.data.docs[index]['category'].toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>ViewProducts(
                          collName: 'products',filedName: 'category',
                          catgsName:"بجامات",
                        ),
                        // snapshot.data.docs[index]['category'].toString()
                      ),
                    );
                  },
                ),
              )
          ),Container(
              width: 100,
              height: 100,
              //Text(snapshot.data.docs[index]['categoryName'] snapshot.data.docs[index]['photoLink'].toString()
              child:  SizedBox(
                child: ListTile(
                  title: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/imgs/8.png"  ),),

                  subtitle: Text("كاجول",textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black,fontSize: 12),),
                  onTap: (){
                    // print(snapshot.data.docs[index]['category'].toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>ViewProducts(
                          collName: 'products',filedName: 'category',
                          catgsName:"كاجول",
                        ),
                        // snapshot.data.docs[index]['category'].toString()
                      ),
                    );
                  },
                ),
              )
          ),Container(
              width: 100,
              height: 100,
              //Text(snapshot.data.docs[index]['categoryName'] snapshot.data.docs[index]['photoLink'].toString()
              child:  SizedBox(
                child: ListTile(
                  title: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/imgs/12.png"  ),),

                  subtitle: Text("فساتين سهرات",textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black,fontSize: 12),),
                  onTap: (){
                    // print(snapshot.data.docs[index]['category'].toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>ViewProducts(
                          collName: 'products',filedName: 'category',
                          catgsName:"فساتين سهرات",
                        ),
                        // snapshot.data.docs[index]['category'].toString()
                      ),
                    );
                  },
                ),
              )
          ),Container(
              width: 100,
              height: 100,
              //Text(snapshot.data.docs[index]['categoryName'] snapshot.data.docs[index]['photoLink'].toString()
              child:  SizedBox(
                child: ListTile(
                  title:  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/imgs/11.png"  ),),

                  subtitle: Text("فساتين اعراس",textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black,fontSize: 12),),
                  onTap: (){
                    // print(snapshot.data.docs[index]['category'].toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>ViewProducts(
                          collName: 'products',filedName: 'category',
                          catgsName:"فساتين اعراس",
                        ),
                        // snapshot.data.docs[index]['category'].toString()
                      ),
                    );
                  },
                ),
              )
          ),Container(
              width: 100,
              height: 100,
              //Text(snapshot.data.docs[index]['categoryName'] snapshot.data.docs[index]['photoLink'].toString()
              child:  SizedBox(
                child: ListTile(
                  title:  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/imgs/9.png"  ),),

                  subtitle: Text("بدلة رسمية",textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black,fontSize: 12),),
                  onTap: (){
                    // print(snapshot.data.docs[index]['category'].toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>ViewProducts(
                          collName: 'products',filedName: 'category',
                          catgsName:"بدلة رسمية",
                        ),
                        // snapshot.data.docs[index]['category'].toString()
                      ),
                    );
                  },
                ),
              )
          ),Container(
              width: 100,
              height: 100,
              //Text(snapshot.data.docs[index]['categoryName'] snapshot.data.docs[index]['photoLink'].toString()
              child:  SizedBox(
                child: ListTile(
                  title: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/imgs/7.png"  ),),

                  subtitle: Text("بجامات داخلي",textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black,fontSize: 12),),
                  onTap: (){
                    // print(snapshot.data.docs[index]['category'].toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>ViewProducts(
                          collName: 'products',filedName: 'category',
                          catgsName:"بجامات داخلي",
                        ),
                        // snapshot.data.docs[index]['category'].toString()
                      ),
                    );
                  },
                ),
              )
          ),Container(
              width: 100,
              height: 100,
              //Text(snapshot.data.docs[index]['categoryName'] snapshot.data.docs[index]['photoLink'].toString()
              child:  SizedBox(
                child: ListTile(
                  title:  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/imgs/14.png"  ),),

                  subtitle: Text("فساتين اطفال",textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black,fontSize: 12),),
                  onTap: (){
                    // print(snapshot.data.docs[index]['category'].toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>ViewProducts(
                          collName: 'products',filedName: 'category',
                          catgsName:"فساتين اطفال",
                        ),
                        // snapshot.data.docs[index]['category'].toString()
                      ),
                    );
                  },
                ),
              )
          ),Container(
              width: 100,
              height: 100,
             // color: Colors.amber,
              //Text(snapshot.data.docs[index]['categoryName'] snapshot.data.docs[index]['photoLink'].toString()
              child:  SizedBox(
                child: ListTile(
                  title:  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/imgs/13.png"  ),),

                  subtitle: Text("اخرى",textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black,fontSize: 12),),
                  onTap: (){
                    // print(snapshot.data.docs[index]['category'].toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>ViewProducts(
                          collName: 'products',filedName: 'category',
                          catgsName:"اخرى",
                        ),
                        // snapshot.data.docs[index]['category'].toString()
                      ),
                    );
                  },
                ),
              )
          ),
        ],
    );
}

// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) =>ViewProducts(
// collName: 'products',filedName: 'category',
// catgsName: snapshot.data.docs[index]['categoryName'],
// ),
// // snapshot.data.docs[index]['category'].toString()
// ),
// );