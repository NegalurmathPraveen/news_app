import '../models/all_news_response_model.dart';

abstract interface class HomeRemoteDataSource {
  Future<AllNewsResponseModel> getAllNewsResponse({
    required String apiToken,
    String language,
    int limit,
    required int page
  });
}
