import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/debounce.dart';
import '../models/filter_config.dart';

part 'generic_data_table_state.dart';

class GenericDataTableCubit extends Cubit<GenericDataTableState> {
  final Debouncer _debouncer;

  GenericDataTableCubit({
    required List<Map<String, dynamic>> data,
    required Map<String, String> columnConfig,
    List<FilterConfig> filterConfigs = const [],
    int itemsPerPage = 100,
  })  : _debouncer = Debouncer(milliseconds: 500),
        super(GenericDataTableState.initial(
          data: data,
          columnConfig: columnConfig,
          filterConfigs: filterConfigs,
          itemsPerPage: itemsPerPage,
        ));

  void applyFilters({
    String? searchQuery,
    Map<String, String>? activeFilters,
  }) {
    _debouncer.run(() {
      if (searchQuery == state.searchQuery &&
          activeFilters == state.activeFilters) {
        return;
      }

      final newState = state.copyWith(
        searchQuery: searchQuery ?? state.searchQuery,
        activeFilters: activeFilters ?? state.activeFilters,
      );
      emit(newState._applyFilters()._applySorting());
    });
  }

  void sort(String column, bool ascending) {
    if (column == state.sortColumn && ascending == state.sortAscending) {
      return;
    }

    emit(state
        .copyWith(
          sortColumn: column,
          sortAscending: ascending,
        )
        ._applySorting());
  }

  void goToPage(int page) {
    if (page == state.currentPage) {
      return;
    }

    emit(state.copyWith(currentPage: page));
  }

  void clearFilters() {
    if (state.searchQuery.isEmpty && state.activeFilters.isEmpty) {
      return;
    }

    emit(state
        .copyWith(
          searchQuery: '',
          activeFilters: Map.fromEntries(
            state.filterConfigs
                .map((config) => MapEntry(config.field, config.initialValue)),
          ),
        )
        ._applyFilters());
  }

  @override
  Future<void> close() {
    _debouncer.dispose();
    return super.close();
  }
}
