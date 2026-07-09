import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> movies = [
      {'title': 'Avatar', 'desc': 'The Best Movie Of The Year'},
      {'title': 'Inception', 'desc': 'I don no this movie'},
      {'title': 'Interstellar', 'desc': 'I don no this movie '},
      {'title': 'Joker', 'desc': 'Very Good Movie'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 3 – Layout De...')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Now Playing',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text(movies[index]['title']![0]),
                    ),
                    title: Text(movies[index]['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(movies[index]['desc']!),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}