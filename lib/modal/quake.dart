import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:progress_indicators/progress_indicators.dart';

class Quake extends StatefulWidget {
  @override
  _QuakeState createState() => _QuakeState();
}

class _QuakeState extends State<Quake> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Quake"),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: FutureBuilder<Map>(
            future: getQuake(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var features = snapshot.data['features'];
                return Center(
                    child: ListView.builder(
                      itemCount: features.length,
                      padding: const EdgeInsets.all(14.5),
                      itemBuilder: (BuildContext context, int position) {
                        var format = DateFormat.yMMMd("en_US").add_jm();
                        var _date = format.format(
                            DateTime.fromMicrosecondsSinceEpoch(
                                features[position]['properties']['time'] * 1000,
                                isUtc: true));
                        return Column(
                          children: <Widget>[
                            Divider(height: 5.5),
                            ListTile(
                              title:
                              Text("$_date", style: TextStyle(fontSize: 16.0)),
                              subtitle: Text(
                                  "${features[position]['properties']['place']}",
                                  style: TextStyle(fontSize: 13.0)),
                              leading: CircleAvatar(
                                  backgroundColor: Colors.purple,
                                  child: Text(
                                      "${features[position]['properties']['mag']}",
                                      style: TextStyle(color: Colors.white))),
                              onTap: () => _windowOnTapping(context,
                                  features[position]['properties']['title']),
                            )
                          ],
                        );
                      },
                    ));
              } else {
                return Center(
                  child: JumpingDotsProgressIndicator(
                    fontSize: 50.0,
                  ),
                );
              }
            }));
  }
}

Future _windowOnTapping(BuildContext context, String message) {
  var alert = AlertDialog(
    title: Text("Quakes"),
    content: Text(message),
    actions: <Widget>[
      FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          })
    ],
  );
  showDialog(context: context, builder: (context) => alert);
}

Future<Map> getQuake() async{
  String apiUrl =
      'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';
  http.Response response = await http.get(apiUrl);
  var data = json.decode(response.body);
 // print(data);
  return data;
}