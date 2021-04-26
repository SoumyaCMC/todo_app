import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:task_assigner/screens/addTask_screen.dart';
import 'package:task_assigner/screens/completed_screen.dart';
import 'package:task_assigner/screens/pending_screen.dart';

class UserTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Tasks'),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          textTheme: Theme.of(context).appBarTheme.textTheme,
          centerTitle: true,
          bottom: TabBar(
            labelColor: Colors.white,
            labelStyle: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: 18,
                ),
            indicatorColor: Colors.grey,
            indicator: MaterialIndicator(
              color: Colors.grey,
              bottomLeftRadius: 30,
              topRightRadius: 30,
              bottomRightRadius: 30,
              horizontalPadding: 8,
            ),
            tabs: [
              Tab(
                text: 'Pending',
              ),
              Tab(
                text: 'Completed',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PendingTasksScreen(),
            CompletedTasksScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: AddTaskScreen.routeName,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(AddTaskScreen.routeName);
          },
          backgroundColor: Theme.of(context).buttonColor,
        ),
      ),
    );
  }
}
