import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_books/common/styles/colors.dart';
import 'package:task_books/common/styles/textstyles.dart';
import 'package:task_books/data/api/api.dart';
import 'package:task_books/models/books.dart';
import 'package:task_books/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  showSearch(context: context, delegate: MysearchDelegate());
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
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final book = BookListItem.books[index];

                    return Container(
                      // color: Colors.red,
                      height: 600,
                      child: Column(
                        children: [
                          book.coverId,
                          Text("${book.title}"),
                          Text("${book.author}"),
                          Text("${book.publishedYear}"),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.book),
                          )
                        ],
                      ),
                    );
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
