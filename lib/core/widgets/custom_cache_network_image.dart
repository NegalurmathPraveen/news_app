import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/custom_cache_manager.dart';
import 'package:news_app/core/extensions/widget_extension.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const CustomCachedNetworkImage(
      {super.key, required this.imageUrl, this.height, this.width, this.fit});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: CustomCacheManager.instance,
      imageUrl: imageUrl != null && imageUrl!.isNotEmpty
          ? imageUrl!
          : "https://www.iconsdb.com/icons/preview/white/photo-xxl.png",
      width: width?.w,
      height: height?.h,
      fit: fit,
      progressIndicatorBuilder: (context, url, downloadProgress) => const Icon(
        Icons.image_outlined,
        size: 50,
      ).shimmer(enableShimmer: true),

      errorWidget: (context, url, error) {
        log("error:$error");
        return Icon(Icons.error, size: 50.w);
      }, // Fallback icon in case of image loading error
    );
  }
}
