// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class FCM {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//   static Future<dynamic> onBackgroundMessage(
//       Map<String, dynamic> message) async {
//     if (message.containsKey('data')) {
//       final dynamic data = message['data'];
//     }
//     if (message.containsKey('notification')) {
//       final dynamic notification = message['notification'];
//     }
//   }
//
//   setNotification() {
//     _firebaseMessaging.configure(
//         onMessage: (message) async {
//           print('onMessage:$message');
//         },
//         onBackgroundMessage: onBackgroundMessage,
//         onLaunch: (message) async {
//           print('onLaunch:$message');
//         },
//         onResume: (message) async {
//           print('onResume:$message');
//         });
//     final token = _firebaseMessaging.getToken().then((value) => print(value));
//   }
// }
