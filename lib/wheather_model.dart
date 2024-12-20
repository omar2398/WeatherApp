import 'package:dio/dio.dart';

class WeatherApi {
  final String apiKey = '273ff8b1148597d5dbed0c59850c46de'; // Replace with your API key
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getWeather(String city) async {
    try {
      final response = await _dio.get('https://api.openweathermap.org/data/2.5/weather',
          queryParameters: {'q': city, 'appid': apiKey, 'units': 'metric'});

      return response.data;
    } catch (error) {
      throw Exception('Failed to load weather data');
    }
  }
}
class Weather {
  final String city;
  final double temperature;
  final String conditions;
  final String icon;

  Weather({required this.city, required this.temperature, required this.conditions, required this.icon});
}