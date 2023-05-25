part of 'transaction_bloc.dart';

class TransactionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTransaction extends TransactionEvent {}

class FilterTransaction extends TransactionEvent {
  FilterTransaction({required this.keyword, required this.specification});

  final String keyword;
  final String specification;

  @override
  List<Object?> get props => [keyword, specification];
}
