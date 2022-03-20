import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:french/main/lesson/lesson.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';

import 'lesson_service.dart';
//import 'package:google_fonts/google_fonts.dart';

class CreateWord extends StatefulWidget {

  var pathToPlay = '';
  String word = '';
  String sentence = '';
  CreateWord(this.pathToPlay, this.word, this.sentence);

  @override
  _CreateWordState createState() => _CreateWordState();
}

class _CreateWordState extends State<CreateWord> {

  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }
  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                child: Text("Play Sound", style: TextStyle(color: Colors.white, fontSize: 13),),
                onPressed: () async{
                  await player.setAsset(widget.pathToPlay);
                  player.play();
                },
              ),
              Text(widget.word),
              Text(widget.sentence)
            ],
          ),
        ],
      ),
    );
  }
}

//--------------------------- VIDEO ----------------------------

class CreateVideo extends StatefulWidget {

  var asset = '';
  CreateVideo(this.asset);

  @override
  _CreateVideoState createState() => _CreateVideoState();
}

class _CreateVideoState extends State<CreateVideo> {

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(widget.asset)
      ..addListener(() {setState(() {});})
      ..setLooping(false)
      ..initialize().then((value) => _controller.play());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [

            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Videoyu İzle", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),),

                    SizedBox(height: 20,),

                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: InkWell(onTap: (){
                        _controller.value.isPlaying ? _controller.pause() : _controller.play();
                      }
                      ,child: Flexible(child: VideoPlayer(_controller))),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(onPressed: (){
                  nextPage();
                }, child: Text("İleri")
                ),
              ),
            )],
        )
    );
  }
}

//----------------- COMPLETE TEXT ----------------

class CreateCompleteText extends StatefulWidget {

  String text = '';
  String answer = '';
  String complete = '';

  CreateCompleteText(this.text, this.answer, this.complete);

  @override
  _CreateCompleteTextState createState() => _CreateCompleteTextState();
}

class _CreateCompleteTextState extends State<CreateCompleteText> {

  TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Boşluğa ne gelmelidir?"),
            Text(widget.text),
            TextField(
              controller: answerController,
            ),

            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(onPressed: (){
                  answerController.text.trim().toLowerCase()== widget.answer.toLowerCase() ? correct(context, widget.complete) : inCorrect(context, widget.complete);
                },child: Text("İleri")
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//----------------- AUDIO ----------------

class CreateAudioMatch extends StatefulWidget {

  var pathsToPlay = [];
  String text = '';
  var correct_answer_index;
  String complete = '';

  CreateAudioMatch(this.pathsToPlay, this.text, this.correct_answer_index, this.complete);

  @override
  _CreateAudioMatchState createState() => _CreateAudioMatchState();
}

class _CreateAudioMatchState extends State<CreateAudioMatch> {

  String path = '';
  var _selected;

  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }
  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Ses ile metni eşleştir", style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),),
          SizedBox(height: 10),
          Text(widget.text, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                CircleAvatar(
                  radius: 60,
                  backgroundColor: Color(0xffff7548),
                  child: IconButton(
                    iconSize: 60,
                    icon: Icon(CupertinoIcons.speaker_2),
                    onPressed: () async{
                      await player.setAsset(widget.pathsToPlay[0]);
                      _selected = 0;
                      player.play();
                    },
                  ),
                ),

                CircleAvatar(
                  radius: 60,
                  backgroundColor: Color(0xffff7548),
                  child: IconButton(
                    iconSize: 60,
                    icon: Icon(CupertinoIcons.speaker_2_fill),
                    onPressed: () async{
                      await player.setAsset(widget.pathsToPlay[1]);
                      _selected = 1;
                      player.play();
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                child: Text("Cevapla"),

                onPressed: (){
                  if(_selected == null){
                    print("NULL");
                  }
                  else if (_selected == widget.correct_answer_index){
                    correct(context, widget.complete);
                  }
                  else{
                    inCorrect(context, widget.complete);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Go to next page

void nextPage(){
  LessonService _service = LessonService();
  page_index.value++;
  page_index.notifyListeners();
  print(page_index.value);
}

// Correct

void correct(BuildContext context, complete){
  final snackBar = SnackBar(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('Doğru Cevap!', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
        SizedBox(height: 10,),
        Text(complete, textAlign: TextAlign.center, style: TextStyle(fontSize: 14,),),
        SizedBox(height: 20,),
        ElevatedButton(
          child: Text("DEVAM ET", style: TextStyle(fontWeight: FontWeight.w700),),
          onPressed: (){
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            nextPage();
          },
        )
      ],
    ),
    backgroundColor: Colors.teal,
    behavior: SnackBarBehavior.fixed,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);


}

// Not Correct

void inCorrect(BuildContext context, complete){
  final snackBar = SnackBar(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('Hmm...', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
        SizedBox(height: 10,),
        Text(complete, textAlign: TextAlign.center, style: TextStyle(fontSize: 14,),),
        SizedBox(height: 20,),
        ElevatedButton(
          child: Text("BİR DAHA DENE", style: TextStyle(fontWeight: FontWeight.w700),),
          onPressed: (){
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        )
      ],
    ),
    backgroundColor: Colors.redAccent,
    behavior: SnackBarBehavior.fixed,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}