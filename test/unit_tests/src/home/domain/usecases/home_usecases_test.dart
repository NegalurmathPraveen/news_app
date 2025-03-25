import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/core/models/error_model.dart';
import 'package:news_app/src/home/data/models/all_news_response_model.dart';
import 'package:news_app/src/home/data/models/meta_data_model.dart';
import 'package:news_app/src/home/data/models/news_data_model.dart';
import 'package:news_app/src/home/domain/repositories/home_repository.dart';
import 'package:news_app/src/home/domain/usecases/home_usecases.dart';

// Mock class for HomeRepository
class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late HomeUseCases homeUseCases;
  late MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    homeUseCases = HomeUseCases(mockHomeRepository);
  });

  group('getNewsList', () {
    const int page = 1;
    final response = AllNewsResponseModel(
      meta: MetaDataModel(page: 1, limit: 10, found: 100, returned: 10),
      data: [
        NewsDataModel(
          uuid: '1234-5678-91011',
          title: 'Sample News Title',
          description: 'This is a sample description for the news article.',
          keywords: 'sample, news, article, flutter',
          snippet: 'This is a brief snippet of the news article.',
          url: 'https://www.example.com/sample-news',
          imageUrl: 'https://www.example.com/sample-image.jpg',
          language: 'en',
          publishedAt: DateTime.now(),
          // Use the current date and time
          source: 'Sample News Source',
          categories: ['Technology', 'Flutter'],
          relevanceScore: 0.85, // Example relevance score
        )
      ],
    );

    test(
        'should return Right(AllNewsResponseModel) when repository call is successful',
        () async {
      // Arrange
      when(()=>mockHomeRepository.getNewsList(page))
          .thenAnswer((_) async => Right(response));

      // Act
      final result = await homeUseCases.getNewsList(page);

      // Assert
      expect(
          result, Right(response)); // Ensure it returns a successful response
      verify(()=>mockHomeRepository
          .getNewsList(page)); // Verify that the method is called
      verifyNoMoreInteractions(
          mockHomeRepository); // Ensure no other interactions occur
    });

    test('should return Left(Failure) when repository returns a failure',
        () async {
      // Arrange
      const failure = Failure(statusCode: 500, message: 'Server error');
      when(()=>mockHomeRepository.getNewsList(page))
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await homeUseCases.getNewsList(page);

      // Assert
      expect(result, const Left(failure)); // Ensure it returns a failure
      verify(()=>mockHomeRepository
          .getNewsList(page)); // Verify that the method is called
      verifyNoMoreInteractions(
          mockHomeRepository); // Ensure no other interactions occur
    });
  });
}
