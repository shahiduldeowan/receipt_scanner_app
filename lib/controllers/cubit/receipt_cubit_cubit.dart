import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:receipt_scanner_app/models/receipt_model.dart';

part 'receipt_cubit_state.dart';

@injectable
class ReceiptCubit extends Cubit<ReceiptCubitState> {
  ReceiptCubit() : super(ReceiptCubitInitial()) {
    _loadReceipts();
  }

  final List<ReceiptModel> _receipts = [];

  Future<void> _loadReceipts() async {
    emit(ReceiptCubitLoaded(receipts: _receipts));
  }

  void addReceipt(ReceiptModel receipt) {
    _receipts.add(receipt);

    emit((state as ReceiptCubitLoaded).copyWith(receipts: _receipts));
  }
}
