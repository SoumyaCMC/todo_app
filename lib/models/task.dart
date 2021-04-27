import 'package:flutter/cupertino.dart';

class Task {
   String id;
  final String title;
  final String description;
  final DateTime dateAssigned;
  final DateTime pendingDate;
  bool isCompleted = false;

  Task({
    this.id,
    @required this.title,
    @required this.description,
    @required this.dateAssigned,
    @required this.pendingDate,
    this.isCompleted,
  });
}
