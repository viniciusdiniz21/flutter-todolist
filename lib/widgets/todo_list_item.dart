import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/models/todo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({Key? key, required this.todo, required this.onDelete,}) : super(key: key);

  final Todo todo;
  final Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Slidable(
        actionPane: const SlidableStrechActionPane(),
        actionExtentRatio: 0.25,
        secondaryActions: [
          IconSlideAction(
            color:Colors.red,
            onTap: (){
              onDelete(todo);
            },
            icon: Icons.delete,
            caption: 'Delete',
          ),
        ],
        child: Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(
              DateFormat('dd/MM/yyyy - EE').format(todo.dateTime),
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            Text(
              todo.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ]),
        ),
      ),
    );
  }
}
