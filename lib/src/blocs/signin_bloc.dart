import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../core/bloc.dart';
import '../core/validators.dart';

class SignInBloc extends Object with Validators implements BlocBase  {

  // Behavior subject to handle the fields
  final _emailField = BehaviorSubject<String>();
  final _passwordField = BehaviorSubject<String>();

  // Stream controller
  // StreamController<String> _emailFieldController = StreamController<String>.broadcast();
  // StreamController<String> _passwordFieldController = StreamController<String>.broadcast();

  Function(String) get onEmailInput => _emailField.sink.add;
  Function(String) get onPasswordInput => _passwordField.sink.add;

  Stream<String> get emailFieldOutput => _emailField.stream.transform(validateEmail);
  Stream<String> get passwordFieldOutput => _passwordField.stream.transform(validatePassword);
  Stream<bool> get canEnableSubmission => Observable.combineLatest2(
    emailFieldOutput,
    passwordFieldOutput,
    (e, p) {
      return true;
    }
  );

  void submit() {
    print('Email: ${_emailField.value} and ${_passwordField.value}');
  }

  void dispose() {
    _emailField.close();
    _passwordField.close();
  }
}