import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          label: Text('Inicio'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.settings),
          label: Text('Configuración'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.info),
          label: Text('Acerca de'),
        ),
      ],
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    switch (location) {
      case '/home':
        return 0;
      case '/settings':
        return 1;
      case '/about':
        return 2;
      default:
        return 0;
    }
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/settings');
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
            title: const Text('Inicio'),
            onTap: () => context.go('/home'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () => context.go('/settings'),
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
