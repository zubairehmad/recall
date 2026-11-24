import 'package:flutter/material.dart' show Icons, IconData;

enum InformationType {
  claim,
  fact,
  tip,
  note;

  String get displayName {
    return name[0].toUpperCase() + name.substring(1);
  }

  IconData get icon {
    switch (this) {
      case InformationType.claim:
        return Icons.campaign_outlined;
      case InformationType.fact:
        return Icons.fact_check_outlined;
      case InformationType.tip:
        return Icons.lightbulb_outline;
      case InformationType.note:
        return Icons.sticky_note_2_outlined;
    }
  }
}

enum ClaimStatus {
  unreviewed,
  verified,
  disputed,
  incorrect;

  String get displayName {
    return name[0].toUpperCase() + name.substring(1);
  }

  IconData get icon {
    switch (this) {
      case ClaimStatus.unreviewed:
        return Icons.hourglass_empty;
      case ClaimStatus.verified:
        return Icons.verified_outlined;
      case ClaimStatus.disputed:
        return Icons.gavel;
      case ClaimStatus.incorrect:
        return Icons.cancel_outlined;
    }
  }
}

class Information {
  final String id;
  final String title;
  final String content;
  final InformationType type;
  final ClaimStatus? claimStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Information({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    this.claimStatus,
  }) : assert(
         type == InformationType.claim
             ? claimStatus != null
             : claimStatus == null,
       );

  bool get isClaim => type == InformationType.claim;
}
