import 'package:flutter/material.dart';

import '../../../core/widgets/custom_sliver_app_bar.dart';
import '../widgets/search_and_section.dart';

class InformationListScreen extends StatelessWidget {
  const InformationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const EdgeInsetsGeometry padding = EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 10,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            title: 'Library',
            actions: [
              Padding(
                padding: const EdgeInsetsGeometry.only(right: 8),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                ),
              ),
            ],
          ),
          const SliverPadding(
            padding: padding,
            sliver: SearchAndFilterSection(),
          ),
        ],
      ),
    );
  }
}
