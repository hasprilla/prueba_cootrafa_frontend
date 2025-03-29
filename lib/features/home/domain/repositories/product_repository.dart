import 'package:fpdart/fpdart.dart';
import 'package:prueba_cootrafa_frontend/core/errors/failures.dart';

import '../entities/product_entity.dart';

abstract interface class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}
