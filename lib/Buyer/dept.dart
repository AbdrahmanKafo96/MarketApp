import 'package:flutter/material.dart';
import 'package:marketApp/Buyer/Department.dart';

class DeptPage extends StatefulWidget {
  @override
  _DeptPageState createState() => _DeptPageState();
}

class _DeptPageState extends State<DeptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('الأقسام',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Department(),
    );
  }
}
