import 'package:flutter/material.dart';

class InformationListScreen extends StatelessWidget {
  const InformationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Library'),
          ),
        ],
      ),
    );
  }
}
