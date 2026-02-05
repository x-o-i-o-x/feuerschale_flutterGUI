import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

const currentHost = String.fromEnvironment('HOST', defaultValue: 'pi');

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer _timer;
  final Map<String, double> commands = {"GetTemperature": 0};

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _refreshCommands(),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
              makeDashboardItemDisplay(
                "Temperature",
                "${commands["GetTemperature"]}°C",
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
                  style: TextStyle(fontSize: 28.0, color: Colors.white),
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

  Future<void> _refreshCommands() async {
    final futures = commands.keys.map((cmd) async {
      final value = await requestEvent(cmd);
      return MapEntry(cmd, value);
    });

    final results = await Future.wait(futures);

    for (final entry in results) {
      if (entry.value != null) {
        commands[entry.key] = entry.value!;
      }
    }

    if (mounted) setState(() {});
  }
}

String get currentHostIP {
  if (currentHost == 'pi') {
    return 'http://172.17.0.1'; // = localhost (doesn't change)
  }
  return 'http://192.168.178.123'; // testing only!!!
}

Future<bool?> sendEvent(String name) async {
  final uri = Uri.parse('$currentHostIP:5001/setevent');

  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'name': name}),
  );

  if (response.statusCode == 200) {
    return true;
  }
  return null;
}

Future<double?> requestEvent(String name) async {
  final uri = Uri.parse('$currentHostIP:5001/getevent');

  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'name': name}),
  );

  if (response.statusCode != 200) {
    return null;
  }

  final data = jsonDecode(response.body) as Map<String, dynamic>;

  if (data['successful'] == true) {
    return data['value'] as double;
  }

  return null;
}
