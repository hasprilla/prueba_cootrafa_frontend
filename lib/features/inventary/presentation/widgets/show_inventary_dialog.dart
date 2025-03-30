import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/inventary_bloc.dart';

void showInventaryDialog({
  required BuildContext context,
  Map<String, dynamic>? inventaryJson,
  int? actions,
}) {
  final idController = TextEditingController(text: inventaryJson?['id'] ?? '');

  final nameController = TextEditingController(
    text: inventaryJson?['name'] ?? '',
  );

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                actions == 0
                    ? Text(
                      'Dettalle ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    )
                    : Text(
                      inventaryJson?['id'] == null
                          ? 'Crear Producto'
                          : 'Editar Producto',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                const SizedBox(height: 20),
                TextField(
                  controller: idController,
                  decoration: InputDecoration(
                    labelText: 'ID',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre del Producto',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.shopping_bag),
                  ),
                  textCapitalization: TextCapitalization.words,
                ),

                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        actions == 0 ? 'CERRAR' : 'CANCELAR',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(width: 8),
                    actions == 0
                        ? SizedBox()
                        : ElevatedButton(
                          onPressed: () {
                            if (inventaryJson?['id'] == null) {
                              context.read<InventaryBloc>().add(
                                CreateInventaryEvent(
                                  id: idController.text,
                                  name: nameController.text,
                                ),
                              );
                            } else {
                              context.read<InventaryBloc>().add(
                                UpdateInventaryEvent(
                                  id: idController.text,
                                  name: nameController.text,
                                ),
                              );
                            }
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          child: Text('GUARDAR'),
                        ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
