import 'package:flutter/material.dart';

class MobileContent extends StatelessWidget {
  const MobileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: const Center(
        child: Text(
          'Mobile Content',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
