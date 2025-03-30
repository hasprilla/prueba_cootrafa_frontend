import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/inventary_entity.dart';
import '../repositories/inventary_repository.dart';

class GetInventaryListUseCase implements UseCase<List<InventaryEntity>, NoParams> {
  final InventaryRepository _repository;
  const GetInventaryListUseCase(this._repository);

  @override
  Future<Either<Failure, List<InventaryEntity>>> call(NoParams params) async {
    return await _repository.getInventarys();
  }
}
