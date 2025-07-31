import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String name;
  String userName;
  String userImage;
  Timestamp dob;
  String userEmail;

  UserModel({
    required this.name,
    required this.uid,
    required this.userName,
    required this.userImage,
    required this.dob,
    required this.userEmail,
  });
  // Convert a UserModel to a Map (to store in Firestore)
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'userName': userName,
      'userImage': userImage,
      'dob': dob,
      'userEmail': userEmail,
    };
  }

  // Create a UserModel from a Map (retrieved from Firestore)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      userName: json['userName'] ?? '',
      userImage: json['userImage'] ?? '',
      dob: json['dob'] ?? Timestamp(0, 0),
      userEmail: json['userEmail'] ?? '',
    );
  }
}
