part of 'receipt_cubit_cubit.dart';

sealed class ReceiptCubitState extends Equatable {
  const ReceiptCubitState({this.receipts});

  final List<ReceiptModel>? receipts;

  @override
  List<Object?> get props => [receipts];
}

final class ReceiptCubitInitial extends ReceiptCubitState {}

class ReceiptCubitLoaded extends ReceiptCubitState {
  const ReceiptCubitLoaded({required super.receipts});

  ReceiptCubitLoaded copyWith({required List<ReceiptModel>? receipts}) {
    return ReceiptCubitLoaded(receipts: receipts ?? this.receipts);
  }
}
