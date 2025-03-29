import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Widget child;
  const HomePage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [IconButton(icon: const Icon(Icons.logout), onPressed: () {})],
      ),
      body: child,
    );
  }
}
