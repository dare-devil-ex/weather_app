import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/pages/Additional.dart';
import 'package:weather_app/pages/forecast.dart';
import 'package:http/http.dart' as http;

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  late Future<Map<String, dynamic>> wkaie;
  bool isLight = true;
  late IconData LightButton = Icons.light_mode_outlined;
  Future<Map<String, dynamic>> fetcher() async {
    try{
      final res = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=India&appid=d1845658f92b31c64bd94f06f7188c9c"));
      final data = jsonDecode(res.body);
      
      if (data["cod"] != "200") {
        throw data["message"];
      }
      return data;

      } catch(e) {
        throw e.toString();
      }
    }

  @override
  void initState() {
    wkaie = fetcher();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: isLight ? ThemeData.light() : ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "WEATHER APP",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {
              setState(() {
                if (isLight) {
                  isLight = false;
                  LightButton = Icons.light_mode_outlined;
                } else {
                  isLight = true;
                  LightButton = Icons.light_mode_sharp;
                }
              });
            }, 
            icon: Icon( LightButton )),
            IconButton(onPressed: () {
              setState(() {
                wkaie = fetcher();
              });
            },
            icon: Icon(Icons.refresh))
          ],
        ),
      
        body: FutureBuilder(
          future: wkaie,
          builder: (context, snapshot) {
      
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator.adaptive());
            }
      
            if (snapshot.hasError) {
              return Center(
                child: Text("A unexcepted error occured"),
              );
            }
      
            final data = snapshot.data!;
      
            final wkan = data["list"][0];
            // Main variables
            final temp = wkan["main"]["temp"];
            final desc = wkan["weather"][0]["main"];
      // 
            // Additional variables
            final humidity = wkan["main"]["humidity"].toString();
            final windSpeed = wkan["wind"]["speed"].toString();
            final pressure = wkan["main"]["pressure"].toString();
      
            return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Box
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Text(
                                "$temp°K",
                                style: TextStyle(
                                  fontSize: 30,
                                  letterSpacing: 0.9,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Icon(
                                desc == "Clouds" || desc == "Rain" ? Icons.cloud : Icons.sunny,
                                size: 50,
                              ),
                              Text(
                                desc,
                                style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
          
                // Forecast
                Text(
                  "Weather Forecast",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                ),
                SizedBox(height: 15),
                
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                    itemCount: 8,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final time = DateTime.parse(data["list"][ index + 1]["dt_txt"].toString());
                      final value = data["list"][ index + 1 ]["main"]["temp"].toString();
                      final icon = data["list"][ index + 1 ]["weather"][0]["main"] == "Clouds" || data["list"][ index + 1 ]["weather"][0]["main"] == "Rain" ? Icons.cloud : Icons.sunny;
                      return Forecast(
                        time: DateFormat.j().format(time),
                        value: value,
                         icon: icon
                      );
                    },
                  ),
                ),
      
                SizedBox(height: 20),
          
                // Additional Information
                Text(
                  "Additional Information",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                ),
                SizedBox(height: 15),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
          
                    // humidity
                    Additional(
                      icon: Icons.water_drop,
                      label: "Humidity",
                      value: humidity,
                    ),
          
                    // wind speed
                    Additional(
                      icon: Icons.air,
                      label: "Wind speed",
                      value: windSpeed,
                    ),
          
                    // pressure
                    Additional(
                      icon: Icons.beach_access,
                      label: "Pressure",
                      value: pressure,
                    )
          
                  ],
                ),
               ],
            ),
          );
          },
        ),
      ),
    );
  }
}