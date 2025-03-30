import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/injector/injector_conf.dart';
import 'features/inventary/presentation/bloc/inventary_bloc.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'core/routes/app_route_conf.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = sl<AppRouteConf>().router;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ProductBloc>()..add(GetProductListEvent()),
        ),
        BlocProvider(
          create:
              (context) => sl<InventaryBloc>()..add(GetInventaryListEvent()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Prueba Cootrafa',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routerConfig: router,
      ),
    );
  }
}
