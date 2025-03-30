import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/failure_converter.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecase/create_product_usecase.dart';
import '../../domain/usecase/delete_product_usecase.dart';
import '../../domain/usecase/get_product_list_usecase.dart';
import '../../domain/usecase/update_product_usecase.dart';
import '../../domain/usecase/usecase_params.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductListUseCase getProductList;
  final CreateProductUseCase createProduct;
  final DeleteProductUseCase deleteProduct;
  final UpdateProductUseCase updateProduct;
  ProductBloc({
    required this.getProductList,
    required this.createProduct,
    required this.deleteProduct,
    required this.updateProduct,
  }) : super(ProductInitialState()) {
    on<GetProductListEvent>(_getAll);
    on<CreateProductEvent>(_create);
    on<DeleteProductEvent>(_delete);
    on<UpdateProductEvent>(_update);
  }

  Future _getAll(GetProductListEvent event, Emitter emit) async {
    emit(GetProductListLoadingState());

    final result = await getProductList(NoParams());

    result.fold(
      (l) => emit(GetProductListFailureState(mapFailureToMessage(l))),
      (r) => emit(GetProductListSuccessState(r)),
    );
  }

  Future _create(CreateProductEvent event, Emitter emit) async {
    emit(CreateProductLoadingState());

    final result = await createProduct(
      CreateProductParams(
        inventoryId: event.inventoryId,
        name: event.name,
        barcode: event.barcode,
        price: event.price,
        quantity: event.quantity,
      ),
    );

    result.fold(
      (l) => emit(CreateProductFailureState(mapFailureToMessage(l))),
      (r) {
        emit(CreateProductSuccessState());
        add(GetProductListEvent());
      },
    );
  }

  Future _delete(DeleteProductEvent event, Emitter emit) async {
    emit(DeleteProductLoadingState());

    final result = await deleteProduct(DeleteProductParams(id: event.id));

    result.fold(
      (l) => emit(DeleteProductFailureState(mapFailureToMessage(l))),
      (r) {
        emit(DeleteProductSuccessState());
        add(GetProductListEvent());
      },
    );
  }

  Future _update(UpdateProductEvent event, Emitter emit) async {
    emit(UpdateProductLoadingState());

    final result = await updateProduct(
      UpdateProductParams(
        id: event.id,
        inventoryId: event.inventoryId,
        name: event.name,
        barcode: event.barcode,
        price: event.price,
        quantity: event.quantity,
      ),
    );

    result.fold(
      (l) => emit(UpdateProductFailureState(mapFailureToMessage(l))),
      (r) {
        emit(UpdateProductSuccessState());
        add(GetProductListEvent());
      },
    );
  }

  @override
  Future<void> close() {
    logger.i('===== CLOSE ProductBloc =====');
    return super.close();
  }
}
