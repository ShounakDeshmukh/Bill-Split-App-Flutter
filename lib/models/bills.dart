import 'dart:convert';

import 'package:flutter/material.dart';

class Bill {
  Bill({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.createdBy,
    required this.createdAt,
    required this.status,
    required this.participants,
  });

  String id;
  String title;
  String description;
  double amount;
  String createdBy;
  int createdAt;
  String status;
  List<Participant> participants;

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        amount: json["amount"],
        createdBy: json["created_by"],
        createdAt: json["created_at"],
        status: json["status"],
        participants: List<Participant>.from(
            json["participants"].map((x) => Participant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "amount": amount,
        "created_by": createdBy,
        "created_at": createdAt,
        "status": status,
        "participants": List<dynamic>.from(participants.map((x) => x.toJson())),
      };
}

class Participant {
  Participant({
    required this.id,
    required this.paid,
  });

  String id;
  double paid;

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        id: json["id"],
        paid: json["paid"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "paid": paid,
      };
}

Future<List<Bill>> getbills(BuildContext context) async {
  final assetbundlelocal = DefaultAssetBundle.of(context);
  final data = await assetbundlelocal.loadString('assets/sample_bill.json');
  final body = json.decode(data);
  return List<Bill>.from(body.map((x) => Bill.fromJson(x)));
}
