import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_assigner/models/todo.dart';
import 'package:task_assigner/screens/new_todo.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  //----------------------------------------------------------------------------
  List<Todo> list = [];
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    loadData();
    super.initState();
  }
  //----------------------------------------------------------------------------

  Widget emptyList() {
    return Center(child: Text('No items', style: TextStyle(fontSize: 18)));
  }

  //----------------------------------------------------------------------------

  Widget buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) =>
          buildItem(list[index], index),
    );
  }

  Widget buildItem(Todo item, index) {
    return Dismissible(
      key: Key('${item.hashCode}'),
      background: Container(color: Colors.red[700]),
      onDismissed: (direction) => removeItem(item),
      direction: DismissDirection.startToEnd,
      child: buildListItem(item, index),
    );
  }

  Widget buildListItem(Todo item, int index) {
    return ListTile(
      onTap: () => markAsDone(item),
      onLongPress: () => goToEditItemView(item),
      leading: Text((index + 1).toString()),
      title: Text(
        item.title,
        key: Key('item-$index'),
        style: TextStyle(
            color: item.completed ? Colors.grey : Colors.black,
            decoration: item.completed ? TextDecoration.lineThrough : null),
      ),
      trailing: Icon(
        item.completed ? Icons.check_box : Icons.check_box_outline_blank,
        key: Key('completed-icon-$index'),
      ),
    );
  }

  //----------------------------------------------------------------------------

  void goToNewItemView() async {
    // Here we are pushing the new view into the Navigator stack. By using a
    // MaterialPageRoute we get standard behaviour of a Material app, which will
    // show a back button automatically for each platform on the left top corner
    MaterialPageRoute newItemView =
        MaterialPageRoute(builder: (context) => NewTodoView());

    dynamic result = await Navigator.of(context).push(newItemView);

    if (result != null) addItem(Todo(title: result.toString()));
  }

  void goToEditItemView(item) async {
    // We re-use the NewTodoView and push it to the Navigator stack just like
    // before, but now we send the title of the item on the class constructor
    // and expect a new title to be returned so that we can edit the item

    MaterialPageRoute editItemView =
        MaterialPageRoute(builder: (context) => NewTodoView(item: item));

    dynamic result = await Navigator.of(context).push(editItemView);

    if (result != null) editItem(item, result.toString());
  }

  //----------------------------------------------------------------------------

  void addItem(Todo item) async {
    // Insert an item into the top of our list, on index zero
    list.insert(0, item);
    await saveData();
  }

  void editItem(Todo item, String title) async {
    item.title = title;
    await saveData();
  }

  void removeItem(Todo item) async {
    list.remove(item);
    await saveData();
  }

  void markAsDone(Todo item) async {
    setState(() {
      item.completed = !item.completed;
    });
    await saveData();
  }

  //----------------------------------------------------------------------------

  void loadData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    List<String> listString = sharedPreferences.getStringList('list');
    if (listString != null) {
      setState(() {
        list =
            listString.map((item) => Todo.fromMap(json.decode(item))).toList();
      });
    }
  }

  Future saveData() async {
    List<String> stringList =
        list.map((item) => json.encode(item.toMap())).toList();
    await sharedPreferences.setStringList('list', stringList);
    setState(() {});
  }

  //----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'FlutterTodo',
            key: Key('main-app-title'),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => goToNewItemView(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 20),
            list.isEmpty ? emptyList() : buildListView(),
          ]),
        ));
  }

  //----------------------------------------------------------------------------
}
