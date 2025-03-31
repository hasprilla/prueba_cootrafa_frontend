import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/mostrar_dialogo_eliminar.dart';
import '../../domain/entities/inventary_entity.dart';
import '../bloc/inventary_bloc.dart';
import 'show_inventary_dialog.dart';

class MobileContent extends StatelessWidget {
  const MobileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<InventaryBloc, InventaryState, List<InventaryEntity>>(
      selector: (state) {
        return state is GetInventaryListSuccessState ? state.data : [];
      },
      builder: (context, inventary) {
        if (inventary.isEmpty) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 1));
        }

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const Text('Inventario'),
                floating: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed:
                        () => showInventaryDialog(
                          context: context,
                          inventaryJson: null,
                        ),
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = inventary[index];
                  return _buildInventoryItem(context, item);
                }, childCount: inventary.length),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInventoryItem(BuildContext context, InventaryEntity item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(item.name),
        subtitle: Text('ID: ${item.id}'),
        trailing: PopupMenuButton(
          itemBuilder:
              (context) => [
                const PopupMenuItem(value: 'view', child: Text('Ver')),
                const PopupMenuItem(value: 'edit', child: Text('Editar')),
                const PopupMenuItem(value: 'delete', child: Text('Eliminar')),
              ],
          onSelected: (value) {
            switch (value) {
              case 'view':
                showInventaryDialog(
                  context: context,
                  inventaryJson: {'id': item.id.toString(), 'name': item.name},
                  actions: 0,
                );
                break;
              case 'edit':
                showInventaryDialog(
                  context: context,
                  inventaryJson: {'id': item.id.toString(), 'name': item.name},
                );
                break;
              case 'delete':
                mostrarDialogoEliminar(
                  context: context,
                  nombreRegistro: item.name,
                  onConfirmar: () {
                    context.read<InventaryBloc>().add(
                      DeleteInventaryEvent(id: item.id.toString()),
                    );
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(item.name)));
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
