import 'dart:convert';

class User {
  String password;
  String username;

  User({required this.password, required this.username});
  factory User.fromJson(Map<String, dynamic> json) {
    print(json['username']);

    return User(
      password: json['password'],
      username: json['username'],
    );
  }
}
