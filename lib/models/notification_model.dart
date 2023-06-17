

/// /////////////////////////////////////

class NotificationModel {
  NotificationModel({
    required this.to,
    required this.notification,
    required this.data,
  });
  late final String to;
  late final AppNotification notification;
  late final Data data;

  NotificationModel.fromJson(Map<String, dynamic> json){
    to = json['to'];
    notification = AppNotification.fromJson(json['notification']);
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['to'] = to;
    _data['notification'] = notification.toJson();
    _data['data'] = data.toJson();
    return _data;
  }
}

class AppNotification {
  AppNotification({
    required this.title,
    required this.body,
    required this.mutableContent,
    required this.sound,
  });
  late final String title;
  late final String body;
  late final bool mutableContent;
  late final String sound;

  AppNotification.fromJson(Map<String, dynamic> json){
    title = json['title'];
    body = json['body'];
    mutableContent = json['mutable_content'];
    sound = json['sound'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['body'] = body;
    _data['mutable_content'] = mutableContent;
    _data['sound'] = sound;
    return _data;
  }
}

class Data {
  Data({
    required this.type,
    required this.id,
    required this.clickAction,
  });
  late final String type;
  late final String id;
  late final String clickAction;

  Data.fromJson(Map<String, dynamic> json){
    type = json['type'];
    id = json['id'];
    clickAction = json['click_action'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['id'] = id;
    _data['click_action'] = clickAction;
    return _data;
  }

}