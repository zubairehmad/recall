import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final String hintText;
  final bool disable;
  final List<Widget>? trailing;

  const CustomSearchBar({
    super.key,
    required this.hintText,
    this.trailing,
    this.disable = false,
  });

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
      enabled: !widget.disable,
      trailing: widget.trailing,
      hintText: widget.hintText,
      hintStyle: WidgetStateProperty.all(
        TextStyle(color: color),
      ),
    );
  }
}
