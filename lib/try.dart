// ignore_for_file: unnecessary_null_comparison, avoid_print, unused_element

import "package:flutter/material.dart";
import 'number.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var history = [];
  double resultHistory = 0;

  addToHistory(String input) {
    setState(() {
      if (history.isEmpty &&
          !(input == "+" || input == "-" || input == "X" || input == "/")) {
        history.add(input);
      } else if (history.last == "+" ||
          history.last == "-" ||
          history.last == "X" ||
          history.last == "/") {
        if (!(input == "+" || input == "-" || input == "X" || input == "/")) {
          history.add(input);
        } else {
          history.removeLast();
          history.add(input);
        }
      } else {
        if (input == "+" || input == "-" || input == "X" || input == "/") {
          history.add(input);
        } else {
          double n = double.parse(history.last);
          n = (n * 10) + double.parse(input);
          history.removeLast();
          history.add(n.toString());
        }
      }
    });
  }

  calculate() {
    var result = 0.0;
    var num1 = 0.0;
    var num2 = 0.0;
    var op = "";
    for (var i = 0; i < history.length; i++) {
      if (i == 0) {
        num1 = double.parse(history[i]);
        result = num1;
      } else {
        if (i % 2 == 1) {
          op = history[i];
        } else {
          num2 = double.parse(history[i]);
          if (op == "+") {
            result = num1 + num2;
          } else if (op == "-") {
            result = num1 - num2;
          } else if (op == "X") {
            result = num1 * num2;
          } else if (op == "/") {
            result = num1 / num2;
          }
          num1 = result;
        }
      }
    }
    return result.toString();
  }

  clearHistory(String input) {
    setState(() {
      history = [];
    });
  }

  clearLast(String input) {
    setState(() {
      history.removeLast();
    });
  }

  historyArrayToString() {
    String historyString = "";
    for (var i = 0; i < history.length; i++) {
      historyString = historyString + history[i] + " ";
    }
    if (historyString.isNotEmpty) {
      historyString = historyString + " = ";
    }
    return historyString;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            height: 100,
            width: double.infinity,
            child: Text(
              historyArrayToString(),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              textAlign: TextAlign.end,
            ),
            margin: const EdgeInsets.only(right: 50),
            padding: const EdgeInsets.all(10),
          ),
          Container(
            height: 60,
            width: double.infinity,
            child: Text(
              calculate(),
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.end,
            ),
            margin: const EdgeInsets.only(right: 50),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    NumberButton(
                      number: '9',
                      onPressed: addToHistory,
                    ),
                    NumberButton(number: '8', onPressed: addToHistory),
                    NumberButton(number: '7', onPressed: addToHistory),
                    NumberButton(
                        number: '+',
                        color: Colors.yellow,
                        onPressed: addToHistory),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    NumberButton(number: '6', onPressed: addToHistory),
                    NumberButton(number: '5', onPressed: addToHistory),
                    NumberButton(number: '4', onPressed: addToHistory),
                    NumberButton(
                        number: '-',
                        color: Colors.yellow,
                        onPressed: addToHistory),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    NumberButton(number: '3', onPressed: addToHistory),
                    NumberButton(number: '2', onPressed: addToHistory),
                    NumberButton(number: '1', onPressed: addToHistory),
                    NumberButton(
                        number: 'X',
                        color: Colors.yellow,
                        onPressed: addToHistory),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    NumberButton(
                        number: 'AC',
                        color: Colors.red,
                        onPressed: clearHistory),
                    NumberButton(number: '0', onPressed: addToHistory),
                    NumberButton(
                        number: 'C', color: Colors.red, onPressed: clearLast),
                    NumberButton(
                        number: '/',
                        color: Colors.yellow,
                        onPressed: addToHistory),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
