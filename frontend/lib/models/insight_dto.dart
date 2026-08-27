class InsightDTO {
  final String type;
  final String message;

  InsightDTO({
    required this.type,
    required this.message,
  });

  factory InsightDTO.fromJson(Map<String, dynamic> json) {
    return InsightDTO(
      type: json['type'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'message': message,
    };
  }
}
