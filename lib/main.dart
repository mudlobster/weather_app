import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: Home(),

    )
);

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState () {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather () async {
    http.Response response = await 	http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=56&lon=44&units=metric&appid=5e0b87d4d64a80c007d62c319cc8b3e7'));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });

  }

  @override
  void initState () {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.height,
            color: Colors.grey[900],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[ //added const as asked, then deleted
                Padding(
                    padding: EdgeInsets.all(
                       10.0),
                    child: Text(
                      'Niznny Novgorod',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w300
                      ),
                ),
                ),
               Text(
                temp != null ? temp.toStringAsFixed(1) + '\u00B0' : 'Loading',
                 style: GoogleFonts.roboto(
                   color: Colors.white,
                   fontSize: 50.0,
                   fontWeight: FontWeight.w400
                 ),
               ),
                Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  currently != null ? currently.toString() : 'Loading',
                  style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w300
            ),
          )
                ),
  ],
    ),
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                     leading: FaIcon(FontAwesomeIcons.temperatureHalf),
                     title: Text('Temperature'),
                      trailing: Text(temp != null? temp.toStringAsFixed(1) + '\u00B0' + 'C' : 'Loading'),
                ),
                    ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text('Weather'),
                    trailing: Text(description != null ? description.toString() : 'Loading'),
                    ),
                    ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text('Humidity'),
                    trailing: Text(humidity != null ? humidity.toString() + ' %': 'Loading'),
                    ),
                    ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text('Wind Speed'),
                    trailing: Text(windSpeed != null ? windSpeed.toStringAsFixed(1) + ' mps' : 'Loading'),
                    ),
                  ],
    ),
          )

    )
  ]));
  }
}

