class BookModel {
  final String id;
  final String title;
  final List<String> authors;
  final String? publishedDate;
  final String? thumbnail;
  final String? infoLink;

  BookModel({
    required this.id,
    required this.title,
    required this.authors,
    this.publishedDate,
    this.thumbnail,
    this.infoLink,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'];
    return BookModel(
      id: json["id"],
      title: volumeInfo["title"] ?? "No title",
      authors:
          (volumeInfo['authors'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          ['Unknown'],
      publishedDate: volumeInfo["publishedDate"],
      thumbnail: volumeInfo["imageLinks"]["thumbnail"],
      infoLink: volumeInfo["infoLink"],
    );
  }
}
