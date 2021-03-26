import 'dart:convert';

class Summary {
  final String summary;
  Summary({
    this.summary,
  });

  // Summary copyWith({
  //   String ? summary,
  // }) {
  //   return Summary(
  //     summary: summary ?? this.summary,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'summary': summary,
    };
  }

  factory Summary.fromMap(Map<String, dynamic> map) {
    return Summary(
      summary: map['summary'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Summary.fromJson(String source) =>
      Summary.fromMap(json.decode(source));

  @override
  String toString() => 'Summary(summary: $summary)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Summary && other.summary == summary;
  }

  @override
  int get hashCode => summary.hashCode;
}
