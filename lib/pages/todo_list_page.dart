import 'package:flutter/material.dart';
import 'package:todolist/widgets/todo_list_item.dart';
import 'package:todolist/models/todo.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();

  List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: todoController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Adicione uma tarefa',
                              hintText: 'Ex. Estudar Flutter',
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            String text = todoController.text;
                            setState(() {
                              Todo newTodo = Todo(title: text, dateTime: DateTime.now());
                              todos.add(newTodo);
                            });
                            todoController.clear();
                          },
                          child: Icon(
                            Icons.add,
                            size: 35,
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green, fixedSize: Size(60, 60)),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Flexible(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          for (Todo todo in todos) TodoListItem(todo: todo)
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text('Voce possui ${todos.length} tarefas pendentes'),
                        ),
                        Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  todos.clear();
                                });
                              },
                              child: Text('Limpar tudo'),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  fixedSize: Size(60, 60)),
                            ))
                      ],
                    ),
                  ],
                ))),
      ),
    );
  }
}
