import 'dart:io';

import 'package:bankly_task/app/extensions.dart';
import 'package:bankly_task/app/logic/credit_debit_filtering.dart';
import 'package:bankly_task/app/presentations/colors.dart';
import 'package:bankly_task/app/presentations/texts.dart';
import 'package:bankly_task/core/transaction/model/transaction_model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final TransactionModel transactionModel;
  TransactionDetailsScreen({super.key, required this.transactionModel});

  final formatCurrency =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: "#FBFBFF".toColor(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Transform.scale(
            scale: 0.6,
            child: Container(
              height: 20.h,
              width: 20.w,
              padding: const EdgeInsets.only(left: 5),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(233, 233, 255, 1)),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: XColors.mainColor,
                  size: 25,
                ),
              ),
            ),
          ),
        ),
        title: const NormalText(
          text: "Transactions",
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: XColors.secondaryColor),
              child: Center(
                child: Image.asset(
                  "transaction_logo".toPNG(),
                  scale: 3.0,
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            NormalText(
              text: formatCurrency
                  .format(double.parse(transactionModel.trnAmount!)),
              textColor: XColors.textColor,
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
            SizedBox(
              height: 50.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: NormalText(
                text: "Details:",
                textColor: XColors.textColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NormalText(
                  text: "Date and Time",
                  textColor: XColors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                NormalText(
                  text: DateFormat('dd/MM/yyyy kk:mm:ss a')
                      .format(transactionModel.trnDate!),
                  textColor: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: Colors.black,
              thickness: 0.2,
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NormalText(
                  text: "Reference",
                  textColor: XColors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                Row(
                  children: [
                    NormalText(
                      text: transactionModel.trnPaymentReference,
                      textColor: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    SvgPicture.asset("copy_icon".toSVG())
                  ],
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: Colors.black,
              thickness: 0.2,
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NormalText(
                  text: "Type",
                  textColor: XColors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                NormalText(
                  text: creditDebitIndicator(),
                  textColor: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: Colors.black,
              thickness: 0.2,
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NormalText(
                  text: "Naration",
                  textColor: XColors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                SizedBox(
                  width: 220.w,
                  child: NormalText(
                    text: transactionModel.trnNarration,
                    textColor: Colors.black,
                    fontSize: 14,
                    maxLines: 5,
                    textAlign: TextAlign.end,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: Colors.black,
              thickness: 0.2,
            ),
            const Spacer(),
            Container(
              height: 40.h,
              width: 320.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: XColors.mainColor),
              child: const Center(
                child: NormalText(
                  text: "DOWNLOAD RECEIPT",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            NormalText(
              text: "Share With Bankly Assistant",
              textColor: XColors.mainColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  String creditDebitIndicator() {
    if (debitKeywords.contains(transactionModel.trnDrCr)) {
      return "Debit";
    } else {
      return "Credit";
    }
  }
}
