import 'dart:async';
import 'dart:convert';

import 'package:bloc_stream/data/data_source/todos_api.dart';
import 'package:bloc_stream/domain/model/todo.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodosApiImp implements TodosApi {
  final SharedPreferences _sharedPreferences;
  late final _streamController = BehaviorSubject<List<Todo>>.seeded(const []);
  static const _keyTodos = 'todos';

  Future<void> _setValue(String key, String value) =>
      _sharedPreferences.setString(key, value);

  TodosApiImp({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences {
    final jsonString = _sharedPreferences.getString(_keyTodos);
    if (jsonString != null) {
      final todos = (json.decode(jsonString) as List)
          .cast<Map<String, dynamic>>()
          .map((todo) => Todo.fromJson(todo))
          .toList();
      _streamController.add(todos);
    }
  }

  @override
  Stream<List<Todo>> getTodos() => _streamController.stream;

  @override
  Future<int> clearCompleted() async {
    final List<Todo> todos = [..._streamController.value];
    final uncompletedTodos = todos.where((todo) => !todo.isCompleted).toList();
    _streamController.add(uncompletedTodos);
    _setValue(_keyTodos, json.encode(uncompletedTodos));

    return todos.length - uncompletedTodos.length;
  }

  @override
  Future<void> close() => _streamController.close();

  @override
  Future<int> completeAll({required bool isCompleted}) {
    final List<Todo> todos = [..._streamController.value];
    final updatedTodos =
        todos.map((todo) => todo.copyWith(isCompleted: isCompleted)).toList();
    _streamController.add(updatedTodos);
    _setValue(_keyTodos, json.encode(updatedTodos));
    return Future.value(updatedTodos.length);
  }

  @override
  Future<void> deleteTodo(String id) {
    final todos = [..._streamController.value];
    final todoIndex = todos.indexWhere((todo) => todo.id == id);

    if (todoIndex < 0) throw TodoNotFoundException();

    todos.removeAt(todoIndex);
    _streamController.add(todos);
    _setValue(_keyTodos, json.encode(todos));
    return _setValue(_keyTodos, json.encode(todos));
  }

  @override
  Future<void> saveTodo(Todo todo) {
    final todos = [..._streamController.value];
    final todoIndex = todos.indexWhere((t) => t.id == todo.id);
    if (todoIndex >= 0) {
      todos[todoIndex] = todo;
    } else {
      todos.add(todo);
    }

    _streamController.add(todos);
    return _setValue(_keyTodos, json.encode(todos));
  }
}
