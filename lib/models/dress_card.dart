import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DressCard with ChangeNotifier {
  String name;
  int status;
  Timestamp dateCreated;
  Timestamp dateModified;

  DressCard(
      {required this.name,
      required this.status,
      required this.dateCreated,
      required this.dateModified});

  DressCard.fromJson(Map<String, dynamic> json)
      : this(
            name: json['name'] as String,
            status: json['status'] as int,
            dateCreated: json['dateCreated'],
            dateModified: json['dateModified']);

  DressCard copyWith(
      String? name, int? status, Timestamp? dateModified) {
    return DressCard(
        name: name ?? this.name,
        status: status ?? this.status,
        dateCreated: dateCreated,
        dateModified: dateModified ?? this.dateModified);
  }

  Map<String, Object> toJson() {
    return {
      'name': name,
      'status': status,
      'dateCreated': dateCreated,
      'dateModified': dateModified
    };
  }
}
