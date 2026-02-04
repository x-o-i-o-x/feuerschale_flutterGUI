import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  /* @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Control Panel',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
            },
            child: const Text('Fire Up', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  } */
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Control Panel',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontSize: 24),
          ),
          GridView.count(
            crossAxisCount: 5,
            padding: EdgeInsets.all(3.0),
            shrinkWrap: true,
            children: <Widget>[
              makeDashboardItemAction(
                "Fire Up",
                CupertinoIcons.flame_fill,
                () => sendEvent("FireUp"),
              ),
              makeDashboardItemDisplay("Temperature", "20°C"),
              makeDashboardItemAction(
                "test",
                CupertinoIcons.exclamationmark,
                () => sendEvent("test"),
              ),
              makeDashboardItemAction(
                "test",
                CupertinoIcons.exclamationmark,
                () => sendEvent("test"),
              ),
              makeDashboardItemAction(
                "test",
                CupertinoIcons.exclamationmark,
                () => sendEvent("test"),
              ),
              makeDashboardItemAction(
                "test",
                CupertinoIcons.exclamationmark,
                () => sendEvent("test"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Card makeDashboardItemAction(
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(49, 34, 62, 1)),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child: Icon(icon, size: 40.0, color: Colors.white)),
              SizedBox(height: 20.0),
              Center(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card makeDashboardItemDisplay(String title, String value) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(49, 34, 62, 1)),
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  value,
                  style: TextStyle(fontSize: 40.0, color: Colors.white),
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//sendEvent('FireUp');

Future<void> sendEvent(String name) async {
  final uri = Uri.parse('http://172.17.0.1:5001/setevent');

  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'name': name}),
  );

  /* if (response.statusCode == 200) {
    // success
    print(response.body);
  } else {
    // error handling
    print('Error: ${response.statusCode}');
  } */
}

Future<void> requestEvent(String name) async {
  final uri = Uri.parse('http://172.17.0.1:5001/setevent');

  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'name': name}),
  );
}
