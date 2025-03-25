import 'package:dio/dio.dart';
import 'package:news_app/src/home/data/models/all_news_response_model.dart';
import '../../../../core/custom_exceptions.dart';
import '../../../../core/status_codes.dart';
import 'home_remote_data_source.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;
  final String baseUrl;

  HomeRemoteDataSourceImpl({
    required this.dio,
    this.baseUrl = 'https://api.thenewsapi.com/v1/news',
  });

  @override
  Future<AllNewsResponseModel> getAllNewsResponse({
    required String apiToken,
    String language = 'en',
    int limit = 10,
    required int page,
  }) async {
    try {
      final response = await dio.get(
        '$baseUrl/all',
        queryParameters: {
          'api_token': apiToken,
          'language': language,
          'limit': limit,
          'page': page,
        },
      );

      // returning AllNewsResponseModel on success
      if (response.statusCode == StatusCode.success) {
        final allNewsModel = AllNewsResponseModel.fromJson(response.data);
        return allNewsModel;
      } else {
        throw ApiException(
            statusCode: response.statusCode ?? StatusCode.unknown,
            message: response.statusMessage ?? "unknown error");
      }
    } on DioException catch (error) {
      throw ApiException(
          statusCode: error.response?.statusCode ?? StatusCode.unknown,
          message: error.response?.statusMessage ?? "unknown error");
    } catch (e) {
      throw ApiException(
          statusCode: StatusCode.unknown, message: "unknown error");
    }
  }
}
