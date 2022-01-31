import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'lesson_data.dart';

class Study extends StatefulWidget {

  @override
  _StudyState createState() => _StudyState();
}

class _StudyState extends State<Study> {
  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  /* Build Body */

  Widget buildBody(BuildContext context){
    return ListView.builder(
      itemCount: widgets['name']!.length,
      itemBuilder: (BuildContext context, int index){
        return createLessonCard(widgets['name']![index]);
      },
    );
  }

  /* Create Lesson Card */

  Widget createLessonCard(String name,) {
    return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(backgroundColor: Colors.amber,),
                  SizedBox(width: 20),
                  Text(name, style: TextStyle(fontSize: 19),),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  SizedBox(width: 20,),
                  CircleAvatar(backgroundColor: Colors.red, radius: 7,),
                  SizedBox(width: 20),
                  Text(name, style: TextStyle(fontSize: 16),),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  SizedBox(width: 20,),
                  CircleAvatar(backgroundColor: Colors.red, radius: 7,),
                  SizedBox(width: 20),
                  Text(name, style: TextStyle(fontSize: 16),),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  SizedBox(width: 20,),
                  CircleAvatar(backgroundColor: Colors.red, radius: 7,),
                  SizedBox(width: 20),
                  Text(name, style: TextStyle(fontSize: 16),),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
