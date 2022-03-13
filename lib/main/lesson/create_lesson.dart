import 'package:flutter/material.dart';
import 'package:french/main/lesson/lesson.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';
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
                  children: [
                    Text("Videoyu İzle", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),),

                    SizedBox(height: 20,),

                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: InkWell(onTap: (){
                        _controller.value.isPlaying ? _controller.pause() : _controller.play();
                      }
                      ,child: Container(child: VideoPlayer(_controller))),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(onPressed: (){

                }, child: Text("İleri")
                ),
              ),
            )],
        )
    );
  }
}

//----------------- COMPLETE TEXT ----------------

class _CreateCompleteText extends StatefulWidget {
  const _CreateCompleteText({Key? key}) : super(key: key);

  @override
  _CreateCompleteTextState createState() => _CreateCompleteTextState();
}

class _CreateCompleteTextState extends State<_CreateCompleteText> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


//----------------- AUDIO ----------------

class CreateAudioMatch extends StatefulWidget {

  var pathsToPlay = [];
  String text = '';
  var correct_answer_index;
  CreateAudioMatch(this.pathsToPlay, this.text, this.correct_answer_index);

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
    return Center(
      child: Column(
        children: [
          Text("Ses ile metni eşleştir"),
          Text(widget.text),
          Row(
            children: [

              ElevatedButton(
                child: Icon(Icons.speaker),
                onPressed: () async{
                  await player.setAsset(widget.pathsToPlay[0]);
                  _selected = 0;
                  player.play();
                },
              ),

              ElevatedButton(
                child: Icon(Icons.speaker),
                onPressed: () async{
                  await player.setAsset(widget.pathsToPlay[1]);
                  _selected = 1;
                  player.play();
                },
              ),

              ElevatedButton(
                  child: Text("Cevapla"),

              onPressed: (){
                if(_selected == null){
                  print("NULL");
                }
                else if (_selected == widget.correct_answer_index){
                  success();
                }
                else{
                  print("BAŞARISIZ");
                }
              },
              )
            ],
          ),
        ],
      ),
    );
  }

  void nextPage(){

  }

  void success(){
    print("BAŞARILI BAŞARILI BAŞARILI BAŞARILI BAŞARILI BAŞARILI BAŞARILI ");
  }
}