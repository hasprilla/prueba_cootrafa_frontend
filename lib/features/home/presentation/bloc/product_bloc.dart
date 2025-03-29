import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/failure_converter.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecase/get_product_list_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductListUseCase getProductList;
  ProductBloc({required this.getProductList}) : super(ProductInitialState()) {
    print('===== INIT ProductBloc =====');
    on<GetProductListEvent>(_getAll);
  }

  Future _getAll(GetProductListEvent event, Emitter emit) async {
    emit(GetProductListLoadingState());

    final result = await getProductList(NoParams());

    result.fold(
      (l) => emit(GetProductListFailureState(mapFailureToMessage(l))),
      (r) => emit(GetProductListSuccessState(r)),
    );
  }

  @override
  Future<void> close() {
    logger.i('===== CLOSE ProductBloc =====');
    return super.close();
  }
}
