import 'package:flutter/material.dart';

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 1 – Core Widge...')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome to Flutter UI',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            const Center(
              child: Icon(
                Icons.face,
                size: 80,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                'https://picsum.photos/400/250',
                height: 200,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 24),
            const Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: ListTile(
                  leading: Icon(Icons.star, color: Colors.amber, size: 32),
                  title: Text('Movie Item', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('This is a sample ListTile inside a Card.'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}