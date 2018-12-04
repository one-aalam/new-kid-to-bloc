import 'package:flutter/material.dart';

class RatingChip extends StatelessWidget {
  RatingChip(this.label);
  final String label;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
                            Icon(Icons.star),
                            SizedBox(width: 4.0),
                            Container(
                              padding: EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2.0),
                              child: Text(
                                label,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16.0,
                                ),
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(2.0)
                              ),
                            ),
      ]
    );
  }
}