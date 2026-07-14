import 'package:flutter/material.dart';

class WeatherData {
  final double temperature;
  final double apparentTemperature; // Nhiệt độ cảm nhận thực tế (Feels like)
  final double humidity;            // Độ ẩm
  final double windSpeed;           // Tốc độ gió
  final double precipitation;       // Lượng mưa (để biết có cần mang ô hay không)
  final int weatherCode;            // Mã trạng thái thời tiết từ API

  const WeatherData({
    required this.temperature,
    required this.apparentTemperature,
    required this.humidity,
    required this.windSpeed,
    required this.precipitation,
    required this.weatherCode,
  });

  // Factory constructor ánh xạ dữ liệu JSON trả về từ API thành Dart Model
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final current = json['current'] as Map<String, dynamic>;
    return WeatherData(
      temperature: (current['temperature_2m'] as num).toDouble(),
      apparentTemperature: (current['apparent_temperature'] as num).toDouble(),
      humidity: (current['relative_humidity_2m'] as num).toDouble(),
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      precipitation: (current['precipitation'] as num).toDouble(),
      weatherCode: current['weather_code'] as int,
    );
  }

  // --- HỆ THỐNG RA QUYẾT ĐỊNH (PURPOSE-DRIVEN HEURISTIC DECISION) ---

  // Trích xuất mô tả thời tiết dựa trên mã thời tiết quốc tế (WMO Weather Codes)
  String get weatherDescription {
    if (weatherCode == 0) return 'Clear sky';
    if (weatherCode >= 1 && weatherCode <= 3) return 'Partly cloudy';
    if (weatherCode >= 51 && weatherCode <= 67) return 'Drizzle / Rain';
    if (weatherCode >= 71 && weatherCode <= 77) return 'Snow fall';
    if (weatherCode >= 80 && weatherCode <= 82) return 'Rain showers';
    if (weatherCode >= 95) return 'Thunderstorm';
    return 'Cloudy';
  }

  // Trích xuất Icon phù hợp hiển thị trực quan
  IconData get weatherIcon {
    if (weatherCode == 0) return Icons.wb_sunny;
    if (weatherCode >= 1 && weatherCode <= 3) return Icons.cloud_queue;
    if (weatherCode >= 51 && weatherCode <= 67) return Icons.umbrella;
    if (weatherCode >= 80 && weatherCode <= 82) return Icons.grain;
    if (weatherCode >= 95) return Icons.thunderstorm;
    return Icons.cloud;
  }

  // Gợi ý mang ô (Umbrella Recommendation)
  String get umbrellaRecommendation {
    if (precipitation > 0 || weatherCode >= 51) {
      return '☔ Yes, bring an umbrella! It is currently raining or likely to drizzle.';
    }
    return '☀️ No umbrella needed. Enjoy the clear sky!';
  }

  // Gợi ý hoạt động ngoài trời (Activity Recommendation)
  String get activityRecommendation {
    if (temperature > 35) {
      return '🥵 Too hot for outdoor sports. Stay hydrated indoors!';
    } else if (temperature < 15) {
      return '🥶 Quite chilly. Wear warm clothes if you plan to go out.';
    } else if (precipitation > 0.5) {
      return '🌧️ Rain detected. Better to reschedule outdoor activities.';
    } else {
      return '🏃 Great weather for a walk or outdoor sports!';
    }
  }
}