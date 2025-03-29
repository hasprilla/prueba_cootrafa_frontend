
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';


import '../routes/app_route_conf.dart';
import 'injector.dart';

final sl = GetIt.I;

void configureDepedencies() {
  // ProductDependency.init();


  sl.registerLazySingleton(
    () => AppRouteConf(),
  );

  sl.registerLazySingleton(
    () => ApiHelper(
      sl<Dio>(),
    ),
  );

  sl.registerLazySingleton(
    () => Dio()
      ..interceptors.add(
        sl<ApiInterceptor>(),
      ),
  );

  sl.registerLazySingleton(
    () => ApiInterceptor(),
  );




}
