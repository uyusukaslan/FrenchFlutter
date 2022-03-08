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

    return Container(
      height: 900,
        child: Padding(
          padding: const EdgeInsets.all(8.0),

              child: setLesson(),
        ),

    );
  }

  Widget setLesson(){
    var page = data[_lesson_index]['pages'][_page_index];

    //switch("video"){
    switch(data.isNotEmpty ? page['type'] : null){
      case "text":
        return Text("Text");
      case "video":
        return CreateVideo(page['path']);
      case "word":
        return CreateWord(page['path'], page['word'], page['sentence']);
      default:
        return Text("Bir hata oluştu. " + page.toString());
    }
  }

  Widget buildNavbar() {
    return Container(
      height: 70,
      color: Colors.lightGreenAccent,
      child: Center(
        child: ElevatedButton(
          onPressed: (){
            setState(() {
              _page_index < data[_lesson_index]['pages'].length - 1 ? _page_index++ : null;
            });
          },
          child: Icon(Icons.forward, color: Colors.orange,),
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
        )
        )
    );
  }
}
