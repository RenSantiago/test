import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirestore {
  String? id;
  String username;
  String email;
  String password;
  Timestamp? createdOn;
  Timestamp? updatedOn;

  UserFirestore({
    this.id,
    required this.username,
    required this.email,
    required this.password,
     this.createdOn,
     this.updatedOn
  });

  UserFirestore.fromJson(Map<String, Object?> json) : this(
      email: json['email'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      createdOn: json['createdOn'] as Timestamp,
      updatedOn: json['updatedOn'] as Timestamp
  );

  UserFirestore copyWith({
    String? email,
    String? username,
    String? password,
    Timestamp? createdOn,
    Timestamp? updatedOn}) {
    return UserFirestore(
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        createdOn: createdOn ?? this.createdOn,
        updatedOn: updatedOn ?? this.updatedOn);
  }

  Map<String, Object?> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'createdOn': createdOn,
      'updatedOn': updatedOn
    };
  }
}
