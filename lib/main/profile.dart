import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'lesson/lesson.dart';
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
  
  final lesson = Lesson();

  late List data;

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/people.json');
    setState(() => data = json.decode(jsonText));
    return 'success';
  }

  
  Widget buildBody(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/a.jpg'),
                maxRadius: 80,
                minRadius: 50,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              //child: Text("Poyraz Erdoğan", textAlign: TextAlign.right, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),),
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (BuildContext context, int index){
                  loadJsonData();
                  return ListTile(
                    title: data[index]["title"],
                  );
                },
              )
            ),
          )
        ],
      ),
    );
  }
}
