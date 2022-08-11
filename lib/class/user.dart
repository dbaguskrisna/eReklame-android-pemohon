import 'dart:convert';

class Users {
  String password;
  String username;

  Users({required this.password, required this.username});
  factory Users.fromJson(Map<String, dynamic> json) {
    print(json['username']);

    return Users(
      password: json['password'],
      username: json['email'],
    );
  }
}
