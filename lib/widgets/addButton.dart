import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:task_assigner/models/task.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddButton extends StatefulWidget {
  final Task task;

  AddButton(this.task);

  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? SpinKitRing(
            color: Theme.of(context).primaryColor,
          )
        : InkWell(
            borderRadius: BorderRadius.circular(40),
            splashColor: Colors.grey,
            onTap: () {
              setState(() {
                _isLoading = true;
              });
              FirebaseFirestore.instance.collection('tasks').add({
                'title': widget.task.title,
                'description': widget.task.description,
                'pendingDate': widget.task.dateAssigned,
                'addedOn': DateTime.now(),
                'isCompleted':false,
              }).then((_) {
                Navigator.of(context).pop();
                return setState(() {
                  _isLoading = false;
                });
              });
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              // margin: EdgeInsets.only(top: 25, right: 5, left: 15),
              width: 200,
              height: 65,

              decoration: BoxDecoration(
                color: Theme.of(context).buttonColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                'Add',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          );
  }
}
