part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class NewsLoadedState extends HomeState {}

final class NewsListEmptyState extends HomeState {}

final class NewsListLoadingState extends HomeState {}

final class NewsFetchingFailedState extends HomeState {
  final String message;
  NewsFetchingFailedState(this.message);
}

final class ShowErrorOnScreenState extends HomeState {
  final String message;
  ShowErrorOnScreenState(this.message);
}