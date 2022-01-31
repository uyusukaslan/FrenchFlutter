import 'package:flutter/material.dart';

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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Center(
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
              child: Text("Poyraz Erdoğan", textAlign: TextAlign.right, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),),
            ),
          )
        ],
      ),
    );
  }
}
