import 'package:go_router/go_router.dart';
import 'package:prueba_cootrafa_frontend/core/widgets/ui_go_error.dart';

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
