import 'package:dartz/dartz.dart';

import '../../../../core/models/error_model.dart';
import '../../data/models/all_news_response_model.dart';
import '../repositories/home_repository.dart';

class HomeUseCases {
  final HomeRepository _homeRepository;

  const HomeUseCases(this._homeRepository);

  Future<Either<Failure, AllNewsResponseModel>> getNewsList(int page) async => _homeRepository.getNewsList(page);
}
