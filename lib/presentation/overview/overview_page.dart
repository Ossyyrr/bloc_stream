import 'package:bloc_stream/data/data_source/todos_api.dart';
import 'package:bloc_stream/domain/model/todo.dart';
import 'package:bloc_stream/presentation/overview/bloc/overview_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OverviewBloc(api: context.read<TodosApi>())
        ..add(const OverviewStarted()),
      child: const OverviewView(),
    );
  }
}

class OverviewView extends StatelessWidget {
  const OverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: TodoList(),
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Todo> todos =
        context.select((OverviewBloc bloc) => bloc.state.todos);

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return TodoListTile(todo: todos[index]);
      },
    );
  }
}

class TodoListTile extends StatelessWidget {
  const TodoListTile({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todo.isCompleted,
        onChanged: (value) {},
      ),
      title: Text(todo.title),
      subtitle: Text(todo.description),
    );
  }
}
