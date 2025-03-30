import '../../../../core/api/api_helper.dart';
import '../../../../core/api/api_url.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/logger.dart';
import '../models/produc_model.dart';

abstract interface class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();

  Future<void> createProduct(ProductModel model);
  Future<void> updateProduct(ProductModel model);
  Future<void> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiHelper apiHelper;

  const ProductRemoteDataSourceImpl({required this.apiHelper});

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await apiHelper.execute(
        method: Method.get,
        url: ApiUrl.products,
      );
      return List<Map<String, dynamic>>.from(
        response['data'],
      ).map(ProductModel.fromJson).toList();
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> createProduct(ProductModel model) async {
    try {
      await apiHelper.execute(
        method: Method.post,
        url: ApiUrl.products,
        data: model.toJson(),
      );
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      await apiHelper.execute(
        method: Method.delete,
        url: '${ApiUrl.products}/$id',
      );
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> updateProduct(ProductModel model) async {
    try {
      await apiHelper.execute(
        method: Method.put,
        url: '${ApiUrl.products}/${model.id}',
        data: model.toJson(),
      );
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }
}
