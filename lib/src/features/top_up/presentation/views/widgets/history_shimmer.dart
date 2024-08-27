import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HistoryShimmer extends StatelessWidget {
  const HistoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.sp),
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: Colors.grey.shade300.withOpacity(0.4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 18.sp, width: 0.6.sw, color: Colors.grey.shade200),
                10.verticalSpace,
                _buildShimmerRow(),
                _buildShimmerRow(),
                _buildShimmerRow(),
                20.verticalSpace
              ],
            ),
          ),
        );
      }),
    );
  }

  // Build Shimmer row
  Widget _buildShimmerRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 14.sp,
            width: 0.3.sw,
            color: Colors.grey.shade200,
          ),
          Container(
            height: 14.sp,
            width: 0.2.sw,
            color: Colors.grey.shade200,
          ),
        ],
      ),
    );
  }
}
