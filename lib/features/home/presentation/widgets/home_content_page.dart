import 'package:flutter/material.dart';

import 'desktop_content.dart';
import 'mobile_content.dart';

class HomeContentPage extends StatelessWidget {
  const HomeContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWeb = MediaQuery.of(context).size.width > 600;
    return isWeb ? const DesktopContent() : const MobileContent();
  }
}
