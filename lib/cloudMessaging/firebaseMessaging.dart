
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart' as localNotify;
// import 'package:http/http.dart' as http;
// import 'package:trustGroup_app/chatPage.dart';
// // import 'package:trustGroup_app/cloudMessaging/message.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:toast/toast.dart';

// import 'api/messaging.dart';
// class MessagingWidget extends StatefulWidget {
//   @override
//   _MessagingWidgetState createState() => _MessagingWidgetState();
// }

// class _MessagingWidgetState extends State<MessagingWidget> {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//   final TextEditingController titleController =
//       TextEditingController(text: 'Title');
//   final TextEditingController bodyController =
//       TextEditingController(text: 'Body123');
//   final List<Message> messages = [];
//   localNotify.FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     localNotify.FlutterLocalNotificationsPlugin();
// final String serverToken = 'AAAAzGrPP3o:APA91bHaV1l2m2Nda5RgctdAAoZGoXtE3rN-gAurRWWx9ZLvqBcX94EuWK6DO4oDQzKOAQgaWzLeHSVq4fTWkyr9-ECDkeo3FeWPyJTD1wVYU6J7g2-zZlqS4aHRyCQ1JSBEv6nBt1aO';
// final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
// // localNotify.NotificationAppLaunchDetails flutterLocalNotificationsPlugin;
// String token;
//   @override
//   void initState() {
//     super.initState();

//     // _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
//     _firebaseMessaging.getToken().then((value) {
//       setState(() {
//         token = value;
//       });
//       print("token: $token");
//     });

//     // _firebaseMessaging.subscribeToTopic('all');

//     _firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         print("onMessage: $message");
//         final notification = message['notification'];
//         setState(() {
//           messages.add(Message(
//               title: notification['title'], body: notification['body']));
//         });
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         print("onLaunch: $message");

//         final notification = message['data'];
//         setState(() {
//           messages.add(Message(
//             title: '${notification['title']}',
//             body: '${notification['body']}',
//           ));
//         });
//       },
//       onResume: (Map<String, dynamic> message) async {
//         print("onResume: $message");
//       },
//     );
//     _firebaseMessaging.requestNotificationPermissions(
//         const IosNotificationSettings(sound: true, badge: true, alert: true));

//   localNotificationInitialize();
//     }
//   Future selectNotification(String payload) async {
//     if (payload != null) {
//       debugPrint('notification payload: ' + payload);
//     }
//     await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ChatPage()),
//     );
// }
//     @override
//     Widget build(BuildContext context) => Scaffold(
//         body: ListView(
//             children: [
//               TextFormField(
//                 controller: titleController,
//                 decoration: InputDecoration(labelText: 'Title'),
//               ),
//               TextFormField(
//                 controller: bodyController,
//                 decoration: InputDecoration(labelText: 'Body'),
//               ),
//               RaisedButton(
//                 onPressed: sendAndRetrieveMessage,
//                 child: Text('Send notification to all'),
//               ),
//             ]..addAll(messages.map(buildMessage).toList()),
//           ),
//     );
  
//     Widget buildMessage(Message message) => ListTile(
//           title: Text(message.title),
//           subtitle: Text(message.body),
//         );
  
//     Future sendNotification() async {
//       final response = await Messaging.sendToAll(
//         title: titleController.text,
//         body: bodyController.text,
//         // fcmToken: fcmToken,
//       );
  
//       if (response.statusCode != 200) {
//               Toast.show('[${response.statusCode}] Error message: ${response.body}', context,duration: Toast.LENGTH_LONG,gravity: Toast.TOP);
  
//       }
//     }
  
//     // void sendTokenToServer(String fcmToken) {
//     //   print('Token: $fcmToken');
//     //   // send key to your server to allow server to use
//     //   // this token to send push notifications
//     // }
  
//     Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
//     await firebaseMessaging.requestNotificationPermissions(
//       const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
//     );
  
//     await http.post(
//       'https://fcm.googleapis.com/fcm/send',
//        headers: <String, String>{
//          'Content-Type': 'application/json',
//          'Authorization': 'key=$serverToken',
//        },
//        body: jsonEncode(
//        <String, dynamic>{
//          'notification': <String, dynamic>{
//            'body': bodyController.text,
//            'title': titleController.text
//          },
//          'priority': 'high',
//          'data': <String, dynamic>{
//            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//            'id': '1',
//            'status': 'done'
//          },
//          'to': "dNKtturp-FI:APA91bHFeeSreESBt_yloaeB2LeFhfMtQwPSIsHJ4pfaanVjw6ZULy7aPDz9IUpzaj5eqCLFRuZEwxuv_ct5WRdX1oVJS3M9o0zntKT5j3qdWVHEaAIB7LsM_9QL5eUwYgOJ6OQqQHy3",
//        },
//       ),
//     );
  
//     final Completer<Map<String, dynamic>> completer =
//        Completer<Map<String, dynamic>>();
  
//     firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         completer.complete(message);
//          await _showNotification();
//       },
//     );
  
//     return completer.future;
//   }
  
//    Future onDidReceiveLocalNotification(
//         int id, String title, String body, String payload) async {
//       // display a dialog with the notification details, tap ok to go to another page
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => CupertinoAlertDialog(
//               title: Text(title),
//               content: Text(body),
//               actions: [
//                 CupertinoDialogAction(
//                   isDefaultAction: true,
//                   child: Text('Ok'),
//                   onPressed: () async {
//                     Navigator.of(context, rootNavigator: true).pop();
//                     // await Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(
//                     //     builder: (context) => SecondScreen(payload),
//                     //   ),
//                     // );
//                   },
//                 )
//               ],
//             ),
//       );
//     }
  
//     void localNotificationInitialize()async {

//   localNotify.FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = localNotify.FlutterLocalNotificationsPlugin();
//    var initializationSettingsAndroid = localNotify.AndroidInitializationSettings('icon1'); // <- default icon name is @mipmap/ic_launcher
//    var initializationSettingsIOS = localNotify.IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//    var initializationSettings = localNotify.InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
//    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String payload) async {
//     if (payload != null) {
//       debugPrint('notification payload: ' + payload);
//     }
//     // selectNotificationSubject.add(payload);
//   }); 
//     }

//       Future<void> _showNotification() async {
//     var androidPlatformChannelSpecifics = localNotify.AndroidNotificationDetails(
//         'your channel id', 'your channel name', 'your channel description',
//         importance: localNotify.Importance.Max, priority: localNotify.Priority.High, ticker: 'ticker');
//     var iOSPlatformChannelSpecifics = localNotify.IOSNotificationDetails();
//     var platformChannelSpecifics = localNotify.NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//          setState(() {
//           messages.add(Message(
//               title: titleController.text, body: bodyController.text));
//         });
         
//     await flutterLocalNotificationsPlugin.show(
//         0, titleController.text, bodyController.text, platformChannelSpecifics,
//         payload: 'item x');
//   }
// }