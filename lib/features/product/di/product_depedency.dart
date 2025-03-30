import '../../../core/api/api_helper.dart';
import '../../../core/injector/injector_conf.dart';
import '../data/datasources/product_remote_datasource.dart';
import '../data/repositories/product_repository_impl.dart';
import '../domain/usecase/create_product_usecase.dart';
import '../domain/usecase/delete_product_usecase.dart';
import '../domain/usecase/get_product_list_usecase.dart';
import '../domain/usecase/update_product_usecase.dart';
import '../presentation/bloc/product_bloc.dart';

class ProductDependency {
  ProductDependency._();
  static void init() {
    sl.registerFactory(
      () => ProductBloc(
        getProductList: sl<GetProductListUseCase>(),
        createProduct: sl<CreateProductUseCase>(),
        deleteProduct: sl<DeleteProductUseCase>(),
        updateProduct: sl<UpdateProductUseCase>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetProductListUseCase(sl<ProductRepositoryImpl>()),
    );

    sl.registerLazySingleton(
      () => CreateProductUseCase(sl<ProductRepositoryImpl>()),
    );

    sl.registerLazySingleton(
      () => DeleteProductUseCase(sl<ProductRepositoryImpl>()),
    );

    sl.registerLazySingleton(
      () => UpdateProductUseCase(sl<ProductRepositoryImpl>()),
    );

    sl.registerLazySingleton(
      () => ProductRepositoryImpl(
        remoteDataSource: sl<ProductRemoteDataSourceImpl>(),
      ),
    );

    sl.registerLazySingleton(
      () => ProductRemoteDataSourceImpl(apiHelper: sl<ApiHelper>()),
    );
  }
}
