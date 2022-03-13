import 'package:flutter/material.dart';
import 'package:french/main/home.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Deneme",
    //theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Color.fromARGB(255, 0, 53, 102)),
    theme: ThemeData(
      primaryColor: Colors.white,
      backgroundColor: Colors.green,
      textTheme: GoogleFonts.nunitoTextTheme(),
      scaffoldBackgroundColor: Colors.white,
    ),
    home: Welcome(),
  ));
}



class Welcome extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _WelcomeState();
  }
}

class _WelcomeState extends State {
  List<PageViewModel> pageList = [
    PageViewModel(
      decoration: const PageDecoration(
        imageFlex: 4,
        bodyFlex: 2,
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        titlePadding: EdgeInsets.only(bottom: 13),
        bodyTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.normal,
        ),
      ),
      title: "Yepyeni bir Öğrenme Planı",
      body: "Herkese göre, hızlı ve efektif olan planımızla hiçbir vaktinizi boşa harcamayın.",
      image: Image.asset(
        'assets/images/a.jpg',
        scale: 0.3,
      ),
    ),
    PageViewModel(
      decoration: const PageDecoration(
        imageFlex: 5,
        bodyFlex: 3,
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.4,
          wordSpacing: 1,
        ),
        titlePadding: EdgeInsets.all(13),
        bodyTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.4,
            wordSpacing: 1),
      ),
      title: "Yepyeni bir Öğrenme Planı",
      body: "Herkese göre, hızlı ve efektif olan planımızla hiçbir vaktinizi boşa harcamayın.",
      image: Image.asset(
        'assets/images/a.jpg',
        scale: 0.3,
      ),
    ),
    PageViewModel(
      decoration: const PageDecoration(
        imageFlex: 5,
        bodyFlex: 3,
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.4,
          wordSpacing: 1,
        ),
        titlePadding: EdgeInsets.all(13),
        bodyTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.4,
            wordSpacing: 1),
      ),
      title: "Yepyeni bir Öğrenme Planı",
      body: "Herkese göre, hızlı ve efektif olan planımızla hiçbir vaktinizi boşa harcamayın.",
      image: Image.asset(
        'assets/images/a.jpg',
        scale: 0.3,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          //appBar: AppBar(title: Text("Karşılama",), centerTitle: true,),
            body: buildIntroductionScreen(context)
    );
  }

  Widget buildIntroductionScreen(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      showNextButton: true,
      showDoneButton: true,
      next: const Text("İleri", style: TextStyle(fontSize: 16),),
      skip: const Text("Atla", style: TextStyle(fontSize: 16),),
      pages: pageList,
      showSkipButton: true,
      done: const Text("Bitti", style: TextStyle(fontSize: 16),),
      color: Colors.white,
      skipColor: Colors.red,
      doneColor: Colors.green,
      nextColor: Colors.blue,
      onDone: (){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home()),
              (Route<dynamic> route) => false,
        );
      },
    );
  }
}
