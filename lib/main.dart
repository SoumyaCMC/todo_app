import 'package:flutter/material.dart';
import 'package:task_assigner/screens/addTask_screen.dart';
import 'package:task_assigner/screens/usert_task_screen.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TaskAssigner());
}

class TaskAssigner extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Assigner',
      theme: ThemeData(
          backgroundColor: Colors.black,
          primaryColor: Colors.grey,
          textTheme: ThemeData.dark().textTheme.copyWith(
                headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'ComicNeue',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                bodyText1: TextStyle(
                  fontSize: 18,
                  fontFamily: 'ComicNeue',
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                ),
                subtitle1: TextStyle(
                  fontSize: 15,
                  fontFamily: 'ComicNeue',
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  color: Colors.grey,
                ),
                //input text
                headline1: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'ComicNeue',
                ),
              ),
          appBarTheme: ThemeData.dark().appBarTheme.copyWith(
                backgroundColor: Colors.black,
                elevation: 0,
                textTheme: ThemeData.dark().textTheme.copyWith(
                      headline6: TextStyle(
                        fontSize: 35,
                        fontFamily: 'ComicNeue',
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                      ),
                    ),
              ),
          buttonColor: Colors.grey[800],
          buttonTheme: ThemeData.dark().buttonTheme.copyWith(
                buttonColor: Colors.grey[800],
              ),
          iconTheme: ThemeData.dark().iconTheme.copyWith(
                color: Colors.grey[600],
              )),
      home: UserTaskScreen(),
      routes: {
        AddTaskScreen.routeName: (ctx) => AddTaskScreen(),
      },
    );
  }
}
