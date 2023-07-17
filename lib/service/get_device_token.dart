import 'package:firebase_messaging/firebase_messaging.dart';

Future<String> getDeviceToken() async
{
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  return fcmToken ?? "";
}