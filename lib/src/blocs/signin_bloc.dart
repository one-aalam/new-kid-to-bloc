import 'dart:async';
import '../core/bloc.dart';
import '../core/validators.dart';

class SignInBloc extends Object with Validators implements BlocBase  {

  // Stream to handle the counter
  StreamController<String> _emailFieldController = StreamController<String>();
  StreamController<String> _passwordFieldController = StreamController<String>();

  Function(String) get onEmailInput => _emailFieldController.sink.add;
  Function(String) get onPasswordInput => _passwordFieldController.sink.add;

  Stream<String> get emailFieldOutput => _emailFieldController.stream.transform(validateEmail);
  Stream<String> get passwordFieldOutput => _passwordFieldController.stream.transform(validatePassword);

  void dispose() {
    _emailFieldController.close();
    _passwordFieldController.close();
  }
}