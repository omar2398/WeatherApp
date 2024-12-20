import 'package:basiweatherpp/wheather_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false  ,
      theme: ThemeData(
        primaryColor: Colors.blue,
        cardColor: Colors.orange,
        fontFamily: 'Roboto',
      ),
      home: WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final TextEditingController _cityController = TextEditingController();
  final WeatherApi _weatherApi = WeatherApi();
  Weather? _weather;

  void _getWeather() async {
    final city = _cityController.text;
    final data = await _weatherApi.getWeather(city);

    setState(() {
      _weather = Weather(
        city: city,
        temperature: data['main']['temp'],
        conditions: data['weather'][0]['main'],
        icon: data['weather'][0]['icon'],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter city',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                suffixIcon: Icon(Icons.location_history,size:35,color: Colors.black54,),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).cardColor, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getWeather,
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).cardColor,
                textStyle: TextStyle(fontSize: 16),
              ),
              child: Text('Get Weather'),
            ),
            SizedBox(height: 16),
            if (_weather != null)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'City: ${_weather!.city}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Temperature: ${_weather!.temperature}°C',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Conditions: ${_weather!.conditions}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Image.network('https://openweathermap.org/img/w/${_weather!.icon}.png'),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
