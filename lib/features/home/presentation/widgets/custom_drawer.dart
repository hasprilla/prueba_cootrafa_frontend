import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Center(
        child: Text(
          'Desktopsdfds Content',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
