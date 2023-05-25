import 'package:bankly_task/app/presentations/colors.dart';
import 'package:bankly_task/app/presentations/error_snackbar.dart';
import 'package:bankly_task/app/presentations/texts.dart';
import 'package:bankly_task/core/transaction/bloc/transaction_bloc.dart';
import 'package:bankly_task/core/transaction/model/transaction_model/transaction_model.dart';
import 'package:bankly_task/core/transaction/widgets/transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllTransactions extends StatefulWidget {
  final String transactionType;
  const AllTransactions({super.key, required this.transactionType});

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state.filterStatus.notFound) {
          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
              header: "Transaction not found",
              message: state.filterError ?? ""));
        } else if (state.status.isError) {
          ScaffoldMessenger.of(context).showSnackBar(
              errorSnackBar(message: state.error ?? "Server error"));
        }
      },
      builder: (context, state) {
        if (state.status.isLoading) {
          return SizedBox(
            height: 100.h,
            width: 200.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: XColors.mainColor,
                ),
                SizedBox(
                  height: 15.h,
                ),
                if (state.status == TransactionStatus.slowloading)
                  NormalText(
                    text: "Sorry, this is taking a while...",
                    textColor: XColors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  )
              ],
            ),
          );
        } else if (state.status.isError) {
          return SizedBox(
            height: 100.h,
            width: 200.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NormalText(
                  text: "Server error, try again later",
                  textColor: XColors.red,
                  textAlign: TextAlign.center,
                  fontSize: 14,
                ),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                    onTap: () {
                      context.read<TransactionBloc>().add(GetTransaction());
                    },
                    child: const Icon(Icons.refresh))
              ],
            ),
          );
        } else if (state.status.isSuccess) {
          List<TransactionModel> data = state.transactions;

          if (widget.transactionType == "Debit") {
            data = data.where((element) => element.isDebit()).toList();
          } else if (widget.transactionType == "Credit") {
            data = data.where((element) => !element.isDebit()).toList();
          }

          if (data.isEmpty) {
            return SizedBox(
              height: 100.h,
              width: 200.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: XColors.mainColor,
                    size: 60,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  NormalText(
                    text: "No Transactions",
                    textColor: XColors.mainColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            );
          } else {
            return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  TransactionWidget(transactionModel: data[index]),
              itemCount: data.length,
              separatorBuilder: (context, index) => const Divider(),
            );
          }
        }
        return Container();
      },
    );
  }
}
