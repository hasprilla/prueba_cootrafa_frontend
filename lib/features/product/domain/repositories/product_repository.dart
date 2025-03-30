import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';

import '../entities/product_entity.dart';
import '../usecase/usecase_params.dart';

abstract interface class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, void>> create(CreateProductParams params);
  Future<Either<Failure, void>> delete(DeleteProductParams params);
  Future<Either<Failure, void>> update(UpdateProductParams params);
}
