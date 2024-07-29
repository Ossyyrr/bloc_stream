import 'package:bloc_stream/data/data_source/todos_api.dart';
import 'package:bloc_stream/data/data_source/todos_api_impl.dart';
import 'package:bloc_stream/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // List<Todo> todos = [
  //   Todo(
  //     title: 'Learn Flutter',
  //     description:
  //         'Learn how to build beautiful Android and iOS apps with Flutter and Dart.',
  //   ),
  //   Todo(
  //     title: 'Build Apps',
  //     description: 'Build apps for your startup or side-project.',
  //   ),
  //   Todo(
  //     title: 'Become a Flutter GDE',
  //     description: 'Become a Google Developer Expert in Flutter.',
  //   ),
  // ];

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // await sharedPreferences.clear();
  final todoApiImpl = TodosApiImp(sharedPreferences: sharedPreferences);

  // for (var todo in todos) {
  //   await todoApiImpl.saveTodo(todo);
  // }

  runApp(App(todoApiImpl: todoApiImpl));
}

class App extends StatelessWidget {
  const App({required this.todoApiImpl, super.key});

  final TodosApiImp todoApiImpl;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<TodosApi>.value(
      value: todoApiImpl,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
