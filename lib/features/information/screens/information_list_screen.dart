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
    final infoProvider = context.watch<InformationProvider>();
    final infoList = infoProvider.informationList;

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
          SliverPadding(
            padding: padding,
            sliver: SearchAndFilterSection(
              disable: infoList.isEmpty,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 8),
          ),
          infoList.isEmpty
              ? SliverFillRemaining(
                  child: Padding(
                    padding: padding,
                    child: !infoProvider.isInitialized
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.library_books_outlined,
                                size: 64,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Your library is empty',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                child: Text(
                                  'Start building your personal collection of '
                                  'facts, tips, notes, and claims worth remembering.',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 20),
                              FilledButton.icon(
                                onPressed: () =>
                                    Navigator.of(context).pushNamed(
                                      InformationFormScreen.routeName,
                                    ),
                                icon: const Icon(Icons.add),
                                label: const Text('Add your first entry'),
                              ),
                            ],
                          ),
                  ),
                )
              : SliverPadding(
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
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withAlpha(100),
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
