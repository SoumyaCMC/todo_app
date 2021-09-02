import 'package:flutter/material.dart';
import '../models/todo.dart';

class NewTodoView extends StatefulWidget {
  final Todo item;
  NewTodoView({this.item});
  @override
  _NewTodoViewState createState() => _NewTodoViewState();
}

class _NewTodoViewState extends State<NewTodoView> {
  TextEditingController titleController;

  @override
  void initState() {
    titleController = new TextEditingController(
        text: widget.item != null ? widget.item.title : null);
    super.initState();
  }

  void submit() => Navigator.of(context).pop(titleController.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item != null ? 'Edit Tasks' : 'Add new todo',
          key: Key('new-item-title'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              style: TextStyle(fontSize: 24),
              controller: titleController,
              onSubmitted: (value) => submit(),
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(
              height: 14.0,
            ),
            ElevatedButton(
              child: Container(
                width: double.infinity,
                height: 60,
                child: Center(
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onPressed: () => submit(),
            )
          ],
        ),
      ),
    );
  }
}
