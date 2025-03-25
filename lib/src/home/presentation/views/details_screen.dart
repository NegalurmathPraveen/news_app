import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/src/home/data/models/news_data_model.dart';

import '../../../../core/widgets/custom_cache_network_image.dart';

class NewsDetailsScreen extends StatelessWidget {
  static const route = '/news-details-screen';
  final NewsDataModel newsData;

  const NewsDetailsScreen({super.key, required this.newsData});

  @override
  Widget build(BuildContext context) {
    final imageUrl = newsData.imageUrl != null && newsData.imageUrl!.isNotEmpty
        ? newsData.imageUrl!
        : "https://www.iconsdb.com/icons/preview/white/photo-xxl.png";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.white,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: InteractiveViewer(
            minScale: 1,
            maxScale: 3,
            child: CustomCachedNetworkImage(
              imageUrl: imageUrl,
              width: 1.sw,
              height: 0.5.sh,
              fit: BoxFit.contain,
            )),
      ),
    );
  }
}
