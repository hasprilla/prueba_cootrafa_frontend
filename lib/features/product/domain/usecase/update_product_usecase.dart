import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/product_repository.dart';

class UpdateProductUseCase implements UseCase<void, Params> {
  final ProductRepository _repository;
  const UpdateProductUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    if (params.id == null) {
      return Left(EmptyFailure());
    }

    return await _repository.update(params);
  }
}

class Params extends Equatable {
  final int? id;
  final int inventoryId;
  final String name;
  final String barcode;
  final String price;
  final int quantity;

  const Params({
    this.id,
    required this.inventoryId,
    required this.name,
    required this.barcode,
    required this.price,
    required this.quantity,
  });

  @override
  List<Object?> get props => [id, inventoryId, name, barcode, price, quantity];
}
