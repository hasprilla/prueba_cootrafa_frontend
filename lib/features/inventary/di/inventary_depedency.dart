import '../../../core/api/api_helper.dart';
import '../../../core/injector/injector_conf.dart';
import '../data/datasources/inventary_remote_datasource.dart';
import '../data/repositories/inventary_repository_impl.dart';
import '../domain/usecase/create_inventary_usecase.dart';
import '../domain/usecase/delete_inventary_usecase.dart';
import '../domain/usecase/get_inventary_list_usecase.dart';
import '../domain/usecase/update_inventary_usecase.dart';
import '../presentation/bloc/inventary_bloc.dart';

class InventaryDependency {
  InventaryDependency._();
  static void init() {
    sl.registerFactory(
      () => InventaryBloc(
        getInventaryList: sl<GetInventaryListUseCase>(),
        createInventary: sl<CreateInventaryUseCase>(),
        updateInventary: sl<UpdateInventaryUseCase>(),
        deleteInventary: sl<DeleteInventaryUseCase>(),
      ),
    );

    sl.registerLazySingleton(
      () => GetInventaryListUseCase(sl<InventaryRepositoryImpl>()),
    );

    sl.registerLazySingleton(
      () => CreateInventaryUseCase(sl<InventaryRepositoryImpl>()),
    );

    sl.registerLazySingleton(
      () => UpdateInventaryUseCase(sl<InventaryRepositoryImpl>()),
    );

    sl.registerLazySingleton(
      () => DeleteInventaryUseCase(sl<InventaryRepositoryImpl>()),
    );

    sl.registerLazySingleton(
      () => InventaryRepositoryImpl(
        remoteDataSource: sl<InventaryRemoteDataSourceImpl>(),
      ),
    );

    sl.registerLazySingleton(
      () => InventaryRemoteDataSourceImpl(apiHelper: sl<ApiHelper>()),
    );
  }
}
