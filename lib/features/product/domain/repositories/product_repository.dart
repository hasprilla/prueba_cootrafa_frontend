import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';

import '../entities/product_entity.dart';

abstract interface class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}
