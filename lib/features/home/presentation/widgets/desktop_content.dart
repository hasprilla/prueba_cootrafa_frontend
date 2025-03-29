import 'package:flutter/material.dart';

class DesktopContent extends StatelessWidget {
  const DesktopContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Center(
        child: Text(
          'Desktop Content',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
