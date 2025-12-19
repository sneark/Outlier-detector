import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String result;
  
  const ResultPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Wynik:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              result,
              style: const TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
