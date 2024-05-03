import 'package:flutter/material.dart';

class BookListItem extends StatelessWidget {
  const BookListItem({
    super.key,
    required this.coverId,
    required this.title,
    required this.author,
    required this.publishedYear,
    required this.read,
  });

  final String coverId;
  final String title;
  final String author;
  final int publishedYear;
  final bool read;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: Column(
        children: [
          Card(
            child: Image.network(
              'https://covers.openlibrary.org/b/id/$coverId-M.jpg',
            ),
          ),
          Row(
            children: [
              Text(coverId),
              Text(title),
            ],
          ),
          Text(author),
          Text('$author - $publishedYear'),
          IconButton(
            onPressed: () {},
            icon: Icon(
              read ? Icons.check : Icons.check_box_outline_blank,
              color: read ? Colors.green : null,
            ),
          )
        ],
      ),
    );
  }
}
