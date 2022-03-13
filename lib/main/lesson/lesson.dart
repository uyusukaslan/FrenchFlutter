import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'create_lesson.dart';


class Lesson extends StatefulWidget {

  int lesson_index = 0;
  Lesson(this.lesson_index);

  @override
  LessonState createState() => LessonState();
}

class LessonState extends State<Lesson> {
  final lessonKey = GlobalKey<LessonState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff413250),
      appBar: buildAppBar(),
      body: buildBody(),
      //bottomNavigationBar: buildNavbar(),
    );
  }

  late int _lesson_index = widget.lesson_index;
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
      automaticallyImplyLeading: false,
      titleSpacing: 0.0,
      backgroundColor: Color(0xff413250),
      shadowColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(CupertinoIcons.clear),
            color: Color(0xffffffff),
            onPressed: () => Navigator.pop(context),
          ),

          Expanded(
            child: Center(
                child: LinearPercentIndicator(
                  lineHeight: 9,
                  percent: .3,
                  backgroundColor: Color(0xff5e4d71),
                  progressColor: Color(0xffff7548),
                )
            ),
          )
        ],
      ),
      centerTitle: true,
      actions: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(CupertinoIcons.lightbulb),
              color: Color(0xffffffff),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }

  Widget buildBody() {

    return Container(
      key: lessonKey,
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
      case "audio_match":
        return CreateAudioMatch(page['answers'], page['text'], page['correct_answer_index']);
      default:
        return Text("Bir hata oluştu. " + page.toString());
    }
  }

  void nextPage(){
    setState(() {
      _page_index < data[_lesson_index]['pages'].length - 1 ? _page_index++ : null;
    });
  }
}
