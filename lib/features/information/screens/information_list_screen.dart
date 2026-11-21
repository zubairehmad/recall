import 'package:flutter/material.dart';

class InformationListScreen extends StatelessWidget {
  const InformationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information List Screen'),
      ),
      body: const Center(
        child: Text('Information list screen!'),
      ),
    );
  }
}
