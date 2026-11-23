import 'package:flutter/material.dart' show Icons, IconData;

enum InformationType {
  claim,
  fact,
  tip,
  note;

  String get displayName {
    switch (this) {
      case InformationType.claim:
        return 'Claim';
      case InformationType.fact:
        return 'Fact';
      case InformationType.tip:
        return 'Tip';
      case InformationType.note:
        return 'Note';
    }
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
  incorrect,
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
