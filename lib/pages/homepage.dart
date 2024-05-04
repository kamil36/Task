import 'package:flutter/material.dart';
import 'package:task_books/common/styles/colors.dart';
import 'package:task_books/common/styles/textstyles.dart';
import 'package:task_books/models/books.dart';
import 'package:task_books/pages/bookitempage.dart';
import 'package:task_books/pages/searchpage.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Work {
  String? title;
  String? key;
  List<String>? authorKeys;
  List<String>? authorNames;
  int? firstPublishYear;
  String? lendingEditionS;
  List<String>? editionKey;
  int? coverId;
  String? coverEditionKey;

  Work(
      {this.title,
      this.key,
      this.authorKeys,
      this.authorNames,
      this.firstPublishYear,
      this.lendingEditionS,
      this.editionKey,
      this.coverId,
      this.coverEditionKey});

  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
      title: json['title'],
      authorNames: json['authorNames'],
      firstPublishYear: json['firstPublishYear'],
      coverId: json['coverId'],
    );
  }
}

class ApiCheck extends StatelessWidget {
  const ApiCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

Future<List<Work>> getData() async {
  final response = await http.get(Uri.parse(
      "https://openlibrary.org/people/mekBot/books/already-read.json"));
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    List<Work> works = [];
    for (Map<String, dynamic> index in data) {
      works.add(Work.fromJson(index));
    }
    return works;
  } else {
    throw Exception('Failed to load data');
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isRead = false;

  void toggleStatus() {
    setState(() {
      isRead = !isRead;
    });
  }

  List<Work> Api = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "BooksMart",
            style: TextStyle(
                fontWeight: AppTextStyles.fw10.fontWeight,
                fontSize: AppTextStyles.fw30.fontSize),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchPage();
                  }));
                },
                icon: Icon(
                  Icons.search,
                  color: AppColors.primary,
                  size: 30,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                height: 1000,
                child: FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final book = BookListItem.books[index];

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
                                            book: BookListItem.books[index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 550,
                                      child: Column(
                                        children: [
                                          Image.network(
                                            Api[index].coverId.toString(),
                                            fit: BoxFit.fill,
                                            height: 350,
                                            width: 350,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            Api[index].title.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 26,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              Api[index].authorNames.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Colors.black)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              Api[index]
                                                  .firstPublishYear
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Colors.black)),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: Size(350, 50),
                                              backgroundColor: isRead
                                                  ? Colors.greenAccent
                                                  : Colors.transparent,
                                              foregroundColor: isRead
                                                  ? Colors.white
                                                  : Colors.transparent,
                                              shadowColor: isRead
                                                  ? Colors.white
                                                  : Colors.transparent,
                                              side: BorderSide(
                                                  color: isRead
                                                      ? Colors.greenAccent
                                                      : Colors
                                                          .transparent), // Border color
                                            ),
                                            onPressed: () {
                                              toggleStatus();
                                            },
                                            child: Text(
                                              isRead ? "Read" : "Unread",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
