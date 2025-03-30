import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_route_path.dart';

class AdaptiveMenu extends StatelessWidget {
  const AdaptiveMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWeb = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(title: const Text('App con GoRouter')),

      body: Row(
        children: [
          if (isWeb) _buildNavigationRail(context),
          Expanded(child: const Center(child: Text('Contenido Principal'))),
        ],
      ),
      drawer: isWeb ? null : const CustomDrawer(),
    );
  }

  Widget _buildNavigationRail(BuildContext context) {
    return NavigationRail(
      selectedIndex: _getSelectedIndex(context),
      onDestinationSelected: (index) => _onItemTapped(index, context),
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.home),
          label: Text('Productos'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.settings),
          label: Text('Inventario'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.info),
          label: Text('Acerca de'),
        ),
      ],
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    return AppRoute.values
        .firstWhere(
          (route) => route.path == location,
          orElse: () => AppRoute.home,
        )
        .index;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRoute.home.path);
        break;
      case 1:
        context.go(AppRoute.inventary.path);
        break;
      case 2:
        context.go('/about');
        break;
    }
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menú Principal',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Productos'),
            onTap: () => context.go(AppRoute.home.path),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Inventario'),
            onTap: () => context.go(AppRoute.inventary.path),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Acerca de'),
            onTap: () => context.go('/about'),
          ),
        ],
      ),
    );
  }
}
