import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Immutable class representing a dress card shown in-app.
/// 
/// Each dress card includes the dress' name, and its current
/// cleanliness status (represented by 0, 1, 2, 0 being the cleanest).
/// 
/// A dress card instance also stores the Timestamp of
/// the first instance of creation of the record, and 
/// the Timestamp of when it was last modified.
class DressCard with ChangeNotifier {
  /// Abstraction function:
  ///   AF(name, status, dateCreated, dateModified)
  ///     => a dress card with name `name`, with current cleanliness status represented
  ///        by `status`, created on `dateCreated`, and last modified on `dateModified`
  /// 
  /// Representation Invariant:
  ///   - name must be a non-empty string using only letters and numbers
  ///   - status must only take one of the values 0, 1, 2

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
