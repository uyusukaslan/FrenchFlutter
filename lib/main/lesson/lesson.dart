import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:french/main/lesson/lesson_service.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'create_lesson.dart';

final page_index = ValueNotifier<int>(0);
LessonService _service = LessonService();

class Lesson extends StatefulWidget {

  int lesson_index = 0;

  Lesson(this.lesson_index);

  @override
  LessonState createState() => LessonState();
}

class LessonState extends State<Lesson> {

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
  static int _page_index = 0;

  static List data = [];
  String jsonResult = "";

  Future<void> readJson() async {
    jsonResult = await DefaultAssetBundle.of(context).loadString("assets/data/lesson_data/lesson_data.json");
    setState(() {
      data = jsonDecode(jsonResult);
    });
  }

  @override
  void initState(){
    page_index.value = 0;
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
                child: ValueListenableBuilder(
                  valueListenable: page_index,
                  builder: (context, value, widget){
                    return LinearPercentIndicator(
                      lineHeight: 9,
                      percent: page_index.value / data[_lesson_index]['pages'].length,
                      backgroundColor: Color(0xff5e4d71),
                      progressColor: Color(0xffff7548),
                    );
                  }
                ),
            ),
          )
        ],
      ),
      centerTitle: true,
    );
  }

  Widget buildBody() {

    return ValueListenableBuilder(
      valueListenable: page_index,

      builder: (context, value, widget){
        return Container(
          height: 900,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: setLesson(),
          ),

        );
      },
    );
  }

  setLesson(){
    var page = page_index.value >= data[_lesson_index]['pages'].length ? null : (data[_lesson_index]['pages'][page_index.value] ?? data[_lesson_index]['pages'][0]);

    if (page_index.value > data[_lesson_index]['pages'].length - 1){
        data[0]['title'] = "completed";
        jsonEncode(data);
        Navigator.pop(context);
    }
    else{
      switch(data.isNotEmpty ? page['type'] : null){
        case "text":
          return Text("Text");
        case "video":
          return CreateVideo(page['path']);
        case "word":
          return CreateWord(page['path'], page['word'], page['sentence']);
        case "audio_match":
          return CreateAudioMatch(page['answers'], page['text'], page['correct_answer_index'], page['complete']);
        case "complete_text":
          return CreateCompleteText(page['text'], page['answer'], page['complete']);
        case "table":
          return CreateTable(page['paths'], page['rows']);
        case "select_from_audio":
          int index = page['correct_answer_index'];
          return CreateAnswerFromAudio(page['path'], page['correct_answer_index'], page['answers'][0], page['answers']);
        case "dialogue_order":
          return CreateDialogueOrder(page['answers']);
        case "select_from_image":
          return CreateAnswerFromImage(page['correct_answer_index'], page['answers'], page['path']);
        default:
          return Text("Bir hata oluştu. " + page.toString());
      }
    }
  }
}
