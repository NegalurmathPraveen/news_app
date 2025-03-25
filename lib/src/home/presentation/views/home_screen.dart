import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/extensions/context_extension.dart';
import 'package:news_app/core/widgets/custom_error_widget.dart';
import 'package:news_app/src/home/presentation/views/widgets/empty_new_list_widget.dart';

import '../../../../core/init_app.dart';
import '../bloc/home_bloc.dart';
import 'details_screen.dart';
import 'widgets/news_tile.dart';

class HomeScreen extends StatefulWidget {
  static const route =
      '/'; // since this is the home screen this is kept as default route
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bloc = getIt<HomeBloc>();

  @override
  void initState() {
    _bloc.add(GetNewsEvent(fetchInitialPage: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("News App"),
          surfaceTintColor: Colors.transparent,
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: BlocConsumer<HomeBloc, HomeState>(
              bloc: _bloc,
              listener: (context, state) {
                if (state is NewsFetchingFailedState) {
                  context.showSnackBar(text: state.message);
                }
              },
              builder: (context, state) {
                if (state is NewsListLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ShowErrorOnScreenState) {
                  // show error on ui for the user only if the api fails on first fetch otherwise show error via snack bar
                  return CustomErrorWidget(
                      errorMessage: state.message,
                      onRetry: () {
                        _bloc.add(GetNewsEvent(fetchInitialPage: true));
                      });
                } else if(_bloc.newsList.isEmpty){
                  return const EmptyNewsListWidget();
                }
                return RefreshIndicator(
                  // refresh indicator for pull to refresh action
                  onRefresh: () async {
                   // _bloc.add(GetNewsEvent(fetchInitialPage: true));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(5.w),
                    child: ListView.separated(
                      shrinkWrap: false,
                      cacheExtent: 1000,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      // below condition is not to show loading when error state occurs
                      itemCount: _bloc.hasReachedMax ||
                              state is NewsFetchingFailedState
                          ? _bloc.newsList.length
                          : _bloc.newsList.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index >= _bloc.newsList.length) {
                          if (!_bloc.hasReachedMax) {
                            _bloc.add(GetNewsEvent());
                            return Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(bottom: 5.h),
                                child: SizedBox.square(
                                    dimension: 25.w,
                                    child:
                                        const CircularProgressIndicator())); // Loading indicator
                          }
                          return const SizedBox.shrink();
                        } else {
                          final newsData = _bloc.newsList[index];
                          return NewsTile(
                            newsData: newsData,
                            onPressed: () => context.pushNamed(
                                NewsDetailsScreen.route,
                                extra: newsData),
                          );
                        }
                      },
                      // seperator widget
                      separatorBuilder: (context, index) => 10.verticalSpace,
                    ),
                  ),
                );
              },
            )));
  }
}
