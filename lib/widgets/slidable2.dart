/* import 'package:flutter/material.dart';
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
        endActionPane: ActionPane(motion: const ScrollMotion(),extentRatio: 0.25, children: [
          SlidableAction(
            onPressed: onDelete(todo),
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ]),
        child: Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(
              DateFormat('dd/MM/yyyy - EE').format(todo.dateTime),
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            Text(
              todo.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ]),
        ),
      ),
    );
  }
}
 */