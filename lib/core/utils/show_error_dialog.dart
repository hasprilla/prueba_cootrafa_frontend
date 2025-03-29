import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_cootrafa_frontend/features/home/presentation/bloc/product_bloc.dart';

void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<ProductBloc>().add(GetProductListEvent());
                },
                child: const Text('Reintentar'),
              ),
            ],
          ),
    );
  }