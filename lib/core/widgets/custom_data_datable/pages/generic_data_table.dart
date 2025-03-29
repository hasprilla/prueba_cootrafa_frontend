import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../cubit/generic_data_table_cubit.dart';
import '../models/filter_config.dart';

class GenericDataTable extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final Map<String, Map<String, dynamic>> columnConfig;
  final List<FilterConfig> filterConfigs;
  final int itemsPerPage;
  final bool frozenFirstColumn;
  final Color? headerColor;
  final Color? gridLineColor;
  final Color Function(String columnName, dynamic value)? cellStyleBuilder;
  final void Function(Map<String, dynamic> item)? onView;
  final void Function(Map<String, dynamic> item)? onEdit;
  final void Function(Map<String, dynamic> item)? onDelete;
  final bool showFilter;
  final bool showClearButton;
  final bool showPagination;

  const GenericDataTable({
    super.key,
    required this.data,
    required this.columnConfig,
    this.filterConfigs = const [],
    this.itemsPerPage = 100,
    this.frozenFirstColumn = true,
    this.headerColor,
    this.gridLineColor,
    this.cellStyleBuilder,
    this.onView,
    this.onEdit,
    this.onDelete,
    this.showFilter = true,
    this.showClearButton = true,
    this.showPagination = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => GenericDataTableCubit(
            data: data,
            columnConfig: columnConfig.map(
              (key, value) => MapEntry(key, value['label']),
            ),
            filterConfigs: filterConfigs,
            itemsPerPage: itemsPerPage,
          ),
      child: BlocBuilder<GenericDataTableCubit, GenericDataTableState>(
        builder: (context, state) {
          final cubit = context.read<GenericDataTableCubit>();
          final currentPageData = state.filteredData.sublist(
            (state.currentPage - 1) * state.itemsPerPage,
            (state.currentPage * state.itemsPerPage).clamp(
              0,
              state.filteredData.length,
            ),
          );

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (showFilter) ...[
                          Expanded(
                            child: TextField(
                              onChanged:
                                  (value) =>
                                      cubit.applyFilters(searchQuery: value),
                              controller: TextEditingController(
                                text: state.searchQuery,
                              ),
                              decoration: InputDecoration(
                                // labelText: 'global_search'.tr(),
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: Colors.grey[200],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],

                        ...state.filterConfigs.map((config) {
                          return SizedBox(
                            width: 200,
                            child: DropdownButton2<String>(
                              value: state.activeFilters[config.field],
                              onChanged: (String? newValue) {
                                cubit.applyFilters(
                                  activeFilters: {
                                    ...state.activeFilters,
                                    config.field: newValue!,
                                  },
                                );
                              },
                              items:
                                  config.options.map<DropdownMenuItem<String>>((
                                    String value,
                                  ) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          color:
                                              state.activeFilters[config
                                                          .field] ==
                                                      value
                                                  ? Colors.blue.withOpacity(0.2)
                                                  : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: Text(
                                          value,
                                          // style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                              buttonStyleData: ButtonStyleData(
                                height: 48,
                                width: 200,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.blue),
                                  color: Colors.transparent,
                                ),
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 300,
                                width: 200,
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                elevation: 8,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 48,
                                padding: EdgeInsets.zero,
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                iconEnabledColor: Colors.grey,
                              ),
                              isExpanded: true,
                              selectedItemBuilder: (BuildContext context) {
                                return config.options.map<Widget>((
                                  String value,
                                ) {
                                  return Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      value,
                                      // style: const TextStyle(fontSize: 16),
                                    ),
                                  );
                                }).toList();
                              },
                            ),
                          );
                        }),

                        // ...state.filterConfigs.map(
                        //   (config) {
                        //     return SizedBox(
                        //       width: 200,
                        //       child: DropdownButton2<String>(
                        //         value: state.activeFilters[config.field],
                        //         onChanged: (String? newValue) {
                        //           cubit.applyFilters(activeFilters: {
                        //             ...state.activeFilters,
                        //             config.field: newValue!
                        //           });
                        //         },
                        //         items: config.options
                        //             .map<DropdownMenuItem<String>>(
                        //                 (String value) {
                        //           return DropdownMenuItem<String>(
                        //             value: value,
                        //             child: Container(
                        //               width: double.infinity,
                        //               padding: const EdgeInsets.symmetric(
                        //                   horizontal: 16),
                        //               alignment: Alignment.centerLeft,
                        //               decoration: BoxDecoration(
                        //                 color:
                        //                     state.activeFilters[config.field] ==
                        //                             value
                        //                         ? Colors.blue.withOpacity(0.2)
                        //                         : Colors.transparent,
                        //                 borderRadius: BorderRadius.circular(4),
                        //               ),
                        //               child: Text(
                        //                 value,
                        //                 style: const TextStyle(fontSize: 16),
                        //               ),
                        //             ),
                        //           );
                        //         }).toList(),
                        //         buttonStyleData: ButtonStyleData(
                        //           height: 48,
                        //           width: 200,
                        //           padding: const EdgeInsets.symmetric(
                        //               horizontal: 16),
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(8),
                        //             border: Border.all(color: Colors.blue),
                        //             color: Colors.grey[200],
                        //           ),
                        //         ),
                        //         dropdownStyleData: DropdownStyleData(
                        //           maxHeight: 300,
                        //           width: 200,
                        //           padding: EdgeInsets.zero,
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(8),
                        //             color: Colors.white,
                        //           ),
                        //           offset: const Offset(
                        //               0, -10), // Ajuste de posición
                        //           elevation: 8,
                        //         ),
                        //         menuItemStyleData: const MenuItemStyleData(
                        //           height: 48,
                        //           padding: EdgeInsets
                        //               .zero, // El padding ya está en el Container
                        //         ),
                        //         iconStyleData: const IconStyleData(
                        //           icon: Icon(Icons.arrow_drop_down),
                        //           iconSize: 24,
                        //           iconEnabledColor: Colors.grey,
                        //         ),
                        //         isExpanded: true,
                        //       ),
                        //     );
                        //   },
                        // ),
                        const SizedBox(width: 10),
                        if (showClearButton)
                          ElevatedButton(
                            onPressed: cubit.clearFilters,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'Limpiar filtros',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child:
                    state.filteredData.isEmpty
                        ? Center(child: Text('No se encontro resultado'))
                        : LayoutBuilder(
                          builder: (context, constraints) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                width: constraints.maxWidth,
                                child: GenericDataGrid(
                                  data: currentPageData,
                                  columnConfig: columnConfig,
                                  frozenColumnsCount: frozenFirstColumn ? 1 : 0,
                                  headerColor: headerColor,
                                  gridLineColor: gridLineColor,
                                  cellStyleBuilder: cellStyleBuilder,
                                  sortColumn: state.sortColumn,
                                  sortAscending: state.sortAscending,
                                  onSort: (String column, Offset offset) {
                                    _showSortMenu(
                                      context,
                                      column,
                                      offset,
                                      cubit,
                                    );
                                  },
                                  onView: onView,
                                  onEdit: onEdit,
                                  onDelete: onDelete,
                                ),
                              ),
                            );
                          },
                        ),
              ),
              if (showPagination) _buildPagination(state, cubit),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPagination(
    GenericDataTableState state,
    GenericDataTableCubit cubit,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed:
                state.currentPage > 1
                    ? () => cubit.goToPage(state.currentPage - 1)
                    : null,
          ),
          Text(
            '${'Pagina'} ${state.currentPage} ${'de'} ${state.totalPages}',
            style: const TextStyle(fontSize: 14),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed:
                state.currentPage < state.totalPages
                    ? () => cubit.goToPage(state.currentPage + 1)
                    : null,
          ),
        ],
      ),
    );
  }

  void _showSortMenu(
    BuildContext context,
    String column,
    Offset offset,
    GenericDataTableCubit cubit,
  ) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx - (MediaQuery.of(context).size.width / 3),
        offset.dy - 67,
        offset.dx,
        offset.dy,
      ),
      items: [
        PopupMenuItem(
          child: Text('${'Ordenar'} A ${'de'} Z'),
          onTap: () => cubit.sort(column, true),
        ),
        PopupMenuItem(
          child: Text('${'Ordenar'} Z ${'de'} A'),
          onTap: () => cubit.sort(column, false),
        ),
      ],
    );
  }
}

class GenericDataGrid extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final Map<String, Map<String, dynamic>> columnConfig;
  final int frozenColumnsCount;
  final Color? headerColor;
  final Color? gridLineColor;
  final Color Function(String columnName, dynamic value)? cellStyleBuilder;
  final String sortColumn;
  final bool sortAscending;
  final Function(String column, Offset offset) onSort;
  final void Function(Map<String, dynamic> item)? onView;
  final void Function(Map<String, dynamic> item)? onEdit;
  final void Function(Map<String, dynamic> item)? onDelete;

  const GenericDataGrid({
    super.key,
    required this.data,
    required this.columnConfig,
    this.frozenColumnsCount = 0,
    this.headerColor,
    this.gridLineColor,
    this.cellStyleBuilder,
    required this.sortColumn,
    required this.sortAscending,
    required this.onSort,
    this.onView,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SfDataGridTheme(
      data: SfDataGridThemeData(
        headerColor: headerColor ?? Colors.grey[200],
        gridLineColor: gridLineColor ?? Colors.grey[300]!,
      ),
      child: SfDataGrid(
        source: GenericDataSource(
          data: data,
          columnConfig: columnConfig,
          cellStyleBuilder: cellStyleBuilder,
          onView: onView,
          onEdit: onEdit,
          onDelete: onDelete,
        ),
        columnWidthMode: ColumnWidthMode.fill,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        frozenColumnsCount: frozenColumnsCount,
        columns: [
          if (onView != null || onEdit != null || onDelete != null)
            GridColumn(
              columnName: 'actions',
              width: 215,
              label: Container(
                padding: const EdgeInsets.all(12),
                alignment: Alignment.center,
                child: Text(
                  'Acciones',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ...columnConfig.entries.map((entry) {
            return GridColumn(
              columnName: entry.key,
              width:
                  entry.value['width'] != null
                      ? double.tryParse(entry.value['width'].toString()) ??
                          double.nan
                      : double.nan,
              label: InkWell(
                onTapDown: (details) {
                  final offset = details.globalPosition;
                  onSort(entry.key, offset);
                },
                child: Container(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        entry.value['label'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Icon(
                        sortColumn == entry.key
                            ? (sortAscending
                                ? Icons.arrow_upward
                                : Icons.arrow_downward)
                            : Icons.unfold_more,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class GenericDataSource extends DataGridSource {
  final List<Map<String, dynamic>> data;
  final Map<String, Map<String, dynamic>> columnConfig;
  final Color Function(String columnName, dynamic value)? cellStyleBuilder;
  final void Function(Map<String, dynamic> item)? onView;
  final void Function(Map<String, dynamic> item)? onEdit;
  final void Function(Map<String, dynamic> item)? onDelete;

  GenericDataSource({
    required this.data,
    required this.columnConfig,
    this.cellStyleBuilder,
    this.onView,
    this.onEdit,
    this.onDelete,
  }) {
    _buildDataRows();
  }

  List<DataGridRow> _rows = [];

  void _buildDataRows() {
    _rows =
        data.map<DataGridRow>((item) {
          return DataGridRow(
            cells: [
              if (onView != null || onEdit != null || onDelete != null)
                DataGridCell<Map<String, dynamic>>(
                  columnName: 'actions',
                  value: item,
                ),
              ...columnConfig.keys.map<DataGridCell>((key) {
                return DataGridCell<dynamic>(columnName: key, value: item[key]);
              }),
            ],
          );
        }).toList();
  }

  @override
  List<DataGridRow> get rows => _rows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells:
          row.getCells().map<Widget>((dataCell) {
            if (dataCell.columnName == 'actions') {
              final item = dataCell.value as Map<String, dynamic>;
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (onView != null)
                      IconButton(
                        icon: const Icon(Icons.visibility),
                        onPressed: () => onView!(item),
                      ),
                    if (onEdit != null)
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => onEdit!(item),
                      ),
                    if (onDelete != null)
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => onDelete!(item),
                      ),
                  ],
                ),
              );
            } else {
              final value = dataCell.value.toString();
              final columnName = dataCell.columnName;
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12),
                child: Text(
                  value,
                  style: TextStyle(
                    color:
                        cellStyleBuilder?.call(columnName, dataCell.value) ??
                        Colors.black,
                  ),
                ),
              );
            }
          }).toList(),
    );
  }

  @override
  void notifyListeners() {
    _buildDataRows();
    super.notifyListeners();
  }
}
