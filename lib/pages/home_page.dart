import 'package:flutter/material.dart';
import 'package:calculator/widgets/but_tons.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';
  // Buttons//
  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion =
        finalQuestion.replaceAll("x", "*"); // Fix the multiplication operator
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      userAnswer = eval.toString();
    });
  }

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    '+',
    '6',
    '5',
    '4',
    'x',
    '3',
    '2',
    '1',
    '-',
    '0',
    'ANS',
    '.',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(20.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userQuestion,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userAnswer,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ))
            ],
          )),
          Expanded(
            flex: 2,
            child: Center(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  // Clean Button //
                  if (index == 0) {
                    return MyButtons(
                        buttonTapped: () {
                          setState(() {
                            userQuestion = '';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.green,
                        textColor: Colors.white);
                  }
                  // Delete button //
                  else if (index == 1) {
                    return MyButtons(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = userQuestion.substring(
                              0, userQuestion.length - 1);
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.red,
                      textColor: Colors.white,
                    );
                  }
                  // Equal Button //
                  else if (index == buttons.length - 1) {
                    return MyButtons(
                      buttonTapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                    );
                  }

                  // Rest the buttons //

                  else {
                    return MyButtons(
                      buttonTapped: () {
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? Colors.deepPurple
                          : Colors.deepPurple[50],
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.deepPurple,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

bool isOperator(String x) {
  if (x == '%' || x == '/' || x == '-' || x == '+' || x == '=' || x == 'x') {
    return true;
  }
  return false;
}
