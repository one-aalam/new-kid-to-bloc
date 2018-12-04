import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  SectionHeading({
    @required this.text,
    this.icon,
    this.more
  });
  final String text;
  final IconData icon;
  final Widget more;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child:Row(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                child: Row(
                  children: [
                    Icon(icon, color: Colors.amber),
                    SizedBox(width:5.0),
                    Text(
                      text,
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.w800,
                        fontSize: 28.0,
                      )
                    ),
                  ]
                )
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: new EdgeInsets.only(right: 20.0),
                child: Text('View All', style: TextStyle(color:Colors.amber, decorationStyle: TextDecorationStyle.dashed)),
              ),
            )
          ],
        )
      );
  }
}