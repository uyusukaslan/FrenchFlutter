import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:french/main.dart';
import 'package:french/main/profile.dart';
import 'package:french/main/study.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => HomeState();
}


class HomeState extends State {

  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        backgroundColor: Colors.white,
        fontFamily: 'playfair_display',
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      home: Scaffold(
          backgroundColor: Colors.lightBlueAccent,
          appBar: buildAppBar(),
          body: buildBody(context),
          bottomNavigationBar: buildNavbar(),
        ),

    );
  }

  Widget buildNavbar() {
    return CurvedNavigationBar(
      height: 70,
      backgroundColor: Colors.transparent,
      animationDuration: const Duration(milliseconds: 400),
      items: const <Widget>[
        Icon(Icons.school, size: 30,),
        Icon(Icons.add, size: 30,),
        Icon(Icons.person, size: 30,),
      ],
      onTap: (index){
        setState(() {
          _page = index;
        });
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text("Gallus", style: TextStyle(color: Colors.blueGrey, fontSize: 23, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, letterSpacing: 1, fontFamily: 'playfair_display'),),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: CircleAvatar(
            backgroundColor: Colors.black,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: CircleAvatar(
            backgroundColor: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      color: Colors.transparent,
      child: changePage(_page),
    );
  }

  Widget changePage(int page){
    switch (page){
      case 0: return Study();
      case 1: return Welcome();
      case 2: return Profile();
    }
    return Welcome();
  }
}
