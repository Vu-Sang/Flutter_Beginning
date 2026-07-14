import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_data.dart';

class WeatherService {
  final http.Client client;

  WeatherService({http.Client? client}) : client = client ?? http.Client();

  // Gọi REST API của Open-Meteo để lấy thông tin thời tiết dựa trên vĩ độ/kinh độ [cite: 457, 505]
  Future<WeatherData> fetchWeather(double latitude, double longitude) async {
    final url = 'https://api.open-meteo.com/v1/forecast'
        '?latitude=$latitude'
        '&longitude=$longitude'
        '&current=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,wind_speed_10m'
        '&timezone=auto';

    try {
      final response = await client.get(Uri.parse(url)).timeout(
        const Duration(seconds: 8), // Giới hạn thời gian chờ chống treo app
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedJson = json.decode(response.body);
        return WeatherData.fromJson(decodedJson);
      } else {
        throw Exception('Server returned error status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network connection failed. Please check your internet or try again.');
    }
  }
}