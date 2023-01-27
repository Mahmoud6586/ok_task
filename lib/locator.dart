import 'package:get_it/get_it.dart';
import 'package:ok_task/core/utils/prefs_manager.dart';
import 'package:ok_task/features/login_feature/data/datasources/login_remote_datasource.dart';
import 'package:ok_task/features/login_feature/data/repositories/login_repository_impl.dart';
import 'package:ok_task/features/login_feature/domain/repositories/login_repository.dart';
import 'package:ok_task/features/login_feature/domain/usecases/login_usecase.dart';
import 'package:ok_task/features/login_feature/presentation/bloc/login_bloc.dart';
import 'package:ok_task/features/product_feature/data/datasources/remote_datasource.dart';
import 'package:ok_task/features/product_feature/data/repositories/product_repository_impl.dart';
import 'package:ok_task/features/product_feature/domain/repositories/products_repository.dart';
import 'package:ok_task/features/product_feature/domain/usecases/get_all_products_usecase.dart';
import 'package:ok_task/features/product_feature/domain/usecases/get_single_product_usecase.dart';
import 'package:ok_task/features/product_feature/presentation/bloc/product_bloc.dart';
import 'package:ok_task/features/product_feature/presentation/bloc/single_product_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> initLocator() async {
  //

  //Shared preferences
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(sharedPreferences);
  locator.registerSingleton<PrefsManager>(PrefsManager());

  //Login bloc
  locator.registerFactory(() => LoginBloc(loginUsecase: locator()));

  locator.registerSingleton<LoginRemoteDatasourceImpl>(
      LoginRemoteDatasourceImpl());
  locator.registerSingleton<LoginRemoteDatasource>(LoginRemoteDatasourceImpl());

  locator
      .registerSingleton<LoginRepositoryImpl>(LoginRepositoryImpl(locator()));
  locator.registerSingleton<LoginRepository>(LoginRepositoryImpl(locator()));

  locator.registerSingleton<LoginUsecase>(LoginUsecase(locator()));

// Products remote datasource
  locator.registerSingleton<RemoteDataSourceImpl>(RemoteDataSourceImpl());
  locator.registerSingleton<RemoteDataSource>(RemoteDataSourceImpl());

// All Products bloc
  locator.registerFactory(() => ProductBloc(
        getAllProductsUsecase: locator(),
      ));
  locator
      .registerSingleton<ProductsRepository>(ProductRepositoryImpl(locator()));
  locator.registerSingleton<GetAllProductsUsecase>(
      GetAllProductsUsecase(locator()));

  locator.registerSingleton<GetSingleProductUsecase>(
      GetSingleProductUsecase(locator()));

//Single product bloc
  locator.registerFactory(
      () => SingleProductBloc(getSingleProductUsecase: locator()));
}
