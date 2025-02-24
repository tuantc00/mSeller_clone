class News {
  final String title;
  final String image;
  final String content;
  final String url;

  News(
      {required this.title,
      required this.image,
      required this.content,
      required this.url});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      image: json['urlToImage'],
      content: json['content'],
      url: json["url"],
    );
  }
}
