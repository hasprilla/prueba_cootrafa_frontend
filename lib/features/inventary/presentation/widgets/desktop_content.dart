import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_data_datable/custom_data_table.dart';
import '../../domain/entities/inventary_entity.dart';
import '../bloc/inventary_bloc.dart';
import '../../../../core/utils/mostrar_dialogo_eliminar.dart';
import 'show_inventary_dialog.dart';

class DesktopContent extends StatelessWidget {
  const DesktopContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocSelector<InventaryBloc, InventaryState, List<InventaryEntity>>(
      selector: (state) {
        return state is GetInventaryListSuccessState ? state.data : [];
      },
      builder: (context, inventary) {
        if (inventary.isEmpty) {
          return Center(child: const CircularProgressIndicator(strokeWidth: 1));
        }

        final List<Map<String, dynamic>> data = _convertCardsToData(inventary);

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
                    'id': {'label': 'ID', 'width': 450},
                    'name': {'label': 'Nombre', 'width': 450},
                  },
                  showClearButton: false,
                  itemsPerPage: 100,
                  frozenFirstColumn: true,
                  onCreate:
                      () => showInventaryDialog(
                        context: context,
                        inventaryJson: null,
                      ),
                  onView:
                      (item) => showInventaryDialog(
                        context: context,
                        inventaryJson: item,
                        actions: 0,
                      ),
                  onEdit:
                      (item) => showInventaryDialog(
                        context: context,
                        inventaryJson: item,
                      ),
                  onDelete:
                      (item) => mostrarDialogoEliminar(
                        context: context,
                        nombreRegistro: item['name'],
                        onConfirmar: () {
                          context.read<InventaryBloc>().add(
                            DeleteInventaryEvent(id: item['id']),
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

  List<Map<String, dynamic>> _convertCardsToData(
    List<InventaryEntity> inventarys,
  ) {
    return inventarys.map((inventary) {
      return {'id': inventary.id.toString(), 'name': inventary.name};
    }).toList();
  }
}
