import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface.withAlpha(160);

    return SearchBar(
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Icon(
          Icons.search,
          color: color,
        ),
      ),
      hintText: 'Search your knowledge...',
      hintStyle: WidgetStateProperty.all(
        TextStyle(color: color),
      ),
    );
  }
}
