import 'package:flutter/material.dart';

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  double _sliderValue = 50.0;
  bool _isMovieActive = false;
  String? _selectedGenre = 'None';
  DateTime? _selectedDate;

  Future<void> _openDatePicker(BuildContext validContext) async {
    final DateTime? pickedDate = await showDatePicker(
      context: validContext,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 2 – Input Contr...')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Rating (Slider)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Slider(
              value: _sliderValue,
              min: 0.0,
              max: 100.0,
              divisions: 100,
              label: _sliderValue.round().toString(),
              onChanged: (double value) {
                setState(() { _sliderValue = value; });
              },
            ),
            Text('Current value: ${_sliderValue.round()}', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            const Text('Active (Switch)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Is movie active?'),
              trailing: Switch(
                value: _isMovieActive,
                onChanged: (bool value) {
                  setState(() { _isMovieActive = value; });
                },
              ),
            ),
            const SizedBox(height: 10),
            const Text('Genre (RadioListTile)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            RadioListTile<String>(
              title: const Text('Action'),
              value: 'Action',
              groupValue: _selectedGenre,
              contentPadding: EdgeInsets.zero,
              onChanged: (String? value) {
                setState(() { _selectedGenre = value; });
              },
            ),
            RadioListTile<String>(
              title: const Text('Comedy'),
              value: 'Comedy',
              groupValue: _selectedGenre,
              contentPadding: EdgeInsets.zero,
              onChanged: (String? value) {
                setState(() { _selectedGenre = value; });
              },
            ),
            Text('Selected genre: $_selectedGenre', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => _openDatePicker(context),
                    child: const Text('Open Date Picker'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _selectedDate == null
                        ? 'No date selected'
                        : 'Selected Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                    style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}