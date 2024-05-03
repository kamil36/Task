// TextField(
//                 keyboardType: TextInputType.name,
//                 keyboardAppearance: Brightness.dark,
//                 controller: _searchcontroller,
//                 decoration: InputDecoration(
//                   hintText: 'Search Books...',
//                   prefixIcon: Icon(Icons.search),
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     _searchText = value;
//                   });
//                 },
//               ),

import 'package:flutter/material.dart';
import 'package:task_books/common/styles/textstyles.dart';
import 'package:task_books/common/widgets/booklistitem.dart';

class MysearchDelegate extends SearchDelegate {
  List<BookListItem> SearchBooks = [];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: Icon(Icons.arrow_back),
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = "";
        }
      },
      icon: Icon(Icons.clear),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Center(
      child: Text(
        query,
        style: TextStyle(
          fontSize: AppTextStyles.fw30.fontSize,
          fontWeight: AppTextStyles.fw10.fontWeight,
        ),
      ),
    );
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<BookListItem> Books = SearchBooks.where((book) {
      final result = book.title.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return ListView.builder(
        itemCount: Books.length,
        itemBuilder: (context, Index) {
          final book = Books[Index];
          return ListTile(
            title: Text(book.title),
            onTap: () {
              query = book.title;
            },
          );
        });
  }
}
