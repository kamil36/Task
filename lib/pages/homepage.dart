import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_books/common/styles/colors.dart';
import 'package:task_books/common/styles/textstyles.dart';
import 'package:task_books/models/bookmodel.dart';
import 'package:task_books/pages/bookitempage.dart';
import 'package:task_books/pages/searchpage.dart';

const String API_URL =
    'https://openlibrary.org/people/mekBot/books/already-read.json';
const String COVER_URL = 'https://covers.openlibrary.org/b/id/';

Future<List<Work?>> getData() async {
  final response = await http.get(Uri.parse(API_URL));
  if (response.statusCode == 200) {
    BookData bookData = BookData.fromRawJson(response.body);
    return (bookData.readingLogEntries ?? []).map((e) => e.work).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isRead = false;
  int? selectedIndex;

  void toggleStatus(int index) {
    setState(() {
      isRead = !isRead;
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Work?> books = snapshot.data ?? [];

          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                title: Text(
                  "Books Mart",
                  style: TextStyle(
                      fontWeight: AppTextStyles.fw30.fontWeight,
                      fontSize: AppTextStyles.fw30.fontSize),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SearchPage(
                            works: books,
                          );
                        }));
                      },
                      icon: Icon(
                        Icons.search,
                        color: AppColors.primary,
                        size: 30,
                      ))
                ],
              ),
              body: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: books.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      final isSelected = selectedIndex == index;
                      final isread = isRead;
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookItemPage(
                                      book: book ?? Work(),
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.network(
                                    '$COVER_URL${book?.coverId}-M.jpg',
                                    fit: BoxFit.fill,
                                    height: 350,
                                    width: 350,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    book?.title ?? '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppTextStyles.fw22.fontSize,
                                        color: AppColors.primary),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text((book?.authorNames ?? []).join(","),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: AppTextStyles.fw22.fontSize,
                                          color: AppColors.primary)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(book?.firstPublishYear.toString() ?? "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: AppTextStyles.fw22.fontSize,
                                          color: AppColors.primary)),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(350, 50),
                                      backgroundColor: isSelected && isread
                                          ? AppColors.tertiary
                                          : Colors.transparent,
                                      foregroundColor: isSelected && isread
                                          ? AppColors.seconday
                                          : Colors.transparent,
                                      shadowColor: isSelected && isread
                                          ? AppColors.seconday
                                          : Colors.transparent,
                                      side: BorderSide(
                                          color: isSelected && isread
                                              ? AppColors.tertiary
                                              : Colors
                                                  .transparent), // Border color
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        toggleStatus(index);
                                      });
                                    },
                                    child: Text(
                                      isSelected && isread ? "Read" : "Unread",
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: AppTextStyles.fw22.fontSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ))
                ],
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return Text(
            "Error:${snapshot.error}",
            style: TextStyle(
              fontSize: AppTextStyles.fw22.fontSize,
              fontWeight: AppTextStyles.fw22.fontWeight,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
