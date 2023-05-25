import 'package:bankly_task/app/presentations/colors.dart';
import 'package:bankly_task/app/presentations/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SnackBar errorSnackBar({required String message, String? header}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
      padding: const EdgeInsets.all(6),
      height: 50.h,
      decoration: BoxDecoration(
        color: XColors.mainColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline,
            size: 40,
            color: Colors.white,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NormalText(
                  text: header ?? "Oh Snap",
                  textColor: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                NormalText(
                    text: message,
                    textColor: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    maxLines: 2,
                    textAlign: TextAlign.start),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
