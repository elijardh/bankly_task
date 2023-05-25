import 'package:bankly_task/app/extensions.dart';
import 'package:bankly_task/app/presentations/colors.dart';
import 'package:bankly_task/app/presentations/custom_indicator.dart';
import 'package:bankly_task/app/presentations/font_family.dart';
import 'package:bankly_task/app/presentations/texts.dart';
import 'package:bankly_task/core/transaction/widgets/transaction.dart';
import 'package:bankly_task/core/transaction/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen>
    with TickerProviderStateMixin {
  TabController? controller;

  @override
  void dispose() {
    super.dispose();

    controller!.dispose();
  }

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: "#FBFBFF".toColor(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(143.h),
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 30.h,
                        width: 30.w,
                        padding: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(233, 233, 255, 1)),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: XColors.mainColor,
                            size: 15,
                          ),
                        )),
                    const NormalText(
                      text: "Transactions",
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                    Container(
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),

              // TextField Here
              const SearchWidget(),

              SizedBox(
                height: 20.h,
              ),

              TabBar(
                  controller: controller,
                  indicator: const DotIndicator(),
                  tabs: [
                    NormalText(
                      text: "All",
                      textColor: XColors.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    NormalText(
                      text: "Credit",
                      textColor: XColors.green,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    NormalText(
                      text: "Debit",
                      textColor: XColors.red,
                      fontSize: 14,
                      fontFamily: XFontFamily.roboto,
                      fontWeight: FontWeight.w600,
                    )
                  ]),
              SizedBox(
                height: 15.h,
              ),
              const Divider(
                height: 0.5,
                color: Color.fromRGBO(230, 230, 230, 1),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(controller: controller, children: const [
        AllTransactions(transactionType: ""),
        AllTransactions(transactionType: "Credit"),
        AllTransactions(transactionType: "Debit"),
      ]),
    );
  }
}
