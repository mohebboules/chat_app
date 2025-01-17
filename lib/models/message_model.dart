import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String body;
  String id;
  Timestamp date;

  MessageModel({required this.body, required this.id, required this.date});
  factory MessageModel.fromJson(jsonData) => MessageModel(
        body: jsonData[kMessageKey],
        id: jsonData[kId],
        date: jsonData[kCreatedAt],
      );
}
