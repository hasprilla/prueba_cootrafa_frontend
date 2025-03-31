import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/mostrar_dialogo_eliminar.dart';
import '../../../inventary/presentation/bloc/inventary_bloc.dart';
import '../../domain/entities/product_entity.dart';
import '../bloc/product_bloc.dart';
import 'show_product_dialog.dart';

class MobileContent extends StatelessWidget {
  const MobileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductBloc, ProductState, List<ProductEntity>>(
      selector: (state) {
        return state is GetProductListSuccessState ? state.data : [];
      },
      builder: (context, products) {
        if (products.isEmpty) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 1));
        }

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const Text('Productos'),
                floating: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      final state = context.read<InventaryBloc>().state;
                      if (state is GetInventaryListSuccessState) {
                        showProductDialog(
                          context: context,
                          productJson: null,
                          inventoryOptions:
                              state.data
                                  .map(
                                    (inventary) => {
                                      'id': inventary.id.toString(),
                                      'value': inventary.name,
                                    },
                                  )
                                  .toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final product = products[index];
                  return _buildProductItem(context, product);
                }, childCount: products.length),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductItem(BuildContext context, ProductEntity product) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(product.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${product.id}'),
            Text('Inventario ID: ${product.inventoryId}'),
            Text('Código: ${product.barcode}'),
            Text('Precio: \$${product.price}'),
            Text('Cantidad: ${product.quantity}'),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder:
              (context) => [
                const PopupMenuItem(value: 'view', child: Text('Ver')),
                const PopupMenuItem(value: 'edit', child: Text('Editar')),
                const PopupMenuItem(value: 'delete', child: Text('Eliminar')),
              ],
          onSelected: (value) {
            final inventoryState = context.read<InventaryBloc>().state;
            if (inventoryState is! GetInventaryListSuccessState) return;

            final inventoryOptions =
                inventoryState.data
                    .map(
                      (inventary) => {
                        'id': inventary.id.toString(),
                        'value': inventary.name,
                      },
                    )
                    .toList();

            switch (value) {
              case 'view':
                showProductDialog(
                  context: context,
                  productJson: {
                    'id': product.id.toString(),
                    'inventoryId': product.inventoryId.toString(),
                    'name': product.name,
                    'barcode': product.barcode,
                    'price': product.price.toString(),
                    'quantity': product.quantity.toString(),
                  },
                  inventoryOptions: inventoryOptions,
                );
                break;
              case 'edit':
                showProductDialog(
                  context: context,
                  productJson: {
                    'id': product.id.toString(),
                    'inventoryId': product.inventoryId.toString(),
                    'name': product.name,
                    'barcode': product.barcode,
                    'price': product.price.toString(),
                    'quantity': product.quantity.toString(),
                  },
                  inventoryOptions: inventoryOptions,
                );
                break;
              case 'delete':
                mostrarDialogoEliminar(
                  context: context,
                  nombreRegistro: product.name,
                  onConfirmar: () {
                    context.read<ProductBloc>().add(
                      DeleteProductEvent(id: product.id.toString()),
                    );
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(product.name)));
                  },
                );
                break;
            }
          },
        ),
      ),
    );
  }
}
