enum InformationType {
  claim,
  fact,
  tip,
  note,
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
