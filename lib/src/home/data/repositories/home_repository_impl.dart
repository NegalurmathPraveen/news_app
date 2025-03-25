import 'package:dartz/dartz.dart';
import 'package:news_app/core/custom_exceptions.dart';
import 'package:news_app/core/env/env.dart';

import '../../../../core/models/error_model.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';
import '../models/all_news_response_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _dataSource;

  HomeRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, AllNewsResponseModel>> getNewsList(int page) async {
    try {
      final response = await _dataSource.getAllNewsResponse(
          apiToken: Env.NEWS_API_KEY, page: page);

      // this is done to check to ensure if there are more results to show or not
      response.meta.hasMaxReached =
          response.meta.found <= response.meta.limit * response.meta.page;

      return Right(response);
    } on ApiException catch (error) {
      return Left(
          Failure(statusCode: error.statusCode!, message: error.message));
    }
  }
}
