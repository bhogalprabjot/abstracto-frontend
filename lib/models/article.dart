import 'dart:convert';

class Article {
  final String article;
  Article({
    this.article,
  });

  // Article copyWith({
  //   String? article,
  // }) {
  //   return Article(
  //     article: article ?? this.article,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'article': article,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      article: map['article'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Article.fromJson(String source) =>
      Article.fromMap(json.decode(source));

  @override
  String toString() => 'Article(article: $article)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Article && other.article == article;
  }

  @override
  int get hashCode => article.hashCode;
}
