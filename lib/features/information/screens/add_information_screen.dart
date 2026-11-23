import 'package:flutter/material.dart';

import '../../../core/models/information.dart';

class AddInformationScreen extends StatefulWidget {
  static const routeName = '/add-info-screen';

  final InformationType? initialType;

  const AddInformationScreen({
    super.key,
    this.initialType,
  });

  @override
  State<AddInformationScreen> createState() => _AddInformationScreenState();
}

class _AddInformationScreenState extends State<AddInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
