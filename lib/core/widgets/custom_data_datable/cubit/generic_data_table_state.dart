part of 'generic_data_table_cubit.dart';

class GenericDataTableState extends Equatable {
  final List<Map<String, dynamic>> data;
  final Map<String, String> columnConfig;
  final List<FilterConfig> filterConfigs;
  final int itemsPerPage;
  final String searchQuery;
  final Map<String, String> activeFilters;
  final int currentPage;
  final String sortColumn;
  final bool sortAscending;
  final List<Map<String, dynamic>> filteredData;

  const GenericDataTableState({
    required this.data,
    required this.columnConfig,
    this.filterConfigs = const [],
    this.itemsPerPage = 100,
    this.searchQuery = '',
    required this.activeFilters,
    this.currentPage = 1,
    this.sortColumn = '',
    this.sortAscending = true,
    this.filteredData = const [],
  });

  factory GenericDataTableState.initial({
    required List<Map<String, dynamic>> data,
    required Map<String, String> columnConfig,
    List<FilterConfig> filterConfigs = const [],
    int itemsPerPage = 100,
    String searchQuery = '',
    Map<String, String>? activeFilters,
    int currentPage = 1,
    String sortColumn = '',
    bool sortAscending = true,
  }) {
    final initialFilters = activeFilters ??
        {for (var config in filterConfigs) config.field: config.initialValue};

    final initialState = GenericDataTableState(
      data: data,
      columnConfig: columnConfig,
      filterConfigs: filterConfigs,
      itemsPerPage: itemsPerPage,
      searchQuery: searchQuery,
      activeFilters: initialFilters,
      currentPage: currentPage,
      sortColumn: sortColumn,
      sortAscending: sortAscending,
    );

    return initialState._applyFilters()._applySorting();
  }

  GenericDataTableState copyWith({
    List<Map<String, dynamic>>? data,
    Map<String, String>? columnConfig,
    List<FilterConfig>? filterConfigs,
    int? itemsPerPage,
    String? searchQuery,
    Map<String, String>? activeFilters,
    int? currentPage,
    String? sortColumn,
    bool? sortAscending,
    List<Map<String, dynamic>>? filteredData,
  }) {
    return GenericDataTableState(
      data: data ?? this.data,
      columnConfig: columnConfig ?? this.columnConfig,
      filterConfigs: filterConfigs ?? this.filterConfigs,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      searchQuery: searchQuery ?? this.searchQuery,
      activeFilters: activeFilters ?? this.activeFilters,
      currentPage: currentPage ?? this.currentPage,
      sortColumn: sortColumn ?? this.sortColumn,
      sortAscending: sortAscending ?? this.sortAscending,
      filteredData: filteredData ?? this.filteredData,
    );
  }

  GenericDataTableState _applyFilters() {
    if (searchQuery.isEmpty && activeFilters.isEmpty) {
      return copyWith(filteredData: data);
    }

    final filteredData = data.where((item) {
      // Apply search query (only on visible columns)
      if (searchQuery.isNotEmpty) {
        final searchMatch = columnConfig.keys.any((column) {
          final value = item[column]?.toString().toLowerCase() ?? '';
          return value.contains(searchQuery.toLowerCase());
        });
        if (!searchMatch) return false;
      }

      // Apply active filters
      for (final config in filterConfigs) {
        final selectedValue = activeFilters[config.field];
        if (selectedValue != 'All' &&
            item[config.field].toString() != selectedValue) {
          return false;
        }
      }

      return true;
    }).toList();

    return copyWith(filteredData: filteredData);
  }

  GenericDataTableState _applySorting() {
    if (sortColumn.isEmpty || filteredData.isEmpty) {
      return this;
    }

    final sortedData = List<Map<String, dynamic>>.from(filteredData)
      ..sort((a, b) {
        final aValue = a[sortColumn]?.toString() ?? '';
        final bValue = b[sortColumn]?.toString() ?? '';
        return sortAscending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
      });

    return copyWith(filteredData: sortedData);
  }

  int get totalPages => (filteredData.length / itemsPerPage).ceil();

  @override
  List<Object?> get props => [
        data,
        columnConfig,
        filterConfigs,
        itemsPerPage,
        searchQuery,
        activeFilters,
        currentPage,
        sortColumn,
        sortAscending,
        filteredData,
      ];
}