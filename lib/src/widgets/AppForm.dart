
import 'package:flutter/material.dart';

class AppForm extends StatelessWidget {
  AppForm({
    Key key,
    @required this.fields,
    @required this.submitBtn,
  }) : super(key: key);
  final List<Widget> fields;
  final Widget submitBtn;
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.topCenter,
      overflow: Overflow.visible,
      children: <Widget>[
        Card(
          elevation: 2.0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.pink,
            ),
            width: _width - 40,
            padding: EdgeInsets.all(10.0),
            height: 280.0,
            child: Column(
              children: fields
            )
          )
        ),
        Positioned(
          bottom: -15.0,
          child: submitBtn,
        )
      ],
    );
  }
}
