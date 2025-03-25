import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/src/home/data/models/news_data_model.dart';
import 'package:news_app/core/widgets/custom_cache_network_image.dart';
import 'package:news_app/src/home/presentation/views/widgets/news_tile.dart';

void main() {
  testWidgets('NewsTile displays news data correctly and responds to tap',
      (WidgetTester tester) async {
    // Arrange
    final newsData = NewsDataModel(
      uuid: '12345-abcde',
      title: 'Test News Title',
      description: 'This is a mock description for testing.',
      keywords: 'mock, test, flutter',
      snippet: 'This is a short snippet for the mock news article.',
      url: 'https://example.com/news/article',
      imageUrl: 'https://example.com/image.jpg',
      language: 'en',
      publishedAt: DateTime.parse('2025-03-25T10:00:00Z'),
      source: 'Mock News Source',
      categories: ['Technology', 'Flutter'],
      relevanceScore: 0.95,
    );

    bool wasPressed = false;

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, build) {
          return MaterialApp(
            home: Scaffold(
              body: NewsTile(
                newsData: newsData,
                onPressed: () => wasPressed = true,
              ),
            ),
          );
        },
      ),
    );

    // Act & Assert
    expect(find.text('Technology'), findsOneWidget);
    expect(find.text('Test News Title'), findsOneWidget);
    expect(find.text('This is a mock description for testing.'),
        findsOneWidget);
    expect(find.byType(CustomCachedNetworkImage), findsOneWidget);

    await tester.tap(find.byType(InkWell));
    await tester.pump();
    expect(wasPressed, isTrue);
  });
}
