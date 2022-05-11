import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:french/main/lesson/lesson.dart';
import 'lesson/create_lesson.dart';
import 'dart:convert';
import 'dart:async' show Future;

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }


  Widget buildBody(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/gallus.png',),
                    maxRadius: 80,
                    minRadius: 80,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  //child: Text("Poyraz Erdoğan", textAlign: TextAlign.right, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),),
                   child: Column(
                     children: [
                       Text("Burası senin profilin.\n\n", textAlign: TextAlign.center, style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 18, letterSpacing: .7),),
                       Text("(Bugün çok iyi görünüyorsun 😊)", textAlign: TextAlign.center, style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.w700, fontSize: 18, letterSpacing: .7),),
                     ],
                   ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void changePage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Lesson(0)),
          (Route<dynamic> route) => false,
    );
  }
}
