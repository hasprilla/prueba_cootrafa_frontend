import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/inventary_repository.dart';

class UpdateInventaryUseCase implements UseCase<void, Params> {
  final InventaryRepository _repository;
  const UpdateInventaryUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    if (params.id == '') {
      return Left(EmptyFailure());
    }

    return await _repository.update(params);
  }
}

class Params extends Equatable {
  final String id;
  final String name;

  const Params({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
