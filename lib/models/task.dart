import 'package:flutter/cupertino.dart';

class Task {
  final String title;
  final String description;
  final DateTime dateAssigned;
  final DateTime pendingDate;
   bool isCompleted = false;

  Task({
    @required this.title,
    @required this.description,
    @required this.dateAssigned,
    @required this.pendingDate,
    this.isCompleted,
  });
}
