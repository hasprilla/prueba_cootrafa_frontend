import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/inventary_entity.dart';
import '../../domain/repositories/inventary_repository.dart';
import '../../domain/usecase/usecase_params.dart';
import '../datasources/inventary_remote_datasource.dart';
import '../models/inventary_model.dart';

class InventaryRepositoryImpl implements InventaryRepository {
  final InventaryRemoteDataSource remoteDataSource;

  const InventaryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<InventaryEntity>>> getInventarys() async {
    try {
      final response = await remoteDataSource.getInventarys();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> create(CreateInventaryParams params) async {
    try {
      final model = InventaryModel(name: params.name);
      final response = remoteDataSource.createInventary(model);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> delete(String id) async {
    try {
      final response = await remoteDataSource.deleteInventary(id);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> update(UpdateInventaryParams params) async {
    try {
      final model = InventaryModel(id: params.id, name: params.name);
      final response = await remoteDataSource.updateInventary(model);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
