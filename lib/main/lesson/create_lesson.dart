import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class CreateLesson{

  Widget createText(String text){
    return Center(
      child: Expanded(
        child: Text(text),
      ),
    );
  }

  Widget createVideo(){
    return Center(child: Text("Video"));
  }
}