import 'package:dartz/dartz.dart';

import '../../../../core/models/error_model.dart';
import '../../data/models/all_news_response_model.dart';


abstract interface class HomeRepository {
  Future<Either<Failure, AllNewsResponseModel>> getNewsList(int page);
}