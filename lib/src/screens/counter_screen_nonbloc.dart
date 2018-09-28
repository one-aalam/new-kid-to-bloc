import 'dart:async';
import 'package:flutter/material.dart';
import '../core/bloc.dart';
import '../blocs/counter_bloc.dart';

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;
  final StreamController<int> _streamController = StreamController<int>();

  @override
  dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CounterBloc bloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
        appBar: AppBar(title: Text('Counter Stream')),
        body: Center(
          child: StreamBuilder<int>(
            stream: _streamController.stream,
            initialData: _counter,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Text('You hit me ${snapshot.data} times!');
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            _streamController.sink.add(++_counter);
          },
        ));
  }
}
