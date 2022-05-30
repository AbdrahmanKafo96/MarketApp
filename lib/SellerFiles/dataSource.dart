import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

List<dynamic> options(String valSelected){
 List values;
 if(valSelected=="رجال" || valSelected=="نساء") {
    values=[
    {
    "display": "XS",
    "value": "XS",
    },
    {
    "display": "S",
    "value": "S",
    },
    {
    "display": "M",
    "value": "M",
    },
    {
    "display": "L",
    "value": "L",
    },
    {
    "display": "XL",
    "value": "XL",
    },
 {
 "display": "XXL",
 "value": "XXL",
 },
 {
 "display": "XXXL",
 "value": "XXXL",
 },
 ];
 }
 if(valSelected=="اطفال1"){

   values=[
     {
       "display": "0-1",
       "value": "0-1",
     },
     {
       "display": "1-2",
       "value": "1-2",
     },
     {
       "display": "2-3",
       "value": "2-3",
     },
     {
       "display": "3-4",
       "value": "3-4",
     },
     {
       "display": "4-5",
       "value": "4-5",
     },
     {
       "display": "5-6",
       "value": "5-6",
     },
     {
       "display": "6-7",
       "value": "6-7",
     },
     {
       "display": "7-8",
       "value": "7-8",
     },
     {
       "display": "8-9",
       "value": "8-9",
     },
     {
       "display": "9-10",
       "value": "9-10",
     },
     {
       "display": "10-11",
       "value": "10-11",
     },
     {
       "display": "11-12",
       "value": "11-12",
     },
     {
       "display": "12-13",
       "value": "12-13",
     },
     {
       "display": "14-15",
       "value": "14-15",
     },
     {
       "display": "15-16",
       "value": "15-16",
     },
     {
       "display": "16-17",
       "value": "16-17",
     },
     {
       "display": "17-18",
       "value": "17-18",
     },
     {
       "display": "18-19",
       "value": "18-19",
     },
     {
       "display": "19-20",
       "value": "19-20",
     },
     {
       "display": "20-21",
       "value": "20-21",
     },
     {
       "display": "21-22",
       "value": "21-22",
     },
     {
       "display": "22-23",
       "value": "22-23",
     },
     {
       "display": "23-24",
       "value": "23-24",
     },

   ];
 }
 if(valSelected=="اطفال2"){
   values=[
     {
       "display": "2",
       "value": "2",
     },
     {
       "display": "3",
       "value": "3",
     },
     {
       "display": "4",
       "value": "4",
     },
     {
       "display": "5",
       "value": "5",
     },
     {
       "display": "6",
       "value": "6",
     },
     {
       "display": "7",
       "value": "7",
     },
     {
       "display": "8",
       "value": "8",
     },
     {
       "display": "9",
       "value": "9",
     },
     {
       "display": "10",
       "value": "10",
     },
     {
       "display": "11",
       "value": "11",
     },
     {
       "display": "12",
       "value": "12",
     },
     {
       "display": "13",
       "value": "13",
     },
     {
       "display": "14",
       "value": "اربعة عشر",
     },
     {
       "display": "15",
       "value": "15",
     },
     {
       "display": "16",
       "value": "16",
     },
     {
       "display": "17",
       "value": "17",
     },

   ];
 }
 return values;
}
Map<String,dynamic> colorsOptions(){

  Map<String, Widget> valuesIcons = {
    '0xFFD7CCC8': Icon(Icons.circle,color: Color(0xFFD7CCC8)),
    '4294198070': Icon(Icons.circle,color: Colors.red,),
    '4280391411': Icon(Icons.circle,color: Colors.blue,),
    '4294961979': Icon(Icons.circle,color: Colors.yellow),
    '4294967295': Icon(Icons.circle,color: Colors.white70),
    '4286141768': Icon(Icons.circle,color: Colors.brown),
    '4294940672': Icon(Icons.circle,color: Colors.orange),
    '4283215696': Icon(Icons.circle,color: Colors.green),
    '4278190080': Icon(Icons.circle,color: Colors.black),
    '4293467747': Icon(Icons.circle,color: Colors.pink),
    '4288585374': Icon(Icons.circle,color: Colors.grey),
    '4282339765': Icon(Icons.circle,color: Colors.indigo),
    '4278228616': Icon(Icons.circle,color: Colors.teal),
    '4291681337': Icon(Icons.circle,color: Colors.lime),
    '4288423856': Icon(Icons.circle,color: Colors.purple),


  };

  return valuesIcons;
}

Map<String, bool> mapColorsNames;
Map<String, bool> getColorsNames(){
  return mapColorsNames = {
    '0xFFD7CCC8': false,
    '4294198070': false,
    '4280391411': false,
    '4294961979': false,
    '4294967295':false,
    '4286141768': false,
    '4294940672': false,
    '4283215696': false,
    '4278190080': false,
    '4293467747': false,
    '4288585374': false,
    '4282339765': false,
    '4278228616': false,
    '4291681337': false,
    '4288423856': false,


  };
}

Map<String, bool> getcategoryNames;

Map<String, bool> getCategoryNames(){
  return getcategoryNames = {
    "احذية بوت":false,
    'احذية رسمية': false,
    'احذية سبورت': false,
    'احذية سندل': false,
    'سبورت': false,
    'داخلي': false,
    'بجامات': false,
    'كاجول': false,
    'فساتين سهرات': false,
    'فساتين اعراس': false,
    'بدلة رسمية': false,
    'بجامات داخلي': false,
    'فساتين اطفال': false,
    'اخرى': false,
   };
}
Future<File> compressFile(File file) async {
  File compressedFile =
  await FlutterNativeImage.compressImage(file.path, targetHeight: 720);
  return compressedFile;
}