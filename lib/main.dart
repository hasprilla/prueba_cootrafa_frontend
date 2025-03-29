import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/injector/injector_conf.dart';
import 'core/utils/observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDepedencies();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}
