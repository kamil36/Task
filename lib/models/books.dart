import 'package:flutter/material.dart';

class BookListItem {
  String author, title;
  bool read;
  int publishedYear;
  dynamic coverId;
  BookListItem({
    required this.coverId,
    required this.title,
    required this.author,
    required this.publishedYear,
    this.read = false,
  });

  static List<BookListItem> books = [
    BookListItem(
        coverId: "assets/img/b1.jpg",
        author: "Dhoni",
        title: "CSK",
        publishedYear: 2000,
        read: false),
    BookListItem(
        coverId: "assets/img/b2.jpg",
        author: "Rohit",
        title: "MI",
        publishedYear: 2002,
        read: false),
    BookListItem(
        coverId: "assets/img/b3.jpg",
        author: "Virat",
        title: "RCB",
        publishedYear: 2004,
        read: false),
    BookListItem(
        coverId: "assets/img/b4.jpg",
        author: "Sanju",
        title: "RR",
        publishedYear: 2006,
        read: false),
    BookListItem(
        coverId: "assets/img/b5.jpg",
        author: "Rahul",
        title: "LSG",
        publishedYear: 2008,
        read: false),
    BookListItem(
        coverId: "assets/img/b6.jpg",
        author: "Moris",
        title: "SRH",
        publishedYear: 2010,
        read: false),
  ];
}
