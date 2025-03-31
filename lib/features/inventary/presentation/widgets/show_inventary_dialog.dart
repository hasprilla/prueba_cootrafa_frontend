import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  bool isValidName(String input) {
    if (input.trim().isEmpty) return false;
    return RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]+$').hasMatch(input);
  }

  final lettersAndSpaceOnly = FilteringTextInputFormatter.allow(
    RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]'),
  );

  showDialog(
    context: context,
    builder: (context) {
      bool showError = false;

      return StatefulBuilder(
        builder: (context, setState) {
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
                    Text(
                      actions == 0
                          ? 'Detalle'
                          : inventaryJson?['id'] == null
                          ? 'Crear Producto'
                          : 'Editar Producto',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      enabled: false,
                    ),
                    const SizedBox(height: 12),

                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Nombre del Producto',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                showError && !isValidName(nameController.text)
                                    ? Colors.red
                                    : Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                showError && !isValidName(nameController.text)
                                    ? Colors.red
                                    : Theme.of(context).primaryColor,
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        prefixIcon: Icon(
                          Icons.shopping_bag,
                          color:
                              showError && !isValidName(nameController.text)
                                  ? Colors.red
                                  : null,
                        ),
                      ),
                      inputFormatters: [lettersAndSpaceOnly],
                      textCapitalization: TextCapitalization.words,
                      onChanged: (value) => setState(() {}),
                    ),

                    if (showError && !isValidName(nameController.text))
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, left: 12.0),
                        child: Text(
                          nameController.text.trim().isEmpty
                              ? 'El nombre no puede estar vacío'
                              : 'Solo se permiten letras y espacios (mínimo un carácter)',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            actions == 0 ? 'CERRAR' : 'CANCELAR',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                        const SizedBox(width: 8),

                        if (actions != 0)
                          ElevatedButton(
                            onPressed: () {
                              setState(() => showError = true);

                              if (!isValidName(nameController.text)) return;

                              final bloc = context.read<InventaryBloc>();
                              if (inventaryJson?['id'] == null) {
                                bloc.add(
                                  CreateInventaryEvent(
                                    name: nameController.text.trim(),
                                  ),
                                );
                              } else {
                                bloc.add(
                                  UpdateInventaryEvent(
                                    id: int.parse(idController.text),
                                    name: nameController.text.trim(),
                                  ),
                                );
                              }
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isValidName(nameController.text)
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey[400],
                            ),
                            child: Text(
                              'GUARDAR',
                              style: TextStyle(
                                color:
                                    isValidName(nameController.text)
                                        ? Colors.white
                                        : Colors.grey[600],
                              ),
                            ),
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
    },
  );
}
