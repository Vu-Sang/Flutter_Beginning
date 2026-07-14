import 'package:flutter/material.dart';
import 'screens/weather_home_screen.dart'; // Import màn hình chính của bạn

void main() {
  runApp(const WeatherCompanionApp());
}

class WeatherCompanionApp extends StatelessWidget {
  const WeatherCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Companion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      home: const WeatherHomeScreen(), // Gọi màn hình từ file tách biệt
    );
  }
}