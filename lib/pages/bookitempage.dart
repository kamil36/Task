import 'package:flutter/material.dart';
import 'package:task_books/common/styles/colors.dart';
import 'package:task_books/common/styles/textstyles.dart';
import 'package:task_books/models/bookmodel.dart';

class BookItemPage extends StatefulWidget {
  final Work book;

  BookItemPage({required this.book});

  @override
  State<BookItemPage> createState() => _BookItemPageState();
}

class _BookItemPageState extends State<BookItemPage> {
  bool isRead = false;

  void toggleStatus() {
    setState(() {
      isRead = !isRead;
    });
  }

  String COVER_URL = 'https://covers.openlibrary.org/b/id/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              '$COVER_URL${widget.book.coverId}-M.jpg',
              fit: BoxFit.fill,
              height: 500,
              width: 400,
            ),
            SizedBox(height: 10),
            Text(
              widget.book.title ?? "",
              style: TextStyle(
                fontWeight: AppTextStyles.fw22.fontWeight,
                fontSize: AppTextStyles.fw22.fontSize,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 10),
            Text(
              (widget.book.authorNames ?? []).isNotEmpty
                  ? widget.book.authorNames?.first ?? ""
                  : "",
              style: TextStyle(
                fontWeight: AppTextStyles.fw22.fontWeight,
                fontSize: AppTextStyles.fw22.fontSize,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${widget.book.firstPublishYear}',
              style: TextStyle(
                fontWeight: AppTextStyles.fw22.fontWeight,
                fontSize: AppTextStyles.fw22.fontSize,
                color: AppColors.primary,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(350, 50),
                  backgroundColor:
                      isRead ? AppColors.tertiary : Colors.transparent,
                  foregroundColor:
                      isRead ? AppColors.seconday : Colors.transparent,
                  shadowColor: isRead ? AppColors.seconday : Colors.transparent,
                  side: BorderSide(
                    color: isRead ? AppColors.tertiary : Colors.transparent,
                  ),
                ),
                onPressed: toggleStatus,
                child: Text(
                  isRead ? 'Read' : 'Unread',
                  style: TextStyle(
                    color: isRead ? AppColors.primary : AppColors.seconday,
                    fontSize: AppTextStyles.fw22.fontSize,
                    fontWeight: AppTextStyles.fw22.fontWeight,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
