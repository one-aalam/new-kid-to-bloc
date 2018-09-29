import 'dart:async';
import '../core/bloc.dart';

class CounterBloc implements BlocBase {
  int _counter = 0;


  // Stream to handle the counter
  StreamController<int> _counterController = StreamController<int>();
  StreamSink<int> get _counterInput => _counterController.sink;
  Stream<int> get counterOutput => _counterController.stream;


  // Stream to handle the action on the counter
  StreamController<int> _actionController = StreamController();
  StreamSink get incCounter => _actionController.sink;

  CounterBloc() {
    _counter = 0;
    _actionController.stream.listen(_handleLogic);
  }

  void dispose() {
    _counterController.close();
    _actionController.close();
  }


  void _handleLogic(data) {
    _counter = _counter + 1;
    _counterInput.add(_counter);
  }
}