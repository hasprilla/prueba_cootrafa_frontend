import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';

class HomePage extends StatelessWidget {
  final Widget child;
  const HomePage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final scaffoldKey = GlobalKey<ScaffoldState>();
        return Scaffold(
          key: scaffoldKey,
          drawer: isMobile ? Drawer(child: const CustomDrawer()) : null,
          body: Row(
            children: [
              if (!isMobile) const CustomDrawer(),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      color: Colors.blueGrey[50],
                      child: Row(
                        children: [
                          if (isMobile)
                            IconButton(
                              icon: const Icon(Icons.menu),
                              onPressed: () {
                                scaffoldKey.currentState?.openDrawer();
                              },
                            ),
                          const Expanded(
                            child: Center(child: Text('Prueba Tecnica')),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(color: Colors.white, child: child),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
