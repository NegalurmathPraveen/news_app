import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/core/custom_exceptions.dart';
import 'package:news_app/core/env/env.dart';
import 'package:news_app/core/status_codes.dart';
import 'package:news_app/core/models/error_model.dart';
import 'package:news_app/src/home/data/datasources/home_remote_data_source.dart';
import 'package:news_app/src/home/data/models/all_news_response_model.dart';
import 'package:news_app/src/home/data/models/meta_data_model.dart';
import 'package:news_app/src/home/data/repositories/home_repository_impl.dart';

// Mock class for HomeRemoteDataSource
class MockHomeRemoteDataSource extends Mock implements HomeRemoteDataSource {}

void main() {
  late HomeRepositoryImpl homeRepository;
  late MockHomeRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockHomeRemoteDataSource();
    homeRepository = HomeRepositoryImpl(mockRemoteDataSource);
  });

  group('getNewsList', () {
    final int page = 1;
    final response = AllNewsResponseModel(
      // Initialize with the necessary fields
      meta: MetaDataModel(page: 1, limit: 10, found: 100, returned: 10),
      // Add mock data for news items
      data: [],
    );

    test('should return Right(AllNewsResponseModel) when call is successful',
        () async {
      // Arrange
      when(() => mockRemoteDataSource.getAllNewsResponse(
            apiToken: Env.NEWS_API_KEY,
            page: page,
          )).thenAnswer((_) async => response);

      // Act
      final result = await homeRepository.getNewsList(page);

      // Assert
      expect(result,
          Right(response)); // Check that the result is a successful response
      verify(() => mockRemoteDataSource.getAllNewsResponse(
            apiToken: Env.NEWS_API_KEY,
            page: page,
          ));
    });

    test('should return Left(Failure) when DioException occurs', () async {
      // Arrange
      when(() => mockRemoteDataSource.getAllNewsResponse(
            apiToken: Env.NEWS_API_KEY,
            page: page,
          )).thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
        error: 'Network Error',
      ));

      // Act
      final result = await homeRepository.getNewsList(page);

      // Assert
      expect(result, isA<Left<Failure, AllNewsResponseModel>>());
      final failure = (result as Left).value;
      expect(failure.statusCode, StatusCode.unknown);
      expect(failure.message, "unauthorized");
    });

    test('should return Left(Failure) when ApiException occurs', () async {
      // Arrange
      when(() => mockRemoteDataSource.getAllNewsResponse(
            apiToken: Env.NEWS_API_KEY,
            page: page,
          )).thenThrow(ApiException(
        message: 'API error',
        statusCode: StatusCode.unknown,
      ));

      // Act
      final result = await homeRepository.getNewsList(page);

      // Assert
      expect(result, isA<Left<Failure, AllNewsResponseModel>>());
      final failure = (result as Left).value;
      expect(failure.statusCode, StatusCode.unknown);
      expect(failure.message, 'API error');
    });
  });
}
