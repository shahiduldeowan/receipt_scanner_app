import 'package:flutter/material.dart';
import 'package:receipt_scanner_app/config/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openCamera(BuildContext context) async {
    Navigator.pushNamed(context, AppRoutes.cameraViewRoute);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const CameraView()),
    // );

    // if (result != null && result is ReceiptModel) {
    //   context.read<ReceiptBloc>().add(AddReceipt(result));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Receipt Scanner'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: const Center(
        child: Text(
          'No receipts yet.\nTap the + button to scan.',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openCamera(context),
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
