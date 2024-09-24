import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoanCalculator(),
    );
  }
}

class LoanCalculator extends StatefulWidget {
  const LoanCalculator({super.key});

  @override
  LoanCalculatorState createState() => LoanCalculatorState();
}

class LoanCalculatorState extends State<LoanCalculator> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _percentController = TextEditingController();
  double _months = 1;
  double _monthlyPayment = 0.0;

  void _calculatePayment() {
    final double amount = double.tryParse(_amountController.text) ?? 0;
    final double percent = double.tryParse(_percentController.text) ?? 0;

    if (amount > 0 && percent > 0) {
      setState(() {
        _monthlyPayment = (amount * (percent / 100)) / _months;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan calculator',
            style: TextStyle(fontSize: 38, fontFamily: 'Arial')),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter amount',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Arial',
              ),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
            ),
            const Text('Enter number of months',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Arial',
                )),
            SliderTheme(
              data: const SliderThemeData(
                activeTrackColor: Color.fromRGBO(33, 151, 242, 1),
                inactiveTrackColor: Colors.grey,
                thumbColor: Color.fromRGBO(20, 39, 197, 1),
                valueIndicatorColor: Color.fromRGBO(20, 39, 197, 1),
                trackHeight: 4.0,
              ),
              child: Slider(
                value: _months,
                min: 1,
                max: 60,
                divisions: 59,
                label: '${_months.round()} luni',
                onChanged: (value) {
                  setState(() {
                    _months = value;
                  });
                },
              ),
            ),
            const Text('Enter % per month',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Arial',
                )),
            TextField(
              controller: _percentController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Percent',
                border: OutlineInputBorder(),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F3F7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    'You will pay the approximate amount monthly:',
                    style: TextStyle(fontSize: 20, fontFamily: 'Arial'),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${_monthlyPayment.toStringAsFixed(2)}€',
                    style: const TextStyle(
                      fontSize: 24,
                      fontFamily: 'Arial',
                      color: Color.fromRGBO(20, 39, 197, 1),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _calculatePayment,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 145, vertical: 15),
                backgroundColor: const Color.fromRGBO(20, 39, 197, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Calculate',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontFamily: 'Arial',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
