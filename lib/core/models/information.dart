enum InformationType {
  claim,
  fact,
  tip,
  note,
}

enum InformationStatus {
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
  final InformationStatus? status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Information({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    this.status,
  }) : assert(
         (type == InformationType.claim || type == InformationType.fact)
             ? status != null
             : status == null,
       );
}
