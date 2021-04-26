import 'package:flutter/material.dart';
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
        primaryColor: Colors.white,
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
        buttonColor: Colors.grey,
      ),
      home: UserTaskScreen(),
    );
  }
}
