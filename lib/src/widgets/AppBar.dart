import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final double barHeight = 66.0;

  GradientAppBar(this.title);

  @override
  Size get preferredSize {
    return Size.fromHeight(barHeight);
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
      .of(context)
      .padding
      .top;

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
      child: new Center(
        child: new Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 36.0,
          )
        ),
      ),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            Colors.black,
            Color.fromRGBO(58, 66, 86, 1.0),
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.5, 0.0),
          stops: [0.0, 0.5],
          tileMode: TileMode.clamp
        ),
      ),
    );
  }
}