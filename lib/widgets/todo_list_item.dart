import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/models/todo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoListItem extends StatelessWidget {
const TodoListItem({ Key? key, required this.todo }) : super(key: key);

final Todo todo;

  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(DateFormat('dd/MM/yyyy - EE').format(todo.dateTime),style: TextStyle(fontSize: 12,),),
        Text(todo.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
      ]),
    );
  }
}