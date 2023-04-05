import 'dart:convert';

import 'package:flutter/material.dart';

// To parse this JSON data, do
//
//     final bill = billFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Bill> billFromMap(String str) =>
    List<Bill>.from(json.decode(str).map((x) => Bill.fromMap(x)));

String billToMap(List<Bill> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Bill {
  Bill({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.createdBy,
    required this.createdAt,
    required this.participants,
  });

  String id;
  String title;
  String description;
  double amount;
  String createdBy;
  int createdAt;
  List<Participant> participants;

  factory Bill.fromMap(Map<String, dynamic> json) => Bill(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        amount: json["amount"],
        createdBy: json["created_by"],
        createdAt: json["created_at"],
        participants: List<Participant>.from(
            json["participants"].map((x) => Participant.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "title": title,
        "description": description,
        "amount": amount,
        "created_by": createdBy,
        "created_at": createdAt,
        "participants": List<dynamic>.from(participants.map((x) => x.toMap())),
      };
}

class Participant {
  Participant({
    required this.owedBy,
    required this.toPay,
  });

  String owedBy;
  double toPay;

  factory Participant.fromMap(Map<String, dynamic> json) => Participant(
        owedBy: json["owed_by"],
        toPay: json["to_pay"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "owed_by": owedBy,
        "to_pay": toPay,
      };
}

Future<List<Bill>> getbills(BuildContext context) async {
  final assetbundlelocal = DefaultAssetBundle.of(context);
  final data = await assetbundlelocal.loadString('assets/sample_bill.json');
  final body = json.decode(data);
  return List<Bill>.from(body.map((x) => Bill.fromMap(x)));
}
