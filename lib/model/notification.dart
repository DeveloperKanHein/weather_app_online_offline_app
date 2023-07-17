class Notification
{
  String? title;
  String? body;
  Notification({ this.title, this.body });
  factory Notification.fromJson(Map<String, dynamic> json) => Notification(title: json['title'], body: json['body']);
}