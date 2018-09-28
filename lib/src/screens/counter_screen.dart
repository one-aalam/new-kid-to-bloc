import 'package:flutter/material.dart';
import '../core/bloc.dart';
import '../blocs/counter_bloc.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc bloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
        appBar: AppBar(title: Text('Counter Stream')),
        body: Center(
          child: StreamBuilder<int>(
            stream: bloc.counterOutput,
            initialData: 0,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Text('You hit me ${snapshot.data} times!');
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            bloc.incCounter.add(null);
          },
        ));
  }
}