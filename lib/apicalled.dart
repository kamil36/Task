import "dart:convert";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:http/http.dart " as http;
import "package:task_books/apimodel.dart";

class ApiTest {
  final int id;
  final String title;
  final String url;
  final String? thumbnailUrl;
  int? albumId;

  ApiTest({
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
    required this.albumId,
  });

  factory ApiTest.fromJson(Map<String, dynamic> json) {
    return ApiTest(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
      albumId: json['albumId'],
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<ApiTest> apiTest = [];

  @override
  Widget build(BuildContext context) {
    int index;
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: apiTest.length,
            itemBuilder: (context, index) {
              return Container(
                // color: Colors.red,
                height: 600,
                child: Column(
                  children: [
                    Image.network(apiTest[index].url),
                    Text(apiTest[index].albumId.toString()),
                  ],
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<List<ApiTest>> getData() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        apiTest.add(ApiTest.fromJson(index));
      }
      return apiTest;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
