import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager {
  static final instance = CacheManager(
    Config(
      'customCache',
      stalePeriod: const Duration(days: 7), // cache storage time
      maxNrOfCacheObjects: 10000, // max number of cache objects that can be stored
    ),
  );
}