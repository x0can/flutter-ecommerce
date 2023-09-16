import 'package:flutter/material.dart';
import 'package:food_delivery/views/shared/appstyle.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        'This is Search',
        style: appStyle(40, Colors.black, FontWeight.bold),
      )),
    );
    ;
  }
}
