import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:square_percent_indicater/square_percent_indicater.dart';

import 'lesson/lesson.dart';

class Study extends StatefulWidget {

  @override
  _StudyState createState() => _StudyState();
}

class _StudyState extends State<Study> {
  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  /* Read JSON */

  List _data = [];
  String jsonResult = "";

  Future<void> readJson() async {
    jsonResult = await DefaultAssetBundle.of(context).loadString("assets/data/lesson_data/lesson_data.json");
    setState(() {
      _data = jsonDecode(jsonResult);
    });
  }

  /* Init State */

  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance!
        .addPostFrameCallback((_) => readJson());
  }



  /* Build Body */

  Widget buildBody(BuildContext context){
    return _data.isEmpty
        ? CircularProgressIndicator()
        : ListView.builder(
          itemCount: _data.length,
          itemBuilder: (BuildContext context, int index){
            return createLessonCard(_data[index]['title'], _data[index]['status'], index);
      },
    );
  }

  void changePage(int index, bool isCompleted, isInProgress) {

    isCompleted || isInProgress

    ?Navigator.of(
      context, rootNavigator: true)
      .push(MaterialPageRoute(builder: (context) => Lesson(index)),
    )
    :null;
  }

  /* Create Lesson Card */

  Widget createLessonCard(String name, String status, int index) {

    double progress = .4;
    bool _isCompleted = false;
    bool _isInProgress = false;

    if(status == 'completed'){
      _isCompleted = true;
    }
    else if (status == 'locked'){
      _isCompleted = false;
    }
    else{
      _isInProgress = true;
    }

    return InkWell(
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => changePage(index, _isCompleted, _isInProgress),
      child: Flexible(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Container(
                color: _isInProgress ? Color(0xffedf0f8) : Color(0x0000000),
                padding: _isInProgress ? EdgeInsets.symmetric(vertical: 15, horizontal: 0) : EdgeInsets.all(0),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: !_isInProgress,
                          child:
                        _isCompleted
                            ? CircleAvatar(child: Icon(Icons.done_rounded, color: Colors.white), backgroundColor: Color(0xffff7548), radius: 15,)
                            : CircleAvatar(child: Icon(Icons.lock_rounded, color: Color(0xffb1b8d1)), backgroundColor: Color(0xffedf0f8), radius: 15),
                        ),

                        !_isInProgress
                          ? SizedBox(width: 10,)
                          : SizedBox(width: 10 + 2 * 15),


                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              !_isCompleted
                                ? Flexible(
                                  child: SquarePercentIndicator(
                                    startAngle: StartAngle.topLeft,
                                    width: 80,
                                    height: 80,
                                    progress: _isInProgress ?  progress : 0,
                                    reverse: false,
                                    progressWidth: 3,
                                    shadowWidth: 3,
                                    progressColor: Color(0xffff7548),
                                    shadowColor: _isInProgress ? Color(0xffffffff) : Color(0xffedf0f8),
                                    borderRadius: 28,
                                    child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(28)),
                                      child: Container(
                                        child: Padding(
                                          padding: EdgeInsets.all(13),
                                          child: Image.asset('assets/images/food_icon.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                )

                              : Flexible(
                                child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(28)),
                                  child: Container(
                                    color: Color(0xffedf0f8),
                                    width: 80,
                                    height: 80,
                                    child: Padding(
                                      padding: EdgeInsets.all(13),
                                      child: Image.asset('assets/images/food_icon.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),



                        Flexible(
                          child: ListTile(
                            title: Text("Ders " + (index+1).toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                            subtitle: Text(name, style: TextStyle(fontSize: 14)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
