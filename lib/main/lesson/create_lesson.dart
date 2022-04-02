import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:french/main/lesson/lesson.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';
import 'package:collection/collection.dart';

import 'lesson_service.dart';
//import 'package:google_fonts/google_fonts.dart';

// ----------------- WORD ----------------

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

// ------------------- TABLE ----------------------

class CreateTable extends StatefulWidget {

  var paths = [];
  List rows = [];


  CreateTable(this.paths, this.rows);

  @override
  _CreateTableState createState() => _CreateTableState();
}

class _CreateTableState extends State<CreateTable> {

  String path = '';

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

  Widget createTable(rowList) {
    List<TableRow> rows = [];
    for (int i = 0; i < rowList.length; i++) {
      rows.add(
          TableRow(
              children: [
                InkWell(
                  onTap: () async{
                    await player.setAsset(widget.paths[i]);
                    player.play();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(rowList[i][0], textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(rowList[i][1], textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14)),
                ),
              ]
          )
      );
    }
    return Center(
      child: Table(
          border: TableBorder.symmetric(inside: BorderSide(width: 1, color: Color(0xff7B678E),), outside: BorderSide(width: 1, color: Color(0xff7B678E))),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {
            0: FractionColumnWidth(.5),
            1: FractionColumnWidth(.5),
          },
          children: rows,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Kelimelerin Üzerine Basarak Dinle ve Tekrar Et", style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),),
          //SizedBox(height: 10),

          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
                child: createTable(widget.rows)
            )

          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 2/ 3,
              height: MediaQuery.of(context).size.width / 8,
              child: ElevatedButton(
                child: Text("Devam Et", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),),
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  primary: Color(0xffff7548),
                ),

                onPressed: (){
                  nextPage();
                },
              ),
            ),
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
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Videoyu izle", style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),),

              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: InkWell(onTap: (){
                      _controller.value.isPlaying ? _controller.pause() : _controller.play();
                    }
                    ,child: Flexible(child: VideoPlayer(_controller))),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 2/ 3,
                  height: MediaQuery.of(context).size.width / 8,
                  child: ElevatedButton(
                    child: Text("Devam Et", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      primary: Color(0xffff7548),
                    ),

                    onPressed: (){
                      nextPage();
                    },
                  ),
                ),
              ),
            ],
          ),
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

// -------------- CHOOSE CORRECT FROM AUDIO -----------

class CreateAnswerFromAudio extends StatefulWidget {

  String path = '';
  int correct_answer_index;
  var answers = [];
  String complete = '';

  CreateAnswerFromAudio(this.path, this.correct_answer_index, this.complete, this.answers);

  @override
  _CreateAnswerFromAudioState createState() => _CreateAnswerFromAudioState();
}

class _CreateAnswerFromAudioState extends State<CreateAnswerFromAudio> {


  var _selected = null;

  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();

    player.setAsset(widget.path);
    player.play();
  }
  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void isCorrect(int index){

      if(widget.correct_answer_index == index){
        correct(context, widget.answers[widget.correct_answer_index]);
        player.setAsset('assets/audio/correct.mp3');
        player.play();
      }
      else{
        inCorrect(context, widget.answers[widget.correct_answer_index]);
        player.setAsset('assets/audio/wrong.mp3');
        player.play();
      }

  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Dinle, doğru Cevabı Bul", style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),),

            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Color(0xffff7548),
                  child: IconButton(
                    iconSize: 70,
                    icon: Icon(CupertinoIcons.speaker_2),
                    onPressed: () async{
                      await player.setAsset(widget.path);
                      _selected = 0;
                      player.play();
                    },
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      child: ElevatedButton(onPressed: () => isCorrect(0), child: Text(widget.answers[0], style: TextStyle(fontSize: 18)), style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        primary: Color(0xff76519C),
                      ),),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 5,
                    ),

                    SizedBox(height: 5,),

                    SizedBox(
                      child: ElevatedButton(onPressed: () => isCorrect(1), child: Text(widget.answers[1], style: TextStyle(fontSize: 18)), style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        primary: Color(0xff76519C),
                      ),),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 5,
                    ),

                    SizedBox(height: 5,),

                    SizedBox(
                      child: ElevatedButton(onPressed: () => isCorrect(2), child: Text(widget.answers[2], style: TextStyle(fontSize: 18)), style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        primary: Color(0xff76519C),
                      ),),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 5,
                    ),

                    SizedBox(height: 5,),

                    SizedBox(
                      child: ElevatedButton(onPressed: () => isCorrect(3), child: Text(widget.answers[3], style: TextStyle(fontSize: 18)), style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        primary: Color(0xff76519C),
                      ),),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//--------------- DIALOGUE ORDER ----------------

class CreateDialogueOrder extends StatefulWidget {

  List<dynamic> text = [];

  List<String> complete = [];
  List<int> indexes = [1,2,3,4];

