import 'package:flutter/material.dart';

class GenreChip extends StatelessWidget {
  GenreChip(this.label);
  final String label;
  @override
  Widget build(BuildContext context) {
    return
                            Container(
                              padding: EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2.0),
                              child: Text(
                                label,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                ),
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(2.0)
                              ),

    );
  }
}