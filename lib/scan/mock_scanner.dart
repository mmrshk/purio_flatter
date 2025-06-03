import 'package:flutter/material.dart';

class MockScanner extends StatelessWidget {
  final Function(String) onScan;

  const MockScanner({
    super.key,
    required this.onScan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Mock Scanner',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => onScan('5901234123457'), // Example barcode
              child: const Text('Scan Test Barcode'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => onScan('4007817327324'), // Another example barcode
              child: const Text('Scan Another Barcode'),
            ),
          ],
        ),
      ),
    );
  }
} 