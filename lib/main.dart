import 'package:flutter/material.dart';
import 'calculator_logic.dart'; // Import your CalculatorLogic class

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _number1Controller = TextEditingController();
  final TextEditingController _number2Controller = TextEditingController();
  String _result = '';

  // Create an instance of the CalculatorLogic class
  CalculatorLogic _calculator = CalculatorLogic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text fields for entering numbers
            TextField(
              controller: _number1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Enter Number 1'),
            ),
            TextField(
              controller: _number2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Enter Number 2'),
            ),

            // Row of buttons for calculator operations
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CalculatorButton(
                  text: '+',
                  onPressed: () {
                    _calculate('+');
                  },
                ),
                CalculatorButton(
                  text: '-',
                  onPressed: () {
                    _calculate('-');
                  },
                ),
                CalculatorButton(
                  text: '*',
                  onPressed: () {
                    _calculate('*');
                  },
                ),
                CalculatorButton(
                  text: '/',
                  onPressed: () {
                    _calculate('/');
                  },
                ),
              ],
            ),

            // Display the calculated result
            Text(
              'Result: $_result',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }

  // Function to perform the calculation and update the result display
  void _calculate(String operation) {
    try {
      double num1 = double.parse(_number1Controller.text);
      double num2 = double.parse(_number2Controller.text);
      double result = 0;

      // Perform the calculation based on the selected operation
      switch (operation) {
        case '+':
          result = _calculator.add(num1, num2);
          break;
        case '-':
          result = _calculator.subtract(num1, num2);
          break;
        case '*':
          result = _calculator.multiply(num1, num2);
          break;
        case '/':
          result = _calculator.divide(num1, num2);
          break;
      }

      // Update the result display
      setState(() {
        _result = result.toString();
      });
    } catch (e) {
      // Handle any errors, such as invalid input or division by zero
      setState(() {
        _result = 'Error: ${e.toString()}';
      });
    }
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  CalculatorButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: Text(text),
    );
  }
}
