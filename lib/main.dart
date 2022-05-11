import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:french/main/home.dart';
import 'package:french/main/lesson/lesson.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Deneme",
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Color.fromARGB(255, 0, 53, 102),
      primaryColor: Colors.white,
      backgroundColor: Colors.green,
      textTheme: GoogleFonts.nunitoTextTheme(),
    ),
    /*theme: ThemeData(
      primaryColor: Colors.white,
      backgroundColor: Colors.green,
      textTheme: GoogleFonts.nunitoTextTheme(),
      scaffoldBackgroundColor: Colors.white,
    ),*/
    home: Splash(),
  ));
}

class Splash extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _SplashState();
  }
}

class _SplashState extends State {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 10), (){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()), (route) => false);
    });

    Future.delayed(Duration(seconds: 2), (){
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // body: Center(
      //   child: Image.asset("assets/images/kalp.gif") ,
      // ),
    );

  }

}
