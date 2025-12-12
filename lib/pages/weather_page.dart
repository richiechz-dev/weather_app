import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  //api key
  final _weatherService = WeatherService('d01a0de2584f728cfea5043f67dcf813');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get the current city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    //any errors
    catch(e) {
      print(e);
    }
  }
  //weather animations
                        

  //init state
  @override
  void initState() {
    super.initState();

    //fetch state on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather?.cityName ?? 'loading city ... '),
            //Animatio
            Lottie.asset('assets/cloud.json'),
            //temperature
            Text('${_weather?.temperature.round()}°C')
          ],
        ),
      ),
    );
  }
}