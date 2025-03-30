import 'package:flutter/material.dart';

void showProductDialog({
  required BuildContext context,
  Map<String, dynamic>? productJson,
}) {
  final idController = TextEditingController(text: productJson?['id'] ?? '');
  final inventoryIdController = TextEditingController(
    text: productJson?['inventoryId'] ?? '',
  );
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
                    fillColor: Colors.grey[100],
                  ),
                  enabled: false,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: inventoryIdController,
                  decoration: InputDecoration(
                    labelText: 'Inventory ID',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.inventory),
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
                        if (productJson?['id'] == null) {
                          final updatedProduct = {
                            'id': idController.text,
                            'inventoryId': inventoryIdController.text,
                            'name': nameController.text,
                            'barcode': barcodeController.text,
                            'price':
                                double.tryParse(priceController.text) ?? 0.0,
                            'quantity':
                                int.tryParse(quantityController.text) ?? 0,
                          };
                          print('Producto actualizado: $updatedProduct');
                        } else {
                          print('Editar producto existente');
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
