import 'package:flutter/material.dart';
import 'package:internship/pages/homeNews/homeNews.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "App News",
      debugShowCheckedModeBanner: false,
      home: HomeNews(),
    );
  }
}
