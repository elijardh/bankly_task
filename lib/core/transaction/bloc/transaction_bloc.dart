import 'dart:async';
import 'package:bankly_task/core/transaction/model/transaction_model/transaction_model.dart';
import 'package:bankly_task/core/transaction/services/transaction_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'transaction_events.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(const TransactionState()) {
    on<GetTransaction>(getTransactionEventToState);
    on<FilterTransaction>(filterTransactionEventToState);
  }

  TransactionServices services = TransactionServices();

  List<TransactionModel> allTransactions = [];

  Future<void> getTransactionEventToState(
      TransactionEvent event, Emitter<TransactionState> emit) async {
    emit(state.copyWith(status: TransactionStatus.loading));

    try {
      const oneSec = Duration(seconds: 1);
      int start = 5;

      Timer.periodic(
        oneSec,
        (Timer timer) {
          if (start == 0) {
            timer.cancel();

            if (state.status.isLoading) {
              emit(state.copyWith(status: TransactionStatus.slowloading));
            }
          } else {
            start--;
          }
        },
      );

      //await Future.delayed(const Duration(seconds: 120));
      final transactions = await services.getTransactions();

      allTransactions.clear();
      allTransactions.addAll(transactions);

      emit(state.copyWith(
          status: TransactionStatus.success, transactions: transactions));
    } catch (e) {
      emit(
          state.copyWith(status: TransactionStatus.error, error: e.toString()));
    }
  }

  void filterTransactionEventToState(
      FilterTransaction event, Emitter<TransactionState> emit) {
    //Check if the transaction was loaded from the backend
    if (state.status.isError) {
      emit(state.copyWith(
          filterStatus: FilterStatus.notfound,
          filterError: "Transactions failed to load, try again later"));
    } else {
      List<TransactionModel> filteredTransactionList = [];

      switch (event.specification) {
        case "Description":
          filteredTransactionList = allTransactions
              .where((element) => element.trnDrCr!
                  .toLowerCase()
                  .startsWith(event.keyword.toLowerCase()))
              .toList();
          break;

        case "Amount":
          filteredTransactionList = allTransactions
              .where((element) => element.trnAmount!
                  .toLowerCase()
                  .startsWith(event.keyword.toLowerCase()))
              .toList();
          break;
        case "Account Number":
          filteredTransactionList = allTransactions
              .where((element) => element.accountNumber!
                  .toLowerCase()
                  .startsWith(event.keyword.toLowerCase()))
              .toList();
          break;
        case "Account Name":
          filteredTransactionList = allTransactions
              .where((element) => element.accountName!
                  .toLowerCase()
                  .startsWith(event.keyword.toLowerCase()))
              .toList();
          break;
        case "Bank Name":
          filteredTransactionList = allTransactions
              .where((element) => element.bankName!
                  .toLowerCase()
                  .startsWith(event.keyword.toLowerCase()))
              .toList();
          break;

        default:
          filteredTransactionList = [];
      }

      if (filteredTransactionList.isEmpty) {
        emit(state.copyWith(
            filterStatus: FilterStatus.notfound,
            filterError: "Try another keyword or filter",
            transactions: filteredTransactionList));
      } else {
        emit(state.copyWith(
            filterStatus: FilterStatus.found,
            transactions: filteredTransactionList));
      }
    }
  }
}
