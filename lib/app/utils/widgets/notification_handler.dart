import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Message received in background: ${message.notification?.title}');
}

class FirebaseMessagingHandler {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initPushNotification() async {
//allow user to give permission for notification
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
//get token messaging
    _firebaseMessaging.getToken().then((token) {
      print('FCM Token: $token');
    });
//handler terminated message
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("terminatedNotification : ${message!.notification?.title}");
    });
//handler onbackground message
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}
