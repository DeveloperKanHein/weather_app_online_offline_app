import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  final localNotifications = FlutterLocalNotificationsPlugin();

  //Android
  final AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');

  //iOS
  final DarwinInitializationSettings initializationSettingsDarwin = const DarwinInitializationSettings();

  showNotification({required String title, required String body}) async {
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);

    await localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {},
    );

    const DefaultStyleInformation defaultStyleInformation = DefaultStyleInformation(true, true);
    //Android
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
            "weather-app-id",
            "Weather App",
            channelDescription: "Weather App News and Announcement",
            groupKey: "WeatherApp",
            setAsGroupSummary: true,
            styleInformation: defaultStyleInformation);

    //iOS
    const DarwinNotificationDetails iosNotificationDetail = DarwinNotificationDetails();

    NotificationDetails platformChannelSpecifics = const NotificationDetails(
        iOS: iosNotificationDetail,
        android: androidNotificationDetails);

    await localNotifications.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: "WeatherApp",
    );
  }

  Future<void> setup() async {
    String token = ""; //getDeviceToken();

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        showNotification(
            title: message.notification!.title ?? " ",
            body: message.notification!.body ?? "");
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {

    });

    // FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
    //   if (message.notification != null) {
    //     showNotification(
    //         title: message.notification!.title ?? " ",
    //         body: message.notification!.body ?? "");
    //   }
    // });
  }
}
