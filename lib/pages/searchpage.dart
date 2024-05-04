import 'package:flutter/material.dart';
import 'package:task_books/models/books.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<BookListItem> books = [
    BookListItem(
      coverId: "assets/img/b1.jpg",
      author: "Dhoni",
      title: "CSK",
      publishedYear: 2000,
      read: false,
    ),
    BookListItem(
      coverId: "assets/img/b2.jpg",
      author: "Rohit",
      title: "MI",
      publishedYear: 2002,
      read: false,
    ),
    BookListItem(
      coverId: "assets/img/b3.jpg",
      author: "Virat",
      title: "RCB",
      publishedYear: 2004,
      read: false,
    ),
    BookListItem(
      coverId: "assets/img/b4.jpg",
      author: "Sanju",
      title: "RR",
      publishedYear: 2006,
      read: false,
    ),
    BookListItem(
      coverId: "assets/img/b5.jpg",
      author: "Rahul",
      title: "LSG",
      publishedYear: 2008,
      read: false,
    ),
    BookListItem(
      coverId: "assets/img/b6.jpg",
      author: "Moris",
      title: "SRH",
      publishedYear: 2010,
      read: false,
    ),
  ];
  // This list holds the data for the list view
  List<BookListItem> _foundUsers = [];
  @override
  initState() {
    _foundUsers = books;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<BookListItem> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = books;
    } else {
      results = books
          .where((books) =>
              books.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      _foundUsers = results;
    });
  }

  bool isRead = false;

  void toggleStatus() {
    setState(() {
      isRead = !isRead;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) => _runFilter(value),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: _foundUsers.isNotEmpty
                    ? ListView.builder(
                        itemCount: _foundUsers.length,
                        itemBuilder: (context, index) => Card(
                          key: ValueKey(_foundUsers[index].title),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              height: 550,
                              child: Column(
                                children: [
                                  Image.asset(
                                    _foundUsers[index].coverId,
                                    fit: BoxFit.fill,
                                    height: 350,
                                    width: 350,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    _foundUsers[index].title.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(_foundUsers[index].author,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.white)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      '${_foundUsers[index].publishedYear.toString()} years old',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.white)),
                                  SizedBox(
                                    height: 10,
                                  ),
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
                          //
                        ),
                      )
                    : const Text(
                        'No results found',
                        style: TextStyle(fontSize: 24),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
