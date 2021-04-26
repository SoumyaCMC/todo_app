import 'package:flutter/cupertino.dart';

class Task {
  final String title;
  final String description;
  final DateTime dateAssigned;
  final DateTime dateOfCompletion;
   bool isCompleted = false;

  Task({
    @required this.title,
    @required this.description,
    @required this.dateAssigned,
    @required this.dateOfCompletion,
    this.isCompleted,
  });
}
