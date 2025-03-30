import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';

import '../../domain/entities/product_entity.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecase/usecase_params.dart';
import '../datasources/product_remote_datasource.dart';
import '../models/produc_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  const ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final response = await remoteDataSource.getProducts();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> create(CreateProductParams params) async {
    try {
      final model = ProductModel(
        id: params.id,
        inventoryId: params.inventoryId,
        name: params.name,
        barcode: params.barcode,
        price: params.price,
        quantity: params.quantity,
      );
      final response = await remoteDataSource.createProduct(model);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> delete(DeleteProductParams params) async {
    try {
      final response = await remoteDataSource.deleteProduct(params.id);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> update(UpdateProductParams params) async {
    try {
      final model = ProductModel(
        id: params.id,
        inventoryId: params.inventoryId,
        name: params.name,
        barcode: params.barcode,
        price: params.price,
        quantity: params.quantity,
      );
      final response = await remoteDataSource.updateProduct(model);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
