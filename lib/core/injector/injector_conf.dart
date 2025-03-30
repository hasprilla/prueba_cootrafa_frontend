import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../../features/inventary/di/inventary_depedency.dart';
import '../../features/product/di/product_depedency.dart';
import '../routes/app_route_conf.dart';
import 'injector.dart';

final sl = GetIt.I;

void configureDepedencies() {
  ProductDependency.init();
  InventaryDependency.init();

  if (sl.isRegistered<AppRouteConf>()) {
    sl.unregister<AppRouteConf>();
  }

  sl.registerLazySingleton<AppRouteConf>(() => AppRouteConf());

  sl.registerLazySingleton(() => ApiHelper(sl<Dio>()));

  sl.registerLazySingleton(() => Dio()..interceptors.add(sl<ApiInterceptor>()));

  sl.registerLazySingleton(() => ApiInterceptor());
}
