import '../../../../core/api/api_helper.dart';
import '../../../../core/api/api_url.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/logger.dart';
import '../models/inventary_model.dart';

abstract interface class InventaryRemoteDataSource {
  Future<List<InventaryModel>> getInventarys();
  Future<void> createInventary(InventaryModel model);
  Future<void> deleteInventary(String id);
  Future<void> updateInventary(InventaryModel model);
}

class InventaryRemoteDataSourceImpl implements InventaryRemoteDataSource {
  final ApiHelper apiHelper;

  const InventaryRemoteDataSourceImpl({required this.apiHelper});

  @override
  Future<List<InventaryModel>> getInventarys() async {
    try {
      final response = await apiHelper.execute(
        method: Method.get,
        url: ApiUrl.inventary,
      );
      return List<Map<String, dynamic>>.from(
        response['data'],
      ).map(InventaryModel.fromJson).toList();
    } catch (e, s) {
      logger.e(s);
      throw ServerException();
    }
  }

  @override
  Future<void> createInventary(InventaryModel model) async {
    try {
      await apiHelper.execute(
        method: Method.post,
        url: ApiUrl.inventary,
        data: model.toJson().removeNulls(),
      );
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> deleteInventary(String id) async {
    try {
      await apiHelper.execute(
        method: Method.delete,
        url: '${ApiUrl.inventary}/$id',
      );
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> updateInventary(InventaryModel model) async {
    try {
      await apiHelper.execute(
        method: Method.put,
        url: '${ApiUrl.inventary}/${model.id}',
        data: model.toJson(),
      );
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }
}

extension RemoveNullsFromMap on Map<String, dynamic> {
  Map<String, dynamic> removeNulls() {
    removeWhere((key, value) => value == null);
    return this;
  }
}
