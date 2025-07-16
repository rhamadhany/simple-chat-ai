class MessageModel {
  bool user;
  String message;
  DateTime time;
  MessageModel({bool? user, String? message, DateTime? time})
    : user = user ?? true,
      message = message ?? '',
      time = time ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {'user': user, 'message': message, 'time': time};
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      user: json['user'],
      message: json['message'],
      time: json['time'],
    );
  }
}
