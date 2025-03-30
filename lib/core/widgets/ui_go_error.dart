import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routes/app_route_path.dart';

class UiGoError extends StatelessWidget {
  const UiGoError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Oops!',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.purple.shade50],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/error_404.jpg', // Asegúrate de tener esta imagen en tus assets
                  height: 200,
                  width: 500,
                ),
                const SizedBox(height: 30),
                Text(
                  '404',
                  style: TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                    height: 0.9,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Página no encontrada',
                  style: TextStyle(fontSize: 24, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 20),
                Text(
                  'Lo sentimos, la página que estás buscando no existe o ha sido movida.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => context.go(AppRoute.home.path),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    'Volver al inicio',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
