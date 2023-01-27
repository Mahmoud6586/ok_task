import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ok_task/features/login_feature/presentation/screens/login_screen.dart';
import 'package:ok_task/features/product_feature/presentation/screens/home_screen.dart';

import 'package:ok_task/locator.dart';

import 'core/utils/prefs_manager.dart';
import 'features/login_feature/presentation/bloc/login_bloc.dart';
import 'features/product_feature/presentation/bloc/product_bloc.dart';
import 'features/product_feature/presentation/bloc/single_product_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => locator<ProductBloc>(),
          ),
          BlocProvider(
            create: (context) => locator<SingleProductBloc>(),
          ),
          BlocProvider(
            create: (context) => locator<LoginBloc>(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const LoginScreen(),
          routes: {
            HomeScreen.routeName: (context) => const HomeScreen(),
          },
        ));
  }
}
