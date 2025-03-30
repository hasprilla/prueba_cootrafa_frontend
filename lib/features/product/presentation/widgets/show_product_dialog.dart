import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';

void showProductDialog({
  required BuildContext context,
  Map<String, dynamic>? productJson,
  required List<Map<String, dynamic>> inventoryOptions, // Add this parameter
}) {
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
    text: productJson?['quantity']?.toString() ?? '',
  );

  String? selectedInventoryId = productJson?['inventoryId']?.toString();

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
                Text(
                  productJson?['id'] == null
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
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),

                  enabled: false,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedInventoryId,
                  decoration: InputDecoration(
                    labelText: 'Inventorio',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.inventory),
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
                const SizedBox(height: 12),
                TextField(
                  controller: barcodeController,
                  decoration: InputDecoration(
                    labelText: 'Código de barras',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.barcode_reader),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'Precio',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                    suffixText: 'USD',
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: quantityController,
                  decoration: InputDecoration(
                    labelText: 'Cantidad en Stock',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.format_list_numbered),
                  ),
                  keyboardType: TextInputType.number,
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
                        'CANCELAR',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedInventoryId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Seleccione un Inventory ID'),
                            ),
                          );
                          return;
                        }

                        if (productJson?['id'] == null) {
                          context.read<ProductBloc>().add(
                            CreateProductEvent(
                              inventoryId: int.parse(
                                selectedInventoryId ?? '0',
                              ),
                              name: nameController.text,
                              barcode: barcodeController.text,
                              price: priceController.text,
                              quantity:
                                  int.tryParse(quantityController.text) ?? 0,
                            ),
                          );
                        } else {
                          context.read<ProductBloc>().add(
                            UpdateProductEvent(
                              id: int.tryParse(idController.text) ?? 0,
                              inventoryId: int.parse(selectedInventoryId!),
                              name: nameController.text,
                              barcode: barcodeController.text,
                              price: priceController.text,
                              quantity:
                                  int.tryParse(quantityController.text) ?? 0,
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
