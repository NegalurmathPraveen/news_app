import 'package:flutter_test/flutter_test.dart';

import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/core/custom_exceptions.dart';
import 'package:news_app/core/status_codes.dart';
import 'package:news_app/src/home/data/datasources/home_remote_datasource_impl.dart';
import 'package:news_app/src/home/data/models/all_news_response_model.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('HomeRemoteDataSourceImpl', () {
    late HomeRemoteDataSourceImpl dataSource;
    late MockDio mockDio;
    const url = "https://api.thenewsapi.com/v1/news/all";

    setUp(() {
      mockDio = MockDio();
      dataSource = HomeRemoteDataSourceImpl(dio: mockDio);
    });

    // TODO: below test is failing need to check
    test('should return AllNewsResponseModel when the response is successful', () async {
      // Arrange
      final responseData = {
        'status': 'ok',
        'total': 10,
        'articles': [],
      };

      final response = Response(
        data: responseData,
        statusCode: StatusCode.success,
        requestOptions: RequestOptions(path: 'test'),
      );

      when(() => mockDio.get(url, queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => response);

      // Act
      final result = await dataSource.getAllNewsResponse(
        apiToken: 'fake_api_token',
        page: 1,
      );

      // Assert: Make sure the result is an instance of AllNewsResponseModel
      expect(result, isA<AllNewsResponseModel>());
    });

    test('should throw ApiException when response has non-success status code', () async {
      // Arrange
      final response = Response(
        data: {},
        statusCode: StatusCode.unknown,
        statusMessage: 'Unauthorized',
        requestOptions: RequestOptions(path: 'test'),
      );

      when(()=>mockDio.get(url, queryParameters: any(named:'queryParameters')))
          .thenAnswer((_) async => response);

      // Act & Assert
      expect(
            () async => await dataSource.getAllNewsResponse(
          apiToken: 'fake_api_token',
          page: 1,
        ),
        throwsA(isA<ApiException>()),
      );
    });

    test('should throw an error when Dio throws an exception', () async {
      // Arrange
      when(()=>mockDio.get(url, queryParameters: any(named:'queryParameters')))
          .thenThrow(DioError(
        requestOptions: RequestOptions(path: 'test'),
        type: DioErrorType.unknown,
      ));

      // Act & Assert
      expect(
            () async => await dataSource.getAllNewsResponse(
          apiToken: 'fake_api_token',
          page: 1,
        ),
        throwsA(isA<DioError>()),
      );
    });
  });
}
