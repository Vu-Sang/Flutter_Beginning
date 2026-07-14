import 'package:flutter/material.dart';
import '../models/weather_data.dart';
import '../services/weather_service.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  final WeatherService _weatherService = WeatherService();
  late Future<WeatherData> _weatherFuture;

  // Bản đồ thành phố định nghĩa trước tọa độ vĩ độ/kinh độ
  final Map<String, Map<String, double>> _cities = {
    'Lang Biang - Da Lat': {'lat': 11.9404, 'lon': 108.4583},
    'Ho Chi Minh City': {'lat': 10.7769, 'lon': 106.7009},
    'Ha Noi': {'lat': 21.0285, 'lon': 105.8542},
    'Da Nang': {'lat': 16.0544, 'lon': 108.2022},
  };

  late String _selectedCity;

  @override
  void initState() {
    super.initState();
    _selectedCity = _cities.keys.first; // Mặc định chọn Đà Lạt làm điểm đầu
    _getNewWeather();
  }

  void _getNewWeather() {
    final coords = _cities[_selectedCity]!;
    setState(() {
      _weatherFuture = _weatherService.fetchWeather(coords['lat']!, coords['lon']!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🌤️ Weather Companion', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- BỘ LỌC CHỌN THÀNH PHỐ (USER INPUT SELECTOR) ---
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Select Location:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    DropdownButton<String>(
                      value: _selectedCity,
                      underline: const SizedBox(),
                      items: _cities.keys.map((String city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedCity = newValue;
                          });
                          _getNewWeather(); // Tải lại thời tiết cho thành phố mới
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- TẦNG HIỂN THỊ DỮ LIỆU ĐỘNG VỚI FUTUREBUILDER ---
            Expanded(
              child: FutureBuilder<WeatherData>(
                future: _weatherFuture,
                builder: (context, snapshot) {
                  // TRẠNG THÁI 1: ĐANG TẢI DỮ LIỆU (LOADING STATE)
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Analyzing live atmosphere data...', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    );
                  }

                  // TRẠNG THÁI 2: GẶP SỰ CỐ MẠNG (ERROR STATE + RETRY BUTTON)
                  if (snapshot.hasError) {
                    return Center(
                      child: Card(
                        color: Colors.red.shade50,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.cloud_off, size: 64, color: Colors.red),
                              const SizedBox(height: 16),
                              const Text('Atmosphere Check Failed', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Text('${snapshot.error}', textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: _getNewWeather, // Nút hành động thử lại (Retry)
                                icon: const Icon(Icons.refresh),
                                label: const Text('Try Again'),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  // TRẠNG THÁI 3: NẠP DỮ LIỆU THÀNH CÔNG VÀ HIỂN THỊ QUYẾT ĐỊNH (SUCCESS STATE)
                  if (snapshot.hasData) {
                    final weather = snapshot.data!;
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Khối hiển thị thông số chính
                          Card(
                            elevation: 4,
                            color: Colors.blue.shade50,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Icon(weather.weatherIcon, size: 80, color: Colors.orange),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${weather.temperature.round()}°C',
                                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    weather.weatherDescription,
                                    style: TextStyle(fontSize: 20, color: Colors.grey.shade700, fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Khối hiển thị thông số chi tiết phụ
                          Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _buildWeatherDetail('Feels Like', '${weather.apparentTemperature.round()}°C', Icons.thermostat),
                                  _buildWeatherDetail('Humidity', '${weather.humidity.round()}%', Icons.water_drop),
                                  _buildWeatherDetail('Wind', '${weather.windSpeed.round()} km/h', Icons.air),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // --- KHỐI HỖ TRỢ RA QUYẾT ĐỊNH CHO NGƯỜI DÙNG (PURPOSE-DRIVEN COMPONENT) ---
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('Companion Advice', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(height: 8),
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    weather.umbrellaRecommendation,
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                  ),
                                  const Divider(height: 24),
                                  Text(
                                    weather.activityRecommendation,
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return const Center(child: Text('No response received from atmosphere.'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}