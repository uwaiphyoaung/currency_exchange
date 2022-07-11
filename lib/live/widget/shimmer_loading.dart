import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  const ShimmerLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: 1.0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            shimmerWidget(width: double.infinity, height: 5.h),
            SizedBox(height: 1.h,),
            shimmerWidget(width: double.infinity, height: 5.h),
            SizedBox(height: 1.h,),
            shimmerWidget(width: double.infinity, height: 5.h),
            SizedBox(height: 1.h,),
            shimmerWidget(width: double.infinity, height: 5.h),
            SizedBox(height: 1.h,),
            shimmerWidget(width: double.infinity, height: 5.h),
            SizedBox(height: 1.h,),
            shimmerWidget(width: double.infinity, height: 5.h),
            SizedBox(height: 1.h,),
            shimmerWidget(width: double.infinity, height: 5.h),
            SizedBox(height: 1.h,),
            shimmerWidget(width: double.infinity, height: 5.h),
            SizedBox(height: 1.h,),
            shimmerWidget(width: double.infinity, height: 5.h),
            SizedBox(height: 1.h,),
            shimmerWidget(width: double.infinity, height: 5.h),
            SizedBox(height: 1.h,),
            shimmerWidget(width: double.infinity, height: 5.h),
            SizedBox(height: 1.h,),
            shimmerWidget(width: double.infinity, height: 5.h),
            SizedBox(height: 1.h,),
            shimmerWidget(width: double.infinity, height: 5.h),
          ],
        ),
      ),
    );
  }
}


Widget shimmerWidget(
    {required double width, required double height, double radius = 7.0}) =>
    Shimmer.fromColors(
      baseColor: Colors.grey.shade100,
      highlightColor: Colors.grey.shade300,
      direction: ShimmerDirection.ltr,
      enabled: true,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.all(Radius.circular(radius))),
          width: width,
          height: height,
        ),
      ),
    );