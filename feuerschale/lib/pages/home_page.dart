import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // TODO: implement "fire up" action
        },
        child: const Text('Fire Up', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
