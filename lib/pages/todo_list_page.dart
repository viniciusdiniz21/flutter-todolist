import 'package:flutter/material.dart';
import 'package:todolist/widgets/todo_list_item.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/repositories/todo_repositorie.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();
  final TodoRepositorie todoRepositorie = TodoRepositorie();

  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoIndex;

  String? errorText;

  @override
  void initState() {
    super.initState();
    todoRepositorie.getTodoList().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

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
                              border: const OutlineInputBorder(),
                              labelText: 'Adicione uma tarefa',
                              hintText: 'Ex. Estudar Flutter',
                              errorText: errorText,
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2),
                              ),
                              labelStyle: const TextStyle(color: Colors.green),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            String text = todoController.text;

                            if (text.isEmpty) {
                              setState(() {
                                errorText = 'O campo não pode ser vazio';
                              });
                              return;
                            }

                            setState(() {
                              Todo newTodo =
                                  Todo(title: text, dateTime: DateTime.now());
                              todos.add(newTodo);
                              errorText = null;
                            });
                            todoController.clear();
                            todoRepositorie.SaveTodoList(todos);
                          },
                          child: const Icon(
                            Icons.add,
                            size: 35,
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green, fixedSize: const Size(60, 60)),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Flexible(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          for (Todo todo in todos)
                            TodoListItem(todo: todo, onDelete: onDelete)
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                              'Voce possui ${todos.length} tarefas pendentes'),
                        ),
                        Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: showDeleteTodosConfirmation,
                              child: const Text('Limpar tudo'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  fixedSize: const Size(60, 60)),
                            ))
                      ],
                    ),
                  ],
                ))),
      ),
    );
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoIndex = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });
    todoRepositorie.SaveTodoList(todos);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tarefa ${todo.title} foi removida com sucesso',
          style: const TextStyle(color: Color(0xff060708)),
        ),
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.grey[300],
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: Colors.green,
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoIndex!, deletedTodo!);
              todoRepositorie.SaveTodoList(todos);
            });
          },
        ),
      ),
    );
  }

  void showDeleteTodosConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir todas as tarefas'),
        content: const Text('Voce tem certeza que deseja limpar a lista?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                todos.clear();
              });
              todoRepositorie.SaveTodoList(todos);
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}
