part of 'home_bloc.dart';

sealed class HomeEvent {}

class GetNewsEvent extends HomeEvent{
  bool fetchInitialPage;
  GetNewsEvent({this.fetchInitialPage = false});
}