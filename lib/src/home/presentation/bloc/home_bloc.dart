import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/news_data_model.dart';
import '../../domain/usecases/home_usecases.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCases _homeUseCase;

  int currPage = 1;

  List<NewsDataModel> get newsList => _newsList;

  bool get hasReachedMax => _hasReachedMax;

  final List<NewsDataModel> _newsList = [];

  bool _hasReachedMax = false;

  HomeBloc(this._homeUseCase) : super(HomeInitial()) {
    on<GetNewsEvent>(_getProductEventHandler);
  }

  void _getProductEventHandler(event, emit) async {
    if (!event.fetchInitialPage) {
      currPage++;
    } else {
      currPage = 1;
      _newsList.clear();
      _hasReachedMax = false;
      emit(NewsListLoadingState());
    }
    final result = await _homeUseCase.getNewsList(currPage);
    result.fold((l) {
      if (!event.fetchInitialPage) {
        currPage--;
        emit(NewsFetchingFailedState(l.message));
      } else {
        emit(ShowErrorOnScreenState(l.message));
      }
    }, (r) {
      _newsList.addAll(r.data);
      _hasReachedMax = r.meta.hasMaxReached;
      emit(NewsLoadedState());
    });
  }
}
