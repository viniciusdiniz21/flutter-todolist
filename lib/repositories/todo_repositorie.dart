import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/models/todo.dart';
import 'dart:convert';

class TodoRepositorie {

  Future <List<Todo>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString('todo_list') ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Todo.fromJson(e)).toList();
  }

  late SharedPreferences sharedPreferences;

  void SaveTodoList (List<Todo> todos) {
    final String jsonString = json.encode(todos);
    sharedPreferences.setString('todo_list', jsonString);
  }
}