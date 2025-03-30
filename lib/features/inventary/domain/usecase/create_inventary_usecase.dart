import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/inventary_repository.dart';

class CreateInventaryUseCase implements UseCase<void, Params> {
  final InventaryRepository _repository;
  const CreateInventaryUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await _repository.create(params);
  }
}

class Params extends Equatable {
  final String id;
  final String name;

  const Params({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
