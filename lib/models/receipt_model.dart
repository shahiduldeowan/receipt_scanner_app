import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class ReceiptModel extends Equatable {
  final String id;
  final String filePath;
  final DateTime scannedAt;

  ReceiptModel({required this.filePath, required this.scannedAt})
    : id = const Uuid().v4();

  @override
  List<Object?> get props => [id, filePath, scannedAt];
}
