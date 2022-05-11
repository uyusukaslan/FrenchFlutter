import 'package:flutter/material.dart';
import 'package:french/main/lesson/lesson.dart';

class Stories extends StatefulWidget {

  @override
  _StoriesState createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {

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
              Center(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Image.asset('assets/images/stories.png', width: 200, height: 200,),

                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  //child: Text("Poyraz Erdoğan", textAlign: TextAlign.right, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),),
                  child: Text("Burada hikayelerini okuyabileceksin.", textAlign: TextAlign.center, style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 18, letterSpacing: .7),),
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
