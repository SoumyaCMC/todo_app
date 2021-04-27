import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:task_assigner/models/task.dart';
import 'package:task_assigner/widgets/addButton.dart';

class AddTaskScreen extends StatefulWidget {
  static const routeName = '/addTaskScreen';
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  FocusNode _descriptionFocusNode = FocusNode();
  FocusNode _titleFocusNode = FocusNode();

  Future<void> _showCalendar(BuildContext context) async {
    _descriptionFocusNode.unfocus();
    _titleFocusNode.unfocus();
    await showRoundedDatePicker(
      theme: ThemeData.dark(),
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(
        Duration(days: 1),
      ),
      lastDate: DateTime.now().add(
        Duration(days: 31),
      ),
    ).then((pickedDate) {
      if (pickedDate == null) pickedDate = DateTime.now();
      return setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  void dispose() {
    _descriptionFocusNode.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Hero(
      tag: AddTaskScreen.routeName,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Add Task'),
          centerTitle: true,
          iconTheme: Theme.of(context).iconTheme,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //title
                Container(
                  margin: EdgeInsets.only(top: 30, left: 5, right: 5),
                  width: deviceSize.width * 0.85,
                  child: TextField(
                    //focusNode: _titleFocusNode,
                    autofocus: true,
                    controller: _titleController,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headline1,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      contentPadding: EdgeInsets.all(20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[600],
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[600],
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[600],
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      fillColor: Colors.grey[600],
                      filled: true,
                    ),
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) {
                      Focus.of(context).requestFocus(_descriptionFocusNode);
                    },
                  ),
                ),
                //description
                Container(
                  margin: EdgeInsets.only(top: 60, right: 5, left: 5),
                  width: deviceSize.width * 0.85,
                  height: 200,
                  child: TextField(
                    focusNode: _descriptionFocusNode,
                    minLines: 4,
                    maxLines: 5,
                    controller: _descriptionController,
                    style: Theme.of(context).textTheme.headline1,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      contentPadding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 15),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[600],
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[600],
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[600],
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      fillColor: Colors.grey[600],
                      filled: true,
                    ),
                    textInputAction: TextInputAction.newline,
                  ),
                ),
                //pending Date
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 65,
                      margin: EdgeInsets.only(top: 15, right: 10, left: 25),
                      child: GestureDetector(
                        onTap: () {
                          print(DateTime.now());
                          _showCalendar(context);
                        },
                        child: Icon(
                          Icons.calendar_today,
                          size: 50,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print(DateTime.now());
                        _showCalendar(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.only(top: 25, right: 5, left: 15),
                        width: deviceSize.width * 0.65,
                        height: 65,
                        decoration: BoxDecoration(
                          color: Theme.of(context).iconTheme.color,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Text(
                          DateFormat('dd/MM/yy').format(
                            _selectedDate,
                          ),
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                AddButton(
                  Task(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      dateAssigned: DateTime.now(),
                      pendingDate: _selectedDate),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
