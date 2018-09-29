import 'package:flutter/material.dart';
import '../core/bloc.dart';
import '../blocs/signin_bloc.dart';

class SignInScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final SignInBloc bloc = BlocProvider.of<SignInBloc>(context);

    return new Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: [
          // Email
          StreamBuilder(
            stream: bloc.emailFieldOutput,
            initialData: '',
            builder: (context, snapshot) {
              return TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'you@example.com',
                  labelText: 'Email Address',
                  errorText: snapshot.error
                ),
                onChanged: bloc.onEmailInput,
              );
            },
          ),
          // Password
          StreamBuilder(
            stream: bloc.passwordFieldOutput,
            initialData: '',
            builder: (context, snapshot) {
              return TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                  errorText: snapshot.error
                ),
                onChanged: bloc.onPasswordInput,
              );
            }
          ),

          //
          StreamBuilder(
            stream: bloc.canEnableSubmission,
            builder: (context, snapshot) {
              return RaisedButton(
                child: Text('Sign In'),
                color: Colors.amber,
                onPressed: snapshot.hasError || !snapshot.hasData ? null : bloc.submit,
              );
            }
          )
        ]
      ),
    );
  }

  //StreamBuilder withStreamBuilder(bloc, )

  // Widget emailFormField(SignInBloc bloc) {
  //   return StreamBuilder(
  //     stream: bloc.emailFieldOutput,
  //     builder: (context, snapshot) {
  //       return TextField(
  //         keyboardType: TextInputType.emailAddress,
  //         decoration: InputDecoration(
  //           hintText: 'you@example.com',
  //           labelText: 'Email Address',
  //           errorText: snapshot.error
  //         ),
  //         onChanged:(val) {
  //           bloc.emailFieldInput.add(val);
  //         },
  //       );
  //     },
  //   );
  // }
}