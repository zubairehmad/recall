import 'package:flutter/material.dart';

import '../../../core/models/information.dart';

class InformationListItem extends StatelessWidget {
  final VoidCallback onPressed;
  final Information information;

  const InformationListItem({
    super.key,
    required this.information,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.all(Radius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Row(
          children: [
            Icon(information.type.icon),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    information.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${information.type.displayName} • ${asString(information.createdAt)}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha(178),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  String asString(DateTime time) {
    final now = DateTime.now();
    final duration = now.difference(time);

    if (duration.inSeconds < 60) {
      return 'A moment ago';
    } else if (duration.inMinutes < 60) {
      return '${duration.inMinutes} min${duration.inMinutes == 1 ? '' : 's'} ago';
    } else if (duration.inHours < 24) {
      return '${duration.inHours} hour${duration.inHours == 1 ? '' : 's'} ago';
    } else if (duration.inHours < 48) {
      return 'Yesterday';
    } else if (duration.inDays < 7) {
      return '${duration.inDays} days ago';
    } else if (duration.inDays < 30) {
      final weeks = duration.inDays ~/ 7;
      return '$weeks week${weeks == 1 ? '' : 's'} ago';
    }

    final months = (now.year - time.year) * 12 + now.month - time.month;
    if (months < 12) {
      return '$months month${months == 1 ? '' : 's'} ago';
    }

    final years = months ~/ 12;
    return '$years year${years == 1 ? '' : 's'} ago';
  }
}
