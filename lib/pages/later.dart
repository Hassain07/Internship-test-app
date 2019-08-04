import 'package:flutter/material.dart';
import 'package:intern_app/database/task_model.dart';

class MyLaterTaskPage extends StatefulWidget {
  final List<Task>laterTasks;
  MyLaterTaskPage({this.laterTasks});
  @override
  _MyLaterTaskPageState createState() => _MyLaterTaskPageState();
}

class _MyLaterTaskPageState extends State<MyLaterTaskPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("${widget.laterTasks[index].description}"),
            subtitle: Text("${widget.laterTasks[index].scheduledDate}"),
          );
      },
       itemCount: widget.laterTasks.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      
    );
  }
}