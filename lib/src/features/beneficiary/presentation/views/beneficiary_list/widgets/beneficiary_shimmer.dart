import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class BeneficiaryShimmer extends StatelessWidget {
  const BeneficiaryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(3, (index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: (0.38.sw) - 10.sp,
              padding:
                  EdgeInsets.symmetric(vertical: 16.sp, horizontal: 8.sp),
              margin: EdgeInsets.only(right: 10.sp, bottom: 20.sp),
              decoration: BoxDecoration(
                color: Colors.grey[100]?.withOpacity(0.2),
                // Light grey to represent loading
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 14.h,
                    width: double.infinity,
                    color: Colors.white, // Placeholder for name text
                  ),
                  20.verticalSpace,
                  Container(
                    height: 12.h,
                    width: 0.3.sw,
                    color: Colors.grey[300], // Placeholder for number text
                  ),
                  20.verticalSpace,
                  Container(
                    height: 34.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.r),
                      ),
                      color: Colors.grey[300],
                    ),
                    width: double.infinity,
                    // Placeholder for button
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
