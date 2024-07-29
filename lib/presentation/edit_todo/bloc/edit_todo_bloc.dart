import 'package:bloc/bloc.dart';
import 'package:bloc_stream/data/data_source/todos_api.dart';
import 'package:bloc_stream/domain/model/todo.dart';
import 'package:equatable/equatable.dart';

part 'edit_todo_event.dart';
part 'edit_todo_state.dart';

class EditTodoBloc extends Bloc<EditTodoEvent, EditTodoState> {
  EditTodoBloc({
    required TodosApi todosApi,
    Todo? initialTodo,
  }) : super(const EditTodoState()) {
    on<EditTodoTitleChanged>((event, emit) {
      emit(state.copyWith(
        title: event.title,
        status: EditTodoStatus.initial,
      ));
    });

    on<EditTodoDescriptionChanged>((event, emit) {
      emit(state.copyWith(
        description: event.description,
        status: EditTodoStatus.initial,
      ));
    });

    on<EditTodoSubmitted>((event, emit) async {
      emit(state.copyWith(status: EditTodoStatus.loading));
      await todosApi.saveTodo(
        state.initialTodo?.copyWith(
              title: state.title,
              description: state.description,
            ) ??
            Todo(
              title: state.title,
              description: state.description,
            ),
      );
      emit(state.copyWith(status: EditTodoStatus.success));
    });
  }
}
