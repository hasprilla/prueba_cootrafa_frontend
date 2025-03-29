import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:async';

import 'app.dart';
import 'core/injector/injector_conf.dart';
import 'core/utils/observer.dart';

//Test

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    getTemporaryDirectory().then((path) async {
      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: path,
      );
    }),
  ]);

  configureDepedencies();
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}
