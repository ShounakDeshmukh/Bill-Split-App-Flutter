// To parse this JSON data, do
//
//     final billUser = billUserFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<BillUser> billUserFromMap(String str) =>
    List<BillUser>.from(json.decode(str).map((x) => BillUser.fromMap(x)));

String billUserToMap(List<BillUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class BillUser {
  BillUser({
    required this.userId,
    required this.name,
    required this.email,
    required this.uuid,
  });

  String userId;
  String name;
  String email;
  String uuid;

  factory BillUser.fromMap(Map<String, dynamic> json) => BillUser(
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        uuid: json["uuid"],
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "name": name,
        "email": email,
        "uuid": uuid,
      };
}
