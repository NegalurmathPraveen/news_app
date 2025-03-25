import 'package:flutter/material.dart';
import 'package:news_app/src/home/data/models/news_data_model.dart';

import '../../../../core/widgets/custom_cache_network_image.dart';

class NewsDetailsScreen extends StatelessWidget {
  static const route = '/news-details-screen';
  final NewsDataModel newsData;

  const NewsDetailsScreen({super.key, required this.newsData});

  @override
  Widget build(BuildContext context) {
    final imageUrl = newsData.imageUrl != null && newsData.imageUrl!.isNotEmpty
        ? newsData.imageUrl
        : "https://www.iconsdb.com/icons/preview/white/photo-xxl.png";
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Hero(
          tag: newsData.imageUrl ?? "",
          child: InteractiveViewer(
              scaleFactor: 1000,
              boundaryMargin: const EdgeInsets.all(0),
              child: CustomCachedNetworkImage(
                imageUrl: imageUrl,
                width: double.infinity,
                fit: BoxFit.fitHeight,
              )),
        ),
      ),
    );
  }
}
