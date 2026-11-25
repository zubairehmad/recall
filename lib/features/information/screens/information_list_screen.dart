import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'information_form_screen.dart';
import '../providers/information_provider.dart';
import '../widgets/search_and_section.dart';
import '../widgets/information_list_item.dart';
import '../../../core/widgets/custom_sliver_app_bar.dart';

class InformationListScreen extends StatelessWidget {
  const InformationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final infoList = context.watch<InformationProvider>().informationList;

    const padding = EdgeInsets.symmetric(
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
                  onPressed: () => Navigator.of(context).pushNamed(
                    InformationFormScreen.routeName,
                  ),
                  icon: const Icon(Icons.add),
                ),
              ),
            ],
          ),
          const SliverPadding(
            padding: padding,
            sliver: SearchAndFilterSection(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 8),
          ),
          SliverPadding(
            padding: padding,
            sliver: SliverList.separated(
              itemBuilder: (_, i) => InformationListItem(
                information: infoList[i],
              ),
              separatorBuilder: (_, _) => Padding(
                padding: const EdgeInsetsGeometry.symmetric(
                  horizontal: 18,
                  vertical: 2,
                ),
                child: Divider(
                  radius: const BorderRadius.all(Radius.circular(28)),
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
                ),
              ),
              itemCount: infoList.length,
            ),
          ),
        ],
      ),
    );
  }
}