  CreateDialogueOrder(this.text);

  @override
  _CreateDialogueOrderState createState() => _CreateDialogueOrderState();
}

class _CreateDialogueOrderState extends State<CreateDialogueOrder> {

  bool areListsEqual(var list1, var list2) {
    // check if both are lists
    if(!(list1 is List && list2 is List)
        // check if both have same length
        || list1.length!=list2.length) {
      return false;
    }

    // check if elements are equal
    for(int i=0;i<list1.length;i++) {
      if(list1[i]!=list2[i]) {
        return false;
      }
    }

    return true;
  }

  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    createText();
  }
  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void isCorrect(int index){
    if(areListsEqual(widget.text, widget.complete)){
      correct(context, "");
      player.setAsset('assets/audio/correct.mp3');
      player.play();
    }
    else{
      print(widget.complete);
      inCorrect(context, "");
      player.setAsset('assets/audio/wrong.mp3');
      player.play();
    }
  }

  createText(){
    for(int i=0; i < widget.text.length; i++){
      widget.complete.add(widget.text[widget.indexes[i]-1]);
      print("\nRESULT\n");
      print(widget.text);
      print(widget.complete);
    }
  }

  void reorderData(int oldindex, int newindex){
    setState(() {
      if(newindex>oldindex){
        newindex-=1;
      }
      final items =widget.text.removeAt(oldindex);
      widget.text.insert(newindex, items);
    });
    print(widget.text);
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        ReorderableListView.builder(
          shrinkWrap: true,
        scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index){
            return Card(
              color: Colors.blueGrey,
              key: ValueKey(index),
              elevation: 2,
              child: ListTile(
                  title: Text(widget.text[index])
              ),
            );
          },
          itemCount: widget.text.length,
          onReorder: reorderData,
        ),

        /*return ReorderableListView(
          buildDefaultDragHandles: false,
            children: <Widget>[
              for(final items in widget.text)
                Card(
                  color: Colors.blueGrey,
                  key: ValueKey(items),
                  elevation: 2,
                  child: ListTile(
                    title: Text(items),
                    leading: Icon(Icons.work,color: Colors.black,),
                  ),
                ),
            ],
            onReorder: reorderData,

          );*/

        ElevatedButton(onPressed: () => isCorrect(1), child: Text("CEVAPLA", style: TextStyle(fontSize: 18)), style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          primary: Color(0xff76519C),
        ),),
      ],
    );



  }
}

//-------------- FIND ANSWER FROM IMAGE ----------------

class CreateAnswerFromImage extends StatefulWidget {


  int correct_answer_index;
  var answers = [];
  String complete = '';
  var img;

  CreateAnswerFromImage(this.correct_answer_index, this.answers, this.img);

  @override
  _CreateAnswerFromImageState createState() => _CreateAnswerFromImageState();
}

class _CreateAnswerFromImageState extends State<CreateAnswerFromImage> {

  var _selected = null;

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
  


  void isCorrect(int index){
    if(widget.correct_answer_index == index){
      correct(context, widget.answers[widget.correct_answer_index]);
      player.setAsset('assets/audio/correct.mp3');
      player.play();
    }
    else{
      inCorrect(context, widget.answers[widget.correct_answer_index]);
      player.setAsset('assets/audio/wrong.mp3');
      player.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Resim ile Cevabı Eşleştir", style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),),

            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Align(
                        child: Image.asset(
                          widget.img,
                          fit: BoxFit.contain,
                          height: MediaQuery.of(context).size.width * 2 / 3 > 300 ? 300 : MediaQuery.of(context).size.width * 2 / 3,
                          width: MediaQuery.of(context).size.width * 2 / 3 > 300 ? 300 : MediaQuery.of(context).size.width * 2 / 3,
                        ),
                        alignment: Alignment.bottomCenter,
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                child: ElevatedButton(onPressed: () => isCorrect(0), child: Text(widget.answers[0], style: TextStyle(fontSize: 18)), style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.transparent,
                                  primary: Color(0xff76519C),
                                ),),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width / 3.5,
                            ),

                            SizedBox(height: 5,),

                            SizedBox(
                              child: ElevatedButton(onPressed: () => isCorrect(1), child: Text(widget.answers[1], style: TextStyle(fontSize: 18)), style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                primary: Color(0xff76519C),
                              ),),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width / 3.5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//----------------- AUDIO MATCH ----------------

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

  void isCorrect(int index){
    if(widget.correct_answer_index == index){
      correct(context, widget.complete);
      player.setAsset('assets/audio/correct.mp3');
      player.play();
    }
    else{
      inCorrect(context, widget.complete);
      player.setAsset('assets/audio/wrong.mp3');
      player.play();
    }
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
                  isCorrect(_selected);
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

void correct(BuildContext context, String complete){
  
  final snackBar = SnackBar(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('Excellent!', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
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