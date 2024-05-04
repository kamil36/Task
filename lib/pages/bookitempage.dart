import 'package:flutter/material.dart';
import 'package:task_books/models/books.dart';

class BookItemPage extends StatefulWidget {
  final BookListItem book;

  BookItemPage({required this.book});

  @override
  State<BookItemPage> createState() => _BookItemPageState();
}

class _BookItemPageState extends State<BookItemPage> {
  bool isRead = false; // Track the read status of the book

  void toggleStatus() {
    setState(() {
      isRead = !isRead; // Toggle the read status
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              widget.book.coverId,
              fit: BoxFit.fill,
              height: 500,
              width: 400,
            ),
            SizedBox(height: 10),
            Text(
              widget.book.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.book.author,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${widget.book.publishedYear}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(350, 50),
                  backgroundColor:
                      isRead ? Colors.greenAccent : Colors.transparent,
                  foregroundColor: isRead ? Colors.white : Colors.transparent,
                  side: BorderSide(
                    color: isRead ? Colors.greenAccent : Colors.transparent,
                  ),
                ),
                onPressed: toggleStatus,
                child: Text(
                  isRead ? 'Read' : 'Unread',
                  style: TextStyle(
                    color: isRead ? Colors.black : Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
