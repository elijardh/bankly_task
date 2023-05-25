part of 'transaction_bloc.dart';

enum TransactionStatus { initial, success, error, loading, slowloading }

enum FilterStatus { initial, found, notfound }

extension FilterStatusX on FilterStatus {
  bool get initial => this == FilterStatus.initial;
  bool get found => this == FilterStatus.found;
  bool get notFound => this == FilterStatus.notfound;
}

extension TransactionStatusX on TransactionStatus {
  bool get isInitial => this == TransactionStatus.initial;
  bool get isSuccess => this == TransactionStatus.success;
  bool get isError => this == TransactionStatus.error;
  bool get isLoading =>
      this == TransactionStatus.loading ||
      this == TransactionStatus.slowloading;
}

class TransactionState extends Equatable {
  const TransactionState({
    this.status = TransactionStatus.initial,
    this.error,
    this.filterError,
    this.filterStatus = FilterStatus.initial,
    List<TransactionModel>? transactions,
  }) : transactions = transactions ?? const [];

  final List<TransactionModel> transactions;
  final TransactionStatus status;
  final FilterStatus filterStatus;
  final String? error;
  final String? filterError;

  @override
  List<Object> get props => [status, transactions];

  TransactionState copyWith(
      {List<TransactionModel>? transactions,
      TransactionStatus? status,
      String? error,
      String? filterError,
      FilterStatus? filterStatus}) {
    return TransactionState(
        status: status ?? this.status,
        transactions: transactions ?? this.transactions,
        filterError: filterError ?? this.filterError,
        error: error ?? "",
        filterStatus: filterStatus ?? this.filterStatus);
  }
}
