// ignore_for_file: unnecessary_null_comparison, avoid_print, unused_element, prefer_const_constructors

import "package:flutter/material.dart";
import 'number.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> history = [];
  double resultHistory = 0;

  void addToHistory(String input) {
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
    print(history);
  }

  num calculate(List<String> expression) {
    try {
      bool isNumeric(String str) {
        if (str == null) {
          return false;
        }
        return double.tryParse(str) != null;
      }

      List<num> numbers = [];
      List<String> operators = [];

      for (String token in expression) {
        if (isNumeric(token)) {
          numbers.add(double.parse(token));
        } else if (token == '+' || token == '-') {
          while (operators.isNotEmpty &&
              (operators.last == '+' ||
                  operators.last == '-' ||
                  operators.last == 'X' ||
                  operators.last == '/')) {
            _applyOperator(numbers, operators);
          }
          operators.add(token);
        } else if (token == 'X' || token == '/') {
          while (operators.isNotEmpty &&
              (operators.last == 'X' || operators.last == '/')) {
            _applyOperator(numbers, operators);
          }
          operators.add(token);
        } else {
          throw FormatException('Invalid expression: Unknown token $token');
        }
      }

      while (operators.isNotEmpty) {
        _applyOperator(numbers, operators);
      }

      if (numbers.length != 1) {
        throw FormatException('Invalid expression: Extra operands');
      }

      return numbers.first;
    } catch (e) {
      print(e.toString());
      return double.parse(expression.first);
    }
  }

  void _applyOperator(List<num> numbers, List<String> operators) {
    String operator = operators.removeLast();
    num operand2 = numbers.removeLast();
    num operand1 = numbers.removeLast();

    if (operator == '+') {
      numbers.add(operand1 + operand2);
    } else if (operator == '-') {
      numbers.add(operand1 - operand2);
    } else if (operator == 'X') {
      numbers.add(operand1 * operand2);
    } else if (operator == '/') {
      if (operand2 == 0) {
        throw FormatException('Invalid expression: Division by zero');
      }
      numbers.add(operand1 / operand2);
    }
  }

  void clearHistory(String input) {
    setState(() {
      history = [];
    });
  }

  void clearLast(String input) {
    setState(() {
      history.removeLast();
    });
  }

  String historyArrayToString() {
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
              history.isEmpty ? "" : calculate(history).toString(),
              style: Theme.of(context).textTheme.titleLarge,
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
