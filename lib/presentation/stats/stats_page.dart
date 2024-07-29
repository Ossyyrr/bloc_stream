import 'package:bloc_stream/data/data_source/todos_api.dart';
import 'package:bloc_stream/presentation/stats/bloc/stats_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StatsBloc(api: context.read<TodosApi>())..add(const InitialEvent()),
      child: const StatsView(),
    );
  }
}

class StatsView extends StatelessWidget {
  const StatsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Complete: ${context.watch<StatsBloc>().state.getComplete}'),
            Text(
                'Uncomplete: ${context.watch<StatsBloc>().state.getUncomplete}'),
          ],
        ),
      ),
    );
  }
}
