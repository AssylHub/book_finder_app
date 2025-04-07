import 'dart:convert';
import 'package:book_finder_app/features/book_search/models/book_model.dart';
import 'package:http/http.dart' as http;

class BookApi {
  static Future<List<BookModel>> fetchBooks(String query) async {
    final url = Uri.parse(
      'https://www.googleapis.com/books/v1/volumes?q=$query&maxResults=20',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['items'] as List<dynamic>? ?? [];
      return items.map((item) => BookModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
