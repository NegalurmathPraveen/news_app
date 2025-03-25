import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../src/home/data/models/news_data_model.dart';
import '../src/home/presentation/views/details_screen.dart';
import '../src/home/presentation/views/home_screen.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      name: HomeScreen.route,
      path: HomeScreen.route,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          name: NewsDetailsScreen.route,
          path: NewsDetailsScreen.route,
          builder: (BuildContext context, GoRouterState state) {
            return NewsDetailsScreen(newsData: state.extra as NewsDataModel);
          },
        ),
      ],
    ),
  ],
);
