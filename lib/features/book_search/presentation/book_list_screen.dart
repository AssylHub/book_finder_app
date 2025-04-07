import 'package:book_finder_app/features/book_search/data/book_repository.dart';
import 'package:book_finder_app/features/book_search/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  List<BookModel> books = [];
  final searchController = TextEditingController();

  Future<void> searchBooks() async {
    final query = searchController.text;
    if (query.isEmpty) return;

    final result = await BookApi.fetchBooks(query);
    setState(() => books = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Books Search')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search for books...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: searchBooks,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return ListTile(
                  leading:
                      book.thumbnail != null
                          ? Image.network(book.thumbnail!, width: 50)
                          : Icon(Icons.book),
                  title: Text(book.title),
                  subtitle: Text(book.authors.join(', ')),
                  onTap:
                      () => launch(
                        book.infoLink!,
                      ), // Используйте пакет url_launcher
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
