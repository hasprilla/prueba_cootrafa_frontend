import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_cootrafa_frontend/features/home/domain/entities/product_entity.dart';
import 'package:prueba_cootrafa_frontend/features/home/presentation/bloc/product_bloc.dart';

import '../../../../core/widgets/custom_data_datable/custom_data_table.dart';

class DesktopContent extends StatelessWidget {
  const DesktopContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocSelector<ProductBloc, ProductState, List<ProductEntity>>(
      selector: (state) {
        return state is GetProductListSuccessState ? state.data : [];
      },
      builder: (context, product) {
        if (product.isEmpty) {
          return const CircularProgressIndicator();
        }

        final List<Map<String, dynamic>> data = _convertCardsToData(product);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.9,
                width: size.width,
                child: GenericDataTable(
                  data: data,
                  columnConfig: {
                    'id': {'label': 'ID', 'width': 250},
                    'inventoryId': {'label': 'Iventario ID', 'width': 250},
                    'name': {'label': 'Nombre', 'width': 250},
                    'barcode': {'label': 'Codigo de barra', 'width': 250},
                    'price': {'label': 'Precio', 'width': 250},
                    'quantity': {'label': 'Cantidad', 'width': 250},
                  },

                  itemsPerPage: 100,
                  frozenFirstColumn: true,
                  onView: (item) {},
                  onEdit:
                      (item) => showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Editar'),
                            content: const Text('Editar'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cerrar'),
                              ),
                            ],
                          );
                        },
                      ),

                  onDelete: (item) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Eliminar'),
                          content: const Text('Eliminar'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cerrar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Map<String, dynamic>> _convertCardsToData(List<ProductEntity> products) {
    return products.map((product) {
      return {
        'id': product.id.toString(),
        'inventoryId': product.inventoryId.toString(),
        'name': product.name,
        'barcode': product.barcode,
        'price': product.price.toString(),
        'quantity': product.quantity.toString(),
      };
    }).toList();
  }
}
