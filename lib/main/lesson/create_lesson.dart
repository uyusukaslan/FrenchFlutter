import 'package:flutter/material.dart';
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
                child: Text("Play Sound"),
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

//-------------------------------------------------------

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
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: InkWell(onTap: (){
                _controller.value.isPlaying ? _controller.pause() : _controller.play();
              }
              ,child: Container(child: VideoPlayer(_controller))),
            ),
            Spacer(),
            ElevatedButton(onPressed: (){
              _controller.value.isPlaying ? _controller.pause() : _controller.play();
            }, child: Text("Stop")
            )],
        )
    );
  }
}
