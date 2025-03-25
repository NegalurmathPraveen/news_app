import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../src/home/data/datasources/home_remote_data_source.dart';
import '../src/home/data/datasources/home_remote_datasource_impl.dart';
import '../src/home/data/repositories/home_repository_impl.dart';
import '../src/home/domain/repositories/home_repository.dart';
import '../src/home/domain/usecases/home_usecases.dart';
import '../src/home/presentation/bloc/home_bloc.dart';


final getIt = GetIt.instance;

void initApp() {
  initiateGetIt();
}

initiateGetIt() {
  final dio = Dio();
  getIt
    ..registerLazySingleton<Dio>(() => dio)
    ..registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(dio: getIt()))
    ..registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(getIt()))
    ..registerLazySingleton<HomeUseCases>(() => HomeUseCases(getIt()))
    ..registerFactory<HomeBloc>(() => HomeBloc(getIt()));

  dio.interceptors.add(
      PrettyDioLogger(requestHeader: true, requestBody: true, responseBody: true, responseHeader: false, compact: true, maxWidth: 100));
}
