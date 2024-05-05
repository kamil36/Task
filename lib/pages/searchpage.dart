import 'package:flutter/material.dart';
import 'package:task_books/common/styles/colors.dart';
import 'package:task_books/common/styles/textstyles.dart';
import 'package:task_books/models/bookmodel.dart';
import 'package:task_books/pages/bookitempage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.works}) : super(key: key);
  final List<Work?> works;
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Work?> _foundUsers = [];
  @override
  initState() {
    _foundUsers = widget.works;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Work?> results = [];
    if (enteredKeyword.isEmpty) {
      results = widget.works;
    } else {
      results = widget.works
          .where((book) => (book?.title ?? "")
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      _foundUsers = results;
    });
  }

  bool isRead = false;
  int? selectedIndex;

  void toggleStatus(int index) {
    setState(() {
      isRead = !isRead;
      selectedIndex = index;
    });
  }

  String COVER_URL = 'https://covers.openlibrary.org/b/id/';

  bool isclicked = false;

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
                        itemBuilder: (context, index) {
                          final isSelected = selectedIndex == index;
                          final isread = isRead;
                          return Card(
                            key: ValueKey(_foundUsers[index]?.title),
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookItemPage(
                                        book: _foundUsers[index] ?? Work(),
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Image.network(
                                      '$COVER_URL${_foundUsers[index]?.coverId}-M.jpg',
                                      fit: BoxFit.fill,
                                      height: 350,
                                      width: 350,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      (_foundUsers[index]?.title ?? "")
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight:
                                              AppTextStyles.fw22.fontWeight,
                                          fontSize: AppTextStyles.fw22.fontSize,
                                          color: AppColors.primary),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        (_foundUsers[index]?.authorNames ?? [])
                                            .join(", "),
                                        style: TextStyle(
                                            fontWeight:
                                                AppTextStyles.fw22.fontWeight,
                                            fontSize:
                                                AppTextStyles.fw22.fontSize,
                                            color: AppColors.primary)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        '${_foundUsers[index]?.firstPublishYear.toString()} years old',
                                        style: TextStyle(
                                            fontWeight:
                                                AppTextStyles.fw22.fontWeight,
                                            fontSize:
                                                AppTextStyles.fw22.fontSize,
                                            color: AppColors.primary)),
                                    SizedBox(
                                      height: 10,
                                    ),
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
                                        isSelected && isread
                                            ? "Read"
                                            : "Unread",
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize:
                                                AppTextStyles.fw22.fontSize,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //
                          );
                        })
                    : Text(
                        'No results found',
                        style: TextStyle(
                          fontSize: AppTextStyles.fw25.fontSize,
                          fontWeight: AppTextStyles.fw25.fontWeight,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
