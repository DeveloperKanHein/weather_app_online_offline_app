import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class NotiReqBody{
  String? to;
  NotiBody? notification;
  NotiReqBody({ this.to, this.notification });
  Map<String, dynamic> toJson() => {
    'to': to,
    'notification': notification!.toJson(),
  };
}

@JsonSerializable()
class NotiBody{
  String? title;
  String? body;
  NotiBody({ this.title, this.body });
  Map<String, dynamic> toJson() => {
    'title': title,
    'body': body
  };
}