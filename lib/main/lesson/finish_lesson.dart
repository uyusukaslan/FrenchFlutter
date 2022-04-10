import 'package:flutter/material.dart';
import 'package:french/main/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class FinishLesson extends StatefulWidget {

  String lessonName = "";
  String path = "";

  FinishLesson(this.lessonName, this.path);

  @override
  _FinishLessonState createState() => _FinishLessonState();
}

class _FinishLessonState extends State<FinishLesson> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AudioPlayer player = AudioPlayer();
    player.setAsset('assets/audio/correct.mp3');
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff413250),
      body: buildBody(),
    );
  }

  buildBody() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(widget.lessonName, textAlign: TextAlign.center, style: GoogleFonts.lemonada(fontWeight: FontWeight.w700, fontSize: 28, color: Colors.yellow),),

                  SizedBox(height: 30,),

                  Container(
                    width: 120,
                    height: 120,
                    child: Padding(
                      padding: EdgeInsets.all(13),
                      child: Image.asset(widget.path),
                    ),
                  ),

                  SizedBox(height: 10,),

                  Text("TAMAMLANDI!", textAlign: TextAlign.center, style: GoogleFonts.carterOne(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.yellow, letterSpacing: 2),),

                  SizedBox(height: 15,),

                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 50,
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 2000,
                      percent: 1,
                      center: Text("100%", textAlign: TextAlign.center, style: GoogleFonts.irishGrover(fontWeight: FontWeight.w700, letterSpacing: 3, fontSize: 15),),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Color(0xffBDBC5B),
                    ),
                  ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: (){
                  Future((){
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                          (Route<dynamic> route) => false,
                    );
                  });

                },
                child: Text("DERSİ BİTİR"),
              ),
            )
          ],
        ),
      ),
    );
  }


}
