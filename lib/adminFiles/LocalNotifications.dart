// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class LocalNotifications extends StatefulWidget {
//   @override
//   _LocalNotificationsState createState() => _LocalNotificationsState();
// }
//
// class _LocalNotificationsState extends State<LocalNotifications> {
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//   @override
//   void initState() {
//     super.initState();
//     flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
//     var android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     var ios =IOSInitializationSettings();
//     var initSetting= InitializationSettings(android: android,iOS: ios);
//     flutterLocalNotificationsPlugin.initialize(initSetting,onSelectNotification: selectNotification);
//   }
// Future selectNotification(String payload) async {
//   if (payload != null) {
//     debugPrint('notification payload: $payload');
//   }
//   print('yes we are do it ');
//   // await Navigator.push(
//   //   context,
//   //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
//   // );
// }
//   fun12(){
//     var android=AndroidNotificationDetails("channelId", "channelName", "channelDescription" ,priority: Priority.high ,);
//     //icon: Icons.notifications.fontFamily
//     var ios = IOSNotificationDetails();
//     var platform=NotificationDetails(android: android ,iOS: ios);
//
//     // const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     // AndroidNotificationDetails('repeating channel id',
//     //     'repeating channel name', 'repeating description' ,priority: Priority.high);
//     // const NotificationDetails platformChannelSpecifics =
//     // NotificationDetails(android: androidPlatformChannelSpecifics);
//
//     flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
//         'repeating body', RepeatInterval.everyMinute, platform,
//         androidAllowWhileIdle: true ,payload: 'sendPayload');
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return null;
//   }
// }
