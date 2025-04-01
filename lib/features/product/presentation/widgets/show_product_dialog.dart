import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';

void showProductDialog({
  required BuildContext context,
  Map<String, dynamic>? productJson,
  required List<Map<String, dynamic>> inventoryOptions,
}) {
  final _formKey = GlobalKey<FormState>();
  final idController = TextEditingController(text: productJson?['id'] ?? '');
  final nameController = TextEditingController(
    text: productJson?['name'] ?? '',
  );
  final barcodeController = TextEditingController(
    text: productJson?['barcode'] ?? '',
  );
  final priceController = TextEditingController(
    text: productJson?['price']?.toString() ?? '',
  );
  final quantityController = TextEditingController(
    text: productJson?['quantity']?.toString() ?? '1',
  );

  String? selectedInventoryId = productJson?['inventoryId']?.toString();

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingrese un nombre válido';
    }
    if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]+$').hasMatch(value)) {
      return 'Solo se permiten letras y espacios';
    }
    return null;
  }

  String? validateBarcode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingrese un código de barras';
    }
    return null;
  }

  String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese un precio';
    }
    final price = double.tryParse(value);
    if (price == null || price <= 0) {
      return 'Debe ser mayor a 0';
    }
    return null;
  }

  String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese una cantidad';
    }
    final quantity = int.tryParse(value);
    if (quantity == null || quantity < 0) {
      return 'Debe ser 0 o mayor';
    }
    return null;
  }

  String? validateInventory(String? value) {
    if (value == null) {
      return 'Seleccione un inventario';
    }
    return null;
  }

  void submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final productBloc = context.read<ProductBloc>();
      final event =
          productJson?['id'] == null
              ? CreateProductEvent(
                inventoryId: int.parse(selectedInventoryId!),
                name: nameController.text.trim(),
                barcode: barcodeController.text.trim(),
                price: priceController.text,
                quantity: int.parse(quantityController.text),
              )
              : UpdateProductEvent(
                id: int.parse(idController.text),
                inventoryId: int.parse(selectedInventoryId!),
                name: nameController.text.trim(),
                barcode: barcodeController.text.trim(),
                price: priceController.text,
                quantity: int.parse(quantityController.text),
              );

      productBloc.add(event);
      Navigator.of(context).pop();
    }
  }

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 5,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    productJson?['id'] == null
                        ? 'Crear Producto'
                        : 'Editar Producto',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: idController,
                    decoration: const InputDecoration(
                      labelText: 'ID',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey,
                    ),
                    enabled: false,
                  ),
                  const SizedBox(height: 12),

                  DropdownButtonFormField<String>(
                    value: selectedInventoryId,
                    decoration: InputDecoration(
                      labelText: 'Inventario',
                      border: const OutlineInputBorder(),
                      errorStyle: TextStyle(color: Colors.red),
                    ),
                    items:
                        inventoryOptions.map((inventory) {
                          return DropdownMenuItem<String>(
                            value: inventory['id'].toString(),
                            child: Text(
                              inventory['value'] ?? inventory['id'].toString(),
                            ),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      selectedInventoryId = newValue;
                    },
                    validator: validateInventory,
                  ),
                  const SizedBox(height: 12),

                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre del Producto',
                      border: OutlineInputBorder(),
                    ),
                    textCapitalization: TextCapitalization.words,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]'),
                      ),
                    ],
                    validator: validateName,
                  ),
                  const SizedBox(height: 12),

                  TextFormField(
                    controller: barcodeController,
                    decoration: const InputDecoration(
                      labelText: 'Código de barras',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: validateBarcode,
                  ),
                  const SizedBox(height: 12),

                  TextFormField(
                    controller: priceController,
                    decoration: const InputDecoration(
                      labelText: 'Precio',
                      border: OutlineInputBorder(),
                      suffixText: 'USD',
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}'),
                      ),
                    ],
                    validator: validatePrice,
                  ),
                  const SizedBox(height: 12),

                  TextFormField(
                    controller: quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Cantidad en Stock',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: validateQuantity,
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('CANCELAR'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          submitForm(context);
                        },
                        child: const Text('GUARDAR'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
