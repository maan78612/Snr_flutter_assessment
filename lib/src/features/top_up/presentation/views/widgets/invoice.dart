import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_button.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_inkwell.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_navigation.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';

class Invoice extends StatelessWidget {
  final double amount;
  final double serviceCharge;

  const Invoice({required this.amount, required this.serviceCharge, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.9.sw, // Adjust width to make it wider
      padding: EdgeInsets.all(20.sp), // Add padding for better spacing
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Invoice Details',
                  style: PoppinsStyles.medium.copyWith(
                    fontSize: 24.sp,
                  )),
              CommonInkWell(
                  onTap: () => CustomNavigation().pop(),
                  child: Icon(Icons.close,
                      color: AppColors.redColor, size: 24.sp)),
            ],
          ),
          20.verticalSpace,
          _buildInvoiceRow('Product', "Mobile Recharge"),
          _buildInvoiceRow('Price', '${amount.toStringAsFixed(2)} AED'),
          20.verticalSpace,
          _buildInvoiceRow(
            'Sub total',
            isSemiBold: true,
            '${amount.toStringAsFixed(2)} AED',
            isBold: true,
          ),

          const Divider(),

          _buildInvoiceRow(
              'Service Charge', '${serviceCharge.toStringAsFixed(2)} AED'),
          5.verticalSpace,
          infoPointsWidget(
              "Service charges will be deducted from your available balance"),
          20.verticalSpace,
          const Divider(),
          _buildInvoiceRow(
            'Total',
            '${(amount + serviceCharge).toStringAsFixed(2)} AED',
            isBold: true,
          ),
          20.verticalSpace, // Space between total and button
          CustomButton(
              bgColor: AppColors.primaryColor,
              title: "Proceed to Payment",
              onPressed: () {
                CustomNavigation().pop(true);
              }),
        ],
      ),
    );
  }

  Widget _buildInvoiceRow(String label, String value,
      {bool isBold = false, bool isSemiBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: PoppinsStyles.regular.copyWith(
              fontSize: isSemiBold ? 14.sp : 16.sp,
              fontWeight: isBold
                  ? FontWeight.bold
                  : isSemiBold
                      ? FontWeight.w500
                      : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: PoppinsStyles.regular.copyWith(
              fontSize: isSemiBold ? 14.sp : 16.sp,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget infoPointsWidget(String info) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "*",
          style: PoppinsStyles.regular.copyWith(
            fontSize: 22.sp,
            color: Colors.red,
          ),
        ),
        5.horizontalSpace,
        Expanded(
          child: Text(
            info,
            style: PoppinsStyles.regular.copyWith(
              fontSize: 10.sp,
            ),
          ),
        ),
      ],
    );
  }
}
