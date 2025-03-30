import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/failure_converter.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/inventary_entity.dart';
import '../../domain/usecase/create_inventary_usecase.dart';
import '../../domain/usecase/delete_inventary_usecase.dart';
import '../../domain/usecase/get_inventary_list_usecase.dart';
import '../../domain/usecase/update_inventary_usecase.dart';
import '../../domain/usecase/usecase_params.dart';

part 'inventary_event.dart';
part 'inventary_state.dart';

class InventaryBloc extends Bloc<InventaryEvent, InventaryState> {
  final GetInventaryListUseCase getInventaryList;
  final CreateInventaryUseCase createInventary;
  final UpdateInventaryUseCase updateInventary;
  final DeleteInventaryUseCase deleteInventary;
  InventaryBloc({
    required this.getInventaryList,
    required this.createInventary,
    required this.updateInventary,
    required this.deleteInventary,
  }) : super(InventaryInitialState()) {
    on<GetInventaryListEvent>(_getAll);
    on<CreateInventaryEvent>(_create);
    on<UpdateInventaryEvent>(_update);
    on<DeleteInventaryEvent>(_delete);
  }

  Future _getAll(GetInventaryListEvent event, Emitter emit) async {
    emit(GetInventaryListLoadingState());

    final result = await getInventaryList(NoParams());

    result.fold(
      (l) => emit(GetInventaryListFailureState(mapFailureToMessage(l))),
      (r) => emit(GetInventaryListSuccessState(r)),
    );
  }

  Future _create(CreateInventaryEvent event, Emitter emit) async {
    emit(CreateInventaryLoadingState());

    final result = await createInventary(
      CreateInventaryParams(name: event.name),
    );

    await result.fold(
      (l) async => emit(CreateInventaryFailureState(mapFailureToMessage(l))),
      (r) async {
        emit(CreateInventarySuccessState());
        add(GetInventaryListEvent());
      },
    );
  }

  Future _update(UpdateInventaryEvent event, Emitter emit) async {
    emit(UpdateInventaryLoadingState());

    final result = await updateInventary(
      UpdateInventaryParams(id: event.id, name: event.name),
    );

    result.fold(
      (l) => emit(UpdateInventaryFailureState(mapFailureToMessage(l))),
      (r) {
        emit(UpdateInventarySuccessState());
        add(GetInventaryListEvent());
      },
    );
  }

  Future _delete(DeleteInventaryEvent event, Emitter emit) async {
    emit(DeleteInventaryLoadingState());

    final result = await deleteInventary(DeleteInventaryParams(id: event.id));

    result.fold(
      (l) => emit(DeleteInventaryFailureState(mapFailureToMessage(l))),
      (r) {
        emit(DeleteInventarySuccessState());
        add(GetInventaryListEvent());
      },
    );
  }

  @override
  Future<void> close() {
    logger.i('===== CLOSE InventaryBloc =====');
    return super.close();
  }
}
