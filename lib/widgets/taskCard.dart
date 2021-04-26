import 'package:flutter/material.dart';
import 'package:task_assigner/models/task.dart';

class TaskCard extends StatelessWidget {
  Task task;

  TaskCard(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 6, bottom: 6),
      width: double.infinity,
      //height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Card(
        elevation: 5,
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SizedBox(height: 10),
            //title
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 12),
              child: Text(
                task.title,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.grey[300], fontSize: 26),
              ),
            ),
            //description
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 20, left: 25, right: 10),
              child: Text(
                task.description,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontSize: 16),
                softWrap: true,
              ),
            ),
            //due date , added on
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 20, left: 25, right: 10),
                  child: Text(
                    '5/8/2021',
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Colors.grey[300],
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 20, left: 25, right: 25),
                  child: Text(
                    '4/26/2021',
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Colors.grey[300],
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
