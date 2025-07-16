import 'dart:convert';
import 'package:chat_ai/app/modules/home/models/message_model.dart';

class HistoryModel {
  List<MessageModel> messages;
  DateTime time;

  HistoryModel({List<MessageModel>? messages, DateTime? time})
    : messages = messages ?? [],
      time = time ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'messages': jsonEncode(messages.map((m) => m.toJson()).toList()),
      'time': time,
    };
  }

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    final jsonMessage =
        jsonDecode(json['message']) as List<Map<String, dynamic>>;
    final messages = jsonMessage.map((m) => MessageModel.fromJson(m)).toList();
    return HistoryModel(messages: messages, time: json['time']);
  }
}
