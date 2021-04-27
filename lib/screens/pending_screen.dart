import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_assigner/models/task.dart';
import 'package:task_assigner/widgets/taskCard.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PendingTasksScreen extends StatefulWidget {
  @override
  _PendingTasksScreenState createState() => _PendingTasksScreenState();
  PendingTasksScreen(this.needsReload);
  bool needsReload = false;
}

class _PendingTasksScreenState extends State<PendingTasksScreen> {
  List<Task> _pendingTaskList;

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
              _scrollController.position.maxScrollExtent &&
          _pendingTaskList.length >= 5) {
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
    _pendingTaskList = [];
    var collection = _taskRef.where('isCompleted', isNotEqualTo: true).limit(5);
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

    var collection = _taskRef
        .startAfterDocument(lastVisible)
        .where('isCompleted', isNotEqualTo: true)
        .limit(5);

    await fetchDocuments(collection);
  }

  Future<void> fetchDocuments(Query collection) async {
    await collection.get().then((value) {
      collectionState =
          value; // store collection state to set where to start next
      value.docs.forEach((element) {
        print('getDocuments ${element.data()}');
        setState(() {
          _pendingTaskList.add(
            Task(
              id: element.id,
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
    return (_pendingTaskList.length != 0)
        ? RefreshIndicator(
            backgroundColor: Colors.grey[900],
            color: Colors.grey,
            onRefresh: _getInitTasks,
            child: ListView.builder(
              controller: _scrollController,
              itemBuilder: (ctx, index) {
                if (index == _pendingTaskList.length &&
                    _pendingTaskList.length >= 5)
                  return SpinKitFadingCircle(
                    color: Colors.white,
                  );
                return Dismissible(
                    onDismissed: (direction) async {
                      
                      await _taskRef
                          .doc(
                        _pendingTaskList[index].id,
                      )
                          .update(
                        {'isCompleted': true},
                      );
                      _pendingTaskList.removeAt(index);
                      setState(() {});
                    },
                    background: Container(
                      padding: EdgeInsets.only(left: 15),
                      alignment: Alignment.centerLeft,
                      color: Theme.of(context).buttonColor,
                      child: Icon(
                        Icons.check,
                        size: 40,
                      ),
                    ),
                    direction: DismissDirection.startToEnd,
                    key: ValueKey(
                      _pendingTaskList[index].id,
                    ),
                    child: TaskCard(_pendingTaskList[index]));
              },
              itemCount: (_loadingProducts && _pendingTaskList.length >= 5)
                  ? _pendingTaskList.length + 1
                  : _pendingTaskList.length,
            ),
          )
        : (_loadingProducts)
            ? SpinKitFadingCircle(
                color: Colors.white,
              )
            : null;
  }
}
