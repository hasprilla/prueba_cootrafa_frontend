import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_cootrafa_frontend/core/injector/injector_conf.dart';
import 'package:prueba_cootrafa_frontend/core/utils/show_error_dialog.dart';
import 'package:prueba_cootrafa_frontend/features/home/presentation/bloc/product_bloc.dart';
import 'package:prueba_cootrafa_frontend/core/routes/app_route_conf.dart';
import 'package:prueba_cootrafa_frontend/features/home/presentation/widgets/loading_overlay.dart';

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
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Prueba Cootrafa',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routerConfig: router,
        builder: (context, child) {
          return BlocListener<ProductBloc, ProductState>(
            listener: (context, state) {
              if (state is GetProductListFailureState) {
                showErrorDialog(context, state.message);
              }
            },
            child: Stack(
              children: [
                child!,
                if (context.select<ProductBloc, bool>(
                  (bloc) => bloc.state is GetProductListLoadingState,
                ))
                  const LoadingOverlay(),
              ],
            ),
          );
        },
      ),
    );
  }
}
