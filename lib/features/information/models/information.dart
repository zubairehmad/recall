import 'package:flutter/material.dart';

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

  Color getBackgroundColor(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    switch (this) {
      case ClaimStatus.unreviewed:
        return isDark ? const Color(0xFF374151) : const Color(0xFFF3F4F6);
      case ClaimStatus.verified:
        return isDark ? const Color(0xFF14532D) : const Color(0xFFDCFCE7);
      case ClaimStatus.disputed:
        return isDark ? const Color(0xFF713F12) : const Color(0xFFFEF3C7);
      case ClaimStatus.incorrect:
        return isDark ? const Color(0xFF7F1D1D) : const Color(0xFFFEE2E2);
    }
  }

  Color getForegroundColor(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    switch (this) {
      case ClaimStatus.unreviewed:
        return isDark ? const Color(0xFFD1D5DB) : const Color(0xFF374151);
      case ClaimStatus.verified:
        return isDark ? const Color(0xFF86EFAC) : const Color(0xFF166534);
      case ClaimStatus.disputed:
        return isDark ? const Color(0xFFFDE68A) : const Color(0xFF92400E);
      case ClaimStatus.incorrect:
        return isDark ? const Color(0xFFFCA5A5) : const Color(0xFF991B1B);
    }
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

  /// Note that when changing type, providing `claimStatus` is not required since it will
  /// automatically make `claimStatus` field `null`.
  ///
  /// However if the `InformationType` is `InformationType.claim`, then providing `null`
  /// will reuse old `claimStatus` because `claimStatus` cannot be `null` when info type is
  /// `InformationType.claim`.
  Information copyWith({
    String? id,
    String? title,
    String? content,
    InformationType? type,
    ClaimStatus? claimStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    final newType = type ?? this.type;
    return Information(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      type: newType,
      claimStatus: newType == InformationType.claim
          ? claimStatus ?? this.claimStatus
          : null,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Information &&
            other.id == id &&
            other.title == title &&
            other.content == content &&
            other.type == type &&
            other.claimStatus == claimStatus &&
            other.createdAt == createdAt &&
            other.updatedAt == updatedAt);
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    content,
    type,
    claimStatus,
    createdAt,
    updatedAt,
  );
}
