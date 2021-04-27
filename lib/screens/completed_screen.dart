import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_assigner/models/task.dart';
import 'package:task_assigner/widgets/taskCard.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class CompletedTasksScreen extends StatefulWidget {
  bool needsReload = false;

  CompletedTasksScreen(this.needsReload);

  @override
  _CompletedTasksScreenState createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  List<Task> _completedTaskList;

  ScrollController _scrollController;

  bool _loadingProducts = true;

  final _taskRef = FirebaseFirestore.instance.collection('tasks');

  @override
  void initState() {
    //for demo , we are generating a list
    _getInitTasks();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Timer(Duration(seconds: 2, milliseconds: 50), () {
          setState(() {
            _loadingProducts = false;
          });
        });
        _getMoreTasks(); //as we reached the end of scroll
      }
    });
    super.initState();
  }

  QuerySnapshot collectionState;

  Future<void> _getInitTasks() async {
    _completedTaskList = [];
    var collection = _taskRef.where('isCompleted',isEqualTo: true).limit(5);
    print('getDocuments');
    await fetchDocuments(collection);
  }

  // Fetch next 5 documents starting from the last document fetched earlier
  Future<void> _getMoreTasks() async {
    // Get the last visible document

    setState(() {
      _loadingProducts = true;
    });
    var lastVisible = collectionState.docs[collectionState.docs.length - 1];
    print('listDocument legnth: ${collectionState.size} last: $lastVisible');

    var collection = _taskRef.startAfterDocument(lastVisible).where('isCompleted',isEqualTo: true).limit(5);

    await fetchDocuments(collection);
  }

  Future<void> fetchDocuments(Query collection) async {
    await collection.get().then((value) {
      collectionState =
          value; // store collection state to set where to start next
      value.docs.forEach((element) {
        print('getDocuments ${element.data()}');
        setState(() {
          _completedTaskList.add(
            Task(
              title: element.data()['title'],
              description: element.data()['description'],
              dateAssigned: (element.data()['addedOn'] as Timestamp).toDate(),
              pendingDate:
                  (element.data()['pendingDate'] as Timestamp).toDate(),
            ),
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.needsReload) {
      _getInitTasks();
      setState(() {
        widget.needsReload = false;
      });
    }
    return (_completedTaskList.length != 0)
        ? RefreshIndicator(
            backgroundColor: Colors.grey[900],
            color: Colors.grey,
            onRefresh: _getInitTasks,
            child: ListView.builder(
              controller: _scrollController,
              itemBuilder: (ctx, index) {
                if (index == _completedTaskList.length &&
                    _completedTaskList.length >= 5)
                  return SpinKitFadingCircle(
                    color: Colors.white,
                  );
                return TaskCard(_completedTaskList[index]);
              },
              itemCount: (_loadingProducts && _completedTaskList.length >= 5)
                  ? _completedTaskList.length + 1
                  : _completedTaskList.length,
            ),
          )
        : (_loadingProducts)
            ? SpinKitFadingCircle(
                color: Colors.white,
              )
            : null;
  }
}
