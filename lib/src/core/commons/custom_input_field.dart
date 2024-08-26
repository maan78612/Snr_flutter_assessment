
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_inkwell.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_text_controller.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';

class CustomInputField extends StatefulWidget {
  final String? hint;
  final String? title;
  final Widget? prefixWidget;
  final CustomTextController controller;
  final TextInputType? keyboardType;
  final bool? obscure;
  final bool expand;
  final bool? enable;
  final bool? textAlignCenter;
  final int maxLines;

  final Function(String)? onChange;
  final Function()? onEditingComplete;
  final bool? verticalAlign;
  final bool? isDecorationEnable;
  final bool autoFocus;
  final Color? focusColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final Function()? onTap;
  final double borderRadius;
  final Widget? suffixWidget;
  final Function(String)? onSubmit;
  final int? maxLength;
  final EdgeInsets? contentPadding;
  final double borderWidth;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final bool isFilled;

  const CustomInputField(
      {super.key,
      this.title,
      this.isDecorationEnable = true,
      this.verticalAlign = false,
      this.expand = true,
      this.prefixWidget,
      this.hint,
      required this.controller,
      this.keyboardType = TextInputType.visiblePassword,
      this.obscure = false,
      this.autoFocus = false,
      this.enable = true,
      this.textAlignCenter = false,
      this.maxLines=1,
      this.focusColor,
      this.onChange,
      this.inputFormatters,
      this.textInputAction = TextInputAction.done,
      this.onTap,
      this.borderRadius = 10,
      this.suffixWidget,
      this.maxLength,
      this.contentPadding,
      this.onSubmit,
      this.borderWidth = 1,
      this.textStyle,
      this.isFilled = true,
      this.hintStyle,
      this.onEditingComplete});

  @override
  State<CustomInputField> createState() => _CustomInputField();
}

class _CustomInputField extends State<CustomInputField> {
  late bool obscure;

  @override
  void initState() {
    super.initState();
    obscure = widget.obscure!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Text(widget.title!,
              style: PoppinsStyles.medium
                  .copyWith(fontSize: 14.sp, color: AppColors.lightTextColor)),
          11.verticalSpace,
        ],
        TextFormField(
          autofocus: widget.autoFocus,
          focusNode: widget.controller.focusNode,
          onFieldSubmitted: widget.onSubmit,
          maxLength: widget.maxLength,
          cursorColor: AppColors.primaryColor,
          maxLines: widget.maxLines,

          minLines: 1,
          cursorHeight: 16.sp,
          onChanged: widget.onChange,
          onEditingComplete: widget.onEditingComplete,
          enabled: widget.enable,
          controller: widget.controller.controller,
          textAlign: widget.textAlignCenter == true
              ? TextAlign.center
              : TextAlign.start,
          onTap: widget.onTap,
          textAlignVertical: TextAlignVertical.center,
          style: widget.textStyle ??
              PoppinsStyles.regular.copyWith(fontSize: 15.sp),
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          obscureText: obscure,
          obscuringCharacter: "•",
          textInputAction: widget.textInputAction,
          decoration: decorationComponent(),
        ),
        Padding(
          padding: EdgeInsets.all(6.sp),
          child: Text(
            widget.controller.error ?? "",
            style: PoppinsStyles.regular
                .copyWith(fontSize: 10.sp, color: AppColors.redColor),
          ),
        )
      ],
    );
  }

  InputDecoration decorationComponent() {
    return InputDecoration(
          focusColor: widget.focusColor ?? AppColors.primaryColor,
          hintText: widget.hint,
          counterText: "",

          hintStyle: widget.hintStyle ??
              PoppinsStyles.regular
                  .copyWith(fontSize: 15.sp, color: AppColors.hintColor),
          contentPadding: widget.contentPadding ??
              EdgeInsets.symmetric(
                  horizontal: 13.sp, vertical: ((50 - 16) / 2).sp),
          filled: widget.isFilled,
          fillColor: AppColors.whiteColor,
          border: widget.isDecorationEnable ?? false
              ? inputBorder
              : InputBorder.none,
          enabledBorder: widget.isDecorationEnable ?? false
              ? inputBorder
              : InputBorder.none,
          errorBorder: widget.isDecorationEnable ?? false
              ? inputBorder
              : InputBorder.none,
          focusedBorder: inputBorder.copyWith(
              borderSide: BorderSide(
            color: widget.controller.error == null
                ? AppColors.focusedBorderColor
                : AppColors.redColor,
            width: widget.borderWidth,
          )),
          disabledBorder: widget.isDecorationEnable ?? false
              ? inputBorder
              : InputBorder.none,
          prefixIconConstraints: BoxConstraints(maxHeight: 20.sp),
          suffixIconConstraints: BoxConstraints(maxHeight: 20.sp),
          prefixIcon: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 8.sp),
            child: widget.prefixWidget,
          ),
          suffixIcon: (widget.suffixWidget != null && widget.obscure == false)
              ? Padding(
                  padding: EdgeInsetsDirectional.only(end: 10.sp),
                  child: widget.suffixWidget,
                )
              : widget.obscure == true
                  ? CommonInkWell(
                      onTap: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(end: 10.sp),
                        child: Icon(
                          size: 20,
                          obscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.blackColor.withOpacity(0.5),
                        ),
                      ),
                    )
                  : null,
        );
  }

  InputBorder get inputBorder {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius.r),
      borderSide: BorderSide(
        color: AppColors.borderColor,
        width: widget.borderWidth,
      ),
    );
  }
}
