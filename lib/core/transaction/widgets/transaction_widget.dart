import 'dart:io';

import 'package:bankly_task/app/extensions.dart';
import 'package:bankly_task/app/logic/credit_debit_filtering.dart';
import 'package:bankly_task/app/presentations/colors.dart';
import 'package:bankly_task/app/presentations/font_family.dart';
import 'package:bankly_task/app/presentations/texts.dart';
import 'package:bankly_task/core/transaction/model/transaction_model/transaction_model.dart';
import 'package:bankly_task/core/transaction/screens/transaction_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class TransactionWidget extends StatelessWidget {
  final TransactionModel transactionModel;
  TransactionWidget({super.key, required this.transactionModel});

  final formatCurrency =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TransactionDetailsScreen(transactionModel: transactionModel),
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 50.h,
        width: 300.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 25.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: debitKeywords.contains(transactionModel.trnDrCr)
                          ? const Color.fromRGBO(255, 232, 234, 1)
                          : const Color.fromRGBO(207, 231, 221, 1)),
                  child: Transform.scale(
                      scale: 0.35,
                      child: SvgPicture.asset(
                          debitKeywords.contains(transactionModel.trnDrCr)
                              ? "debit_icon".toSVG()
                              : "credit_icon".toSVG())),
                ),
                SizedBox(
                  width: 25.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NormalText(
                      text: transactionModel.trnDrCr,
                      textColor: XColors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    NormalText(
                      text: DateFormat('dd, MMMM yyyy, kk:mm a')
                          .format(transactionModel.trnDate!),
                      textColor: XColors.textColorLight,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    )
                  ],
                ),
              ],
            ),
            NormalText(
              text:
                  "${creditDebitIndicator()}${formatCurrency.format(double.parse(transactionModel.trnAmount!))}",
              textColor: debitKeywords.contains(transactionModel.trnDrCr)
                  ? XColors.red
                  : XColors.green,
              fontFamily: XFontFamily.sfui,
            )
          ],
        ),
      ),
    );
  }

  String creditDebitIndicator() {
    if (debitKeywords.contains(transactionModel.trnDrCr)) {
      return "-";
    } else {
      return "+";
    }
  }
}
