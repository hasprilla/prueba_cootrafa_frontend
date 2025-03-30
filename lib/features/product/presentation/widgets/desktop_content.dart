import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/mostrar_dialogo_eliminar.dart';
import '../../../inventary/presentation/bloc/inventary_bloc.dart';
import '../../domain/entities/product_entity.dart';
import '../bloc/product_bloc.dart';
import 'show_product_dialog.dart';

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
          return Center(child: const CircularProgressIndicator(strokeWidth: 1));
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
                  showClearButton: false,
                  itemsPerPage: 100,
                  frozenFirstColumn: true,
                  onCreate: () {
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
                  onView: (item) {
                    final state = context.read<InventaryBloc>().state;
                    if (state is GetInventaryListSuccessState) {
                      return showProductDialog(
                        context: context,
                        productJson: item,
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
                  onEdit: (item) {
                    final state = context.read<InventaryBloc>().state;
                    if (state is GetInventaryListSuccessState) {
                      return showProductDialog(
                        context: context,
                        productJson: item,
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
                  onDelete:
                      (item) => mostrarDialogoEliminar(
                        context: context,
                        nombreRegistro: item['name'],
                        onConfirmar: () {
                          context.read<ProductBloc>().add(
                            DeleteProductEvent(id: item['id']),
                          );

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(item['name'])));
                        },
                      ),
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
