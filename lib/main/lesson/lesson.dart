import 'dart:convert';

import 'package:flutter/material.dart';

import 'create_lesson.dart';

class Lesson extends StatefulWidget {

  @override
  _LessonState createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: buildNavbar(),
    );
  }

  int _lesson_index = 0;
  int _page_index = 0;

  final lesson = CreateLesson();
  List data = [];
  String jsonResult = "";

  Future<void> readJson() async {
    jsonResult = await DefaultAssetBundle.of(context).loadString("assets/data/lesson_data/lesson_data.json");
    setState(() {
      data = jsonDecode(jsonResult);
    });
  }

  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance!
        .addPostFrameCallback((_) => readJson());
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(data.isNotEmpty ? data[_lesson_index]['title'] : "404 Title Not Found", style: TextStyle(color: Colors.black45),),
      bottomOpacity: 0,
      elevation: 0,
    );
  }

  Widget buildBody() {
    return setLesson();
  }

  Widget setLesson(){
    switch(data.isNotEmpty ? data[_lesson_index]['pages'][0]['type'] : null){
      case "text":
        return lesson.createText(data[_lesson_index]['pages'][_page_index]['text']);
      case "video":
        return lesson.createVideo();
      default:
        return Text("Bir hata oluştu.");
    }
  }

  Widget buildNavbar() {
    return Text("data");
  }
}
