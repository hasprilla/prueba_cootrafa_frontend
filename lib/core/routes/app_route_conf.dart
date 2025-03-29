import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/widgets/home_content_page.dart';
import 'app_route_path.dart';

import 'routes.dart';

class AppRouteConf {
  GoRouter get router => _router;

  late final _router = GoRouter(
    initialLocation: AppRoute.home.path,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => UiGoError(),
    routes: [
      ShellRoute(
        builder: (_, state, child) => HomePage(child: child),

        routes: [
          GoRoute(
            path: AppRoute.home.path,
            name: AppRoute.home.name,
            builder: (_, state) => const HomeContentPage(),
          ),
        ],
      ),
    ],
  );
}

class UiGoError extends StatelessWidget {
  const UiGoError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('An error has occurred'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('Go back'),
            ),
          ],
        ),
      ),
    );
  }
}
