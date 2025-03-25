import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

extension WidgetExtension on Widget {
  Widget shimmer({bool enableShimmer = true, double width = 100, double height = 12}) {
    return enableShimmer
        ? Shimmer.fromColors(
            enabled: enableShimmer,
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            direction: ShimmerDirection.ttb,
            child: this is Text
                ? Container(
                    width: width.w,
                    height: height.h,
                    color: Colors.white,
                  )
                : this,
          )
        : this;
  }
}
