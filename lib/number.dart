// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';

class NumberButton extends StatelessWidget {
  String number;
  Color color;
  Function onPressed;
  NumberButton(
      {this.number = "9", this.color = Colors.blue, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
          onPressed: () {
            onPressed(number);
          },
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return color;
                }
                return color; // Use the component's default.
              },
            ),
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              const StadiumBorder(),
            ),
          )),
      margin: const EdgeInsets.all(10),
    );
  }
}
