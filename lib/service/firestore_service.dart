import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/data/token_data.dart';
import 'package:weather_app/logger/set_pretty_logger.dart';
import 'package:weather_app/model/notification.dart';
import 'package:weather_app/service/send_notification/noti_req_body.dart';
import 'package:weather_app/service/send_notification/send_notification.dart';

class FireStoreService
{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference deviceCollection = FirebaseFirestore.instance.collection('devices');
  CollectionReference notiCollection = FirebaseFirestore.instance.collection('notifications');

  Future<void> uploadToken({ required String token}) async
  {
    await deviceCollection.add({'token': token });
  }

  checkToken({ required String token }) async {
    final response = await deviceCollection.get();
    for(int i = 0; i < response.docs.length; i++) {
      final data = response.docs[i];
        if(token != data['token']){
          await uploadToken(token: token);
        }
    }
  }

  Future<void> sendNotiAllDevices({ required String title, required String body}) async {
    final notification = SendNotification(setPrettyLogger());
    final notiBody = NotiBody(title: title, body: body);
    final response = await deviceCollection.get();
    for(int i = 0; i < response.docs.length; i++) {
      final data = response.docs[i];
      final reqBody = NotiReqBody(
        to: data['token'],
        notification: notiBody,
      );
      await notification.send(TokenData.cloudMessageServerKey, reqBody);

      // await sendNotification(fcmKey: data['token'], title: "Testing", body: "Hello how are you");
    }
  }

  Future<List<Notification>> getAllNoti() async {
    final response = await notiCollection.get();
    List<Notification> notis = [];
    final docs = response.docs;
    for(int i = 0; i < docs.length; i++){
      Map<String,dynamic> data = docs[i].data() as Map<String, dynamic>;
      notis.add(Notification.fromJson(data));
    }

    return notis;
  }

}