import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';

import '../entities/inventary_entity.dart';
import '../usecase/usecase_params.dart';

abstract interface class InventaryRepository {
  Future<Either<Failure, List<InventaryEntity>>> getInventarys();
  Future<Either<Failure, void>> delete(String id);
  Future<Either<Failure, void>> update(UpdateInventaryParams params);
  Future<Either<Failure, void>> create(CreateInventaryParams params);
}
