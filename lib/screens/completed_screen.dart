import 'package:flutter/material.dart';
import 'package:task_assigner/models/task.dart';
import 'package:task_assigner/widgets/taskCard.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class CompletedTasksScreen extends StatefulWidget {
  @override
  _CompletedTasksScreenState createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  List<Task> _completedTaskList;

  ScrollController _scrollController;

  int _currentMax = 5;

  @override
  void initState() {
    _getInitTasks();
    _completedTaskList = List.generate(
      5,
      (index) => Task(
          title: 'Demo Task',
          description:
              'This is a description hfhdfhd hdfhdhfd shfdhsfdojfldsfn dhsfhdhfhdsfkhsdb fhjshdjfsd hjdsfhdf huhsf dbfhdf ',
          dateAssigned: null,
          dateOfCompletion: null),
    );
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreTasks(); //as we reached the end of scroll
      }
    });
    super.initState();
  }

  void _getInitTasks() {}

  void _getMoreTasks() {
    print('getting more data');
    while (_completedTaskList.length <= _currentMax + 5) {
      _completedTaskList.add(
        Task(
            title: 'Demo Task',
            description:
                'This is a description hfhdfhd hdfhdhfd shfdhsfdojfldsfn dhsfhdhfhdsfkhsdb fhjshdjfsd hjdsfhdf huhsf dbfhdf ',
            dateAssigned: null,
            dateOfCompletion: null),
      );
    }
    _currentMax += 5;
    setState(() {
      //just to rebuild UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemBuilder: (ctx, index) {
        if (index == _completedTaskList.length)
          return SpinKitFadingCircle(
            color: Colors.white,
          );
        return TaskCard(_completedTaskList[index]);
      },
      itemCount: _completedTaskList.length,
    );
  }
}
