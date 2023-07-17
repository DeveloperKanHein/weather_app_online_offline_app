import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'noti_req_body.dart';

part 'send_notification.g.dart';

@RestApi(baseUrl: "https://fcm.googleapis.com/")
abstract class SendNotification {
  factory SendNotification(Dio dio, {String baseUrl}) = _SendNotification;

  @POST("fcm/send")
  Future<dynamic> send(
      @Header("Authorization") String? serverKey,
      @Body() NotiReqBody notiReqBody,
      );
}