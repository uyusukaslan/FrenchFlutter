import 'dart:io';

import 'package:show_up_animation/show_up_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:french/main/lesson/lesson.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';

import 'lesson_service.dart';

buildTitle(String text){
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
        color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
  );
}

// ----------------- WORD ----------------

// class CreateWord extends StatefulWidget {
//   var pathToPlay = '';
//   String word = '';
//   String sentence = '';
//   CreateWord(this.pathToPlay, this.word, this.sentence);
//
//   @override
//   _CreateWordState createState() => _CreateWordState();
// }
//
// class _CreateWordState extends State<CreateWord> {
//   late AudioPlayer player;
//   @override
//   void initState() {
//     super.initState();
//     player = AudioPlayer();
//
//     isBtnDownClass().isBtnDown = false;
//   }
//
//   @override
//   void dispose() {
//     player.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         children: [
//           Row(
//             children: [
//               ElevatedButton(
//                 child: const Text(
//                   "Play Sound",
//                   style: TextStyle(color: Colors.white, fontSize: 13),
//                 ),
//                 onPressed: () async {
//                   await player.setAsset(widget.pathToPlay);
//                   player.play();
//                 },
//               ),
//               Text(widget.word),
//               Text(widget.sentence)
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// ---------- TEXT -------------

class CreateText extends StatefulWidget {

  String text;

  CreateText(this.text);

  @override
  _CreateTextState createState() => _CreateTextState();
}

class _CreateTextState extends State<CreateText> {
  @override
  Widget build(BuildContext context) {
    return ShowUpAnimation(
      direction: Direction.horizontal,
      curve: Curves.bounceIn,
      offset: 0.5,
      delayStart: Duration(seconds: 0),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //buildTitle("Videoyu izle"),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                    widget.text,
                  style: const TextStyle(
                    color: Color(0xffefefef),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 2 / 3,
                height: MediaQuery.of(context).size.width / 8,
                child: ElevatedButton(
                  child: const Text(
                    "Devam Et",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    primary: Color(0xffff7548),
                  ),
                  onPressed: () {
                    nextPage();
                  },
                ),
              ),
            ),
          ],
        ),
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

    isBtnDownClass().isBtnDown = false;
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Widget createTable(rowList) {
    List<TableRow> rows = [];
    for (int i = 0; i < rowList.length; i++) {
      rows.add(TableRow(children: [
        InkWell(
          onTap: () async {
            await player.setAsset(widget.paths[i]);
            player.play();
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              rowList[i][0],
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
              rowList[i][1],
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14)),
        ),
      ]));
    }
    return Center(
      child: Table(
        border: TableBorder.symmetric(
            inside: const BorderSide(
              width: 1,
              color: Color(0xff7B678E),
            ),
            outside: const BorderSide(width: 1, color: Color(0xff7B678E))),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FractionColumnWidth(.5),
          1: FractionColumnWidth(.5),
        },
        children: rows,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShowUpAnimation(
      direction: Direction.horizontal,
      curve: Curves.bounceIn,
      offset: 0.5,
      delayStart: Duration(seconds: 0),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildTitle("Kelimelerin Üzerine Basarak Dinle ve Tekrar Et"),

          Expanded(
              child: Align(
                  alignment: Alignment.topCenter,
                  child: createTable(widget.rows))),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 2 / 3,
              height: MediaQuery.of(context).size.width / 8,
              child: ElevatedButton(
                child: const Text(
                  "Devam Et",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  primary: Color(0xffff7548),
                ),
                onPressed: () {
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

    isBtnDownClass().isBtnDown = false;

    _controller = VideoPlayerController.asset(widget.asset)
      ..addListener(() {
        setState(() {});
      })
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
    return ShowUpAnimation(
      direction: Direction.horizontal,
      curve: Curves.bounceIn,
      offset: 0.5,
      delayStart: Duration(seconds: 0),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildTitle("Videoyu izle"),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: InkWell(
                      onTap: () {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      },
                      child: VideoPlayer(_controller)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 2 / 3,
                height: MediaQuery.of(context).size.width / 8,
                child: ElevatedButton(
                  child: const Text(
                    "Devam Et",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    primary: Color(0xffff7548),
                  ),
                  onPressed: () {
                    nextPage();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
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
    return ShowUpAnimation(
      direction: Direction.horizontal,
      curve: Curves.bounceIn,
      offset: 0.5,
      delayStart: Duration(seconds: 0),
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
                child: ElevatedButton(
                    onPressed: () {
                      answerController.text.trim().toLowerCase() ==
                              widget.answer.toLowerCase()
                          ? correct(context, widget.complete, "")
                          : inCorrect(context, widget.complete);
                    },
                    child: Text("İleri")),
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

  CreateAnswerFromAudio(
      this.path, this.correct_answer_index, this.complete, this.answers);

  @override
  _CreateAnswerFromAudioState createState() => _CreateAnswerFromAudioState();
}

class _CreateAnswerFromAudioState extends State<CreateAnswerFromAudio> {
  var _selected = null;
  var root = '';

  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();

    isBtnDownClass().isBtnDown = false;

    player.setAsset(widget.path);
    player.play();


  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void isCorrect(int index) {
    if (!isBtnDownClass().isBtnDown) {
      if (widget.correct_answer_index == index) {
        correct(context, widget.answers[widget.correct_answer_index], widget.path);
        player.setAsset('assets/audio/correct.mp3');
        player.play();
      } else {
        inCorrect(context, widget.answers[widget.correct_answer_index]);
        player.setAsset('assets/audio/wrong.mp3');
        player.play();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShowUpAnimation(
      direction: Direction.horizontal,
      curve: Curves.bounceIn,
      offset: 0.5,
      delayStart: Duration(seconds: 0),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buildTitle("Dinle, doğru Cevabı Bul"),
            Expanded(
              child: Align(
                alignment: Alignment.center,

                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Color(0xffff7548),
                  child: IconButton(
                    iconSize: 70,
                    icon: Icon(CupertinoIcons.speaker_2),
                    onPressed: () async {
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
                      child: ElevatedButton(
                        onPressed: () => isCorrect(0),
                        child: Text(widget.answers[0],
                            style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          primary: Color(0xff76519C),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 5,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () => isCorrect(1),
                        child: Text(widget.answers[1],
                            style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          primary: Color(0xff76519C),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 5,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () => isCorrect(2),
                        child: Text(widget.answers[2],
                            style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          primary: Color(0xff76519C),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 5,
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // SizedBox(
                    //   child: ElevatedButton(
                    //     onPressed: () => isCorrect(3),
                    //     child: Text(widget.answers[3],
                    //         style: TextStyle(fontSize: 18)),
                    //     style: ElevatedButton.styleFrom(
                    //       shadowColor: Colors.transparent,
                    //       primary: Color(0xff76519C),
                    //     ),
                    //   ),
                    //   width: MediaQuery.of(context).size.width,
                    //   height: MediaQuery.of(context).size.width / 5,
                    // ),
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

  String path;

  List<String> complete = [];
  List<dynamic> indexes = [];

  CreateDialogueOrder(this.text, this.path, this.indexes);

  @override
  _CreateDialogueOrderState createState() => _CreateDialogueOrderState();
}

class _CreateDialogueOrderState extends State<CreateDialogueOrder> {
  bool areListsEqual(var list1, var list2) {
    // check if both are lists
    if (!(list1 is List && list2 is List)
        // check if both have same length
        ||
        list1.length != list2.length) {
      return false;
    }

    // check if elements are equal
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) {
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

    isBtnDownClass().isBtnDown = false;
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CreateDialogueOrder oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    createText();
  }

  void isCorrect(int index) {
    print("COMPLETE  ${widget.complete}");
    print("TEXT ${widget.text}");
    if (!isBtnDownClass().isBtnDown) {
      if (areListsEqual(widget.text, widget.complete)) {
        correct(context, "", widget.path);
        print("PATH: ${widget.path}");
        player.setAsset('assets/audio/correct.mp3');
        player.play();
      } else {
        print(widget.complete);
        inCorrect(context, "");
        player.setAsset('assets/audio/wrong.mp3');
        player.play();
      }
    }
  }

  createText() {

    for (int i = 0; i < widget.text.length; i++){
      widget.complete.add("");
    }

    for (int i = 0; i < widget.text.length; i++) {
      widget.complete[widget.indexes[i] - 1] = widget.text[i];
      print("\nRESULT\n");
      print(widget.text);
      print(widget.complete);
    }
  }

  void reorderData(int oldindex, int newindex) {
    setState(() {
      if (newindex > oldindex) {
        newindex -= 1;
      }
      final items = widget.text.removeAt(oldindex);
      widget.text.insert(newindex, items);
    });
    print(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return ShowUpAnimation(
      direction: Direction.horizontal,
      curve: Curves.bounceIn,
      offset: 0.5,
      delayStart: Duration(seconds: 0),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            buildTitle("Verilenleri Kenarlarından Tutup Sürükleyerek Sıralayın"),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: ReorderableListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  buildDefaultDragHandles: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.blueGrey,
                      key: ValueKey(index),
                      elevation: 2,
                      child: ListTile(
                        title: Text(
                          widget.text[index],
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: ReorderableDragStartListener(
                          index: index,
                          child: const Icon(Icons.drag_handle),
                        ),
                      ),
                    );
                  },
                  itemCount: widget.text.length,
                  onReorder: reorderData,
                ),
              ),
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

            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 2 / 3,
                height: MediaQuery.of(context).size.width / 8,
                child: ElevatedButton(
                  child: const Text(
                    "Kontrol Et",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    primary: Color(0xffff7548),
                  ),
                  onPressed: () {
                    isCorrect(0);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//-------------- FIND ANSWER FROM IMAGE ----------------

class CreateAnswerFromImage extends StatefulWidget {
  int correct_answer_index;
  var answers = [];
  String complete = '';
  var img;
  String path;

  CreateAnswerFromImage(this.correct_answer_index, this.answers, this.img, this.path);

  @override
  _CreateAnswerFromImageState createState() => _CreateAnswerFromImageState();
}

class _CreateAnswerFromImageState extends State<CreateAnswerFromImage> {

  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();

    isBtnDownClass().isBtnDown = false;
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void isCorrect(int index) {
    if (!isBtnDownClass().isBtnDown) {
      if (widget.correct_answer_index == index) {
        correct(context, widget.answers[widget.correct_answer_index], widget.path);
        player.setAsset('assets/audio/correct.mp3');
        player.play();
      } else {
        inCorrect(context, widget.answers[widget.correct_answer_index]);
        player.setAsset('assets/audio/wrong.mp3');
        player.play();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShowUpAnimation(
      direction: Direction.horizontal,
      curve: Curves.bounceIn,
      offset: 0.5,
      delayStart: Duration(seconds: 0),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildTitle("Resim ile Cevabı Eşleştir"),
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
                          height:
                              MediaQuery.of(context).size.width * 2 / 3 > 300
                                  ? 300
                                  : MediaQuery.of(context).size.width * 2 / 3,
                          width: MediaQuery.of(context).size.width * 2 / 3 > 300
                              ? 300
                              : MediaQuery.of(context).size.width * 2 / 3,
                        ),
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.answers.length,
                            itemBuilder: (BuildContext context, int index){
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3.0),
                                child: SizedBox(
                                  child: ElevatedButton(
                                    onPressed: () => isCorrect(index),
                                    child: Text(widget.answers[index],
                                        style: TextStyle(fontSize: 18)),
                                    style: ElevatedButton.styleFrom(
                                      shadowColor: Colors.transparent,
                                      primary: Color(0xff76519C),
                                    ),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width / 3.5,
                                ),
                              );
                            },
                          ),
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

//----------------- ANSWER FROM TEXT ----------

class CreateAnswerFromText extends StatefulWidget {
  int correct_answer_index;
  var answers = [];
  String complete = '';
  String text;
  String path;

  CreateAnswerFromText(this.correct_answer_index, this.answers, this.text, this.path);

  @override
  _CreateAnswerFromTextState createState() => _CreateAnswerFromTextState();
}

class _CreateAnswerFromTextState extends State<CreateAnswerFromText> {

  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();

    isBtnDownClass().isBtnDown = false;
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void isCorrect(int index) {
    if (!isBtnDownClass().isBtnDown) {
      if (widget.correct_answer_index == index) {
        correct(context, widget.answers[widget.correct_answer_index], widget.path);
        player.setAsset('assets/audio/correct.mp3');
        player.play();
      } else {
        inCorrect(context, widget.answers[widget.correct_answer_index]);
        player.setAsset('assets/audio/wrong.mp3');
        player.play();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShowUpAnimation(
      direction: Direction.horizontal,
      curve: Curves.bounceIn,
      offset: 0.5,
      delayStart: Duration(seconds: 0),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildTitle("Soruya Cevap Ver"),

            Align(
              alignment: Alignment.center,
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.answers.length,
                      itemBuilder: (BuildContext context, int index){
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: SizedBox(
                            child: ElevatedButton(
                              onPressed: () => isCorrect(index),
                              child: Text(widget.answers[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18)),
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                primary: Color(0xff76519C),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width / 3.5,
                          ),
                        );
                      },
                    ),

                    // SizedBox(
                    //   child: ElevatedButton(
                    //     onPressed: () => isCorrect(0),
                    //     child: Text(widget.answers[0],
                    //         style: TextStyle(fontSize: 18)),
                    //     style: ElevatedButton.styleFrom(
                    //       shadowColor: Colors.transparent,
                    //       primary: Color(0xff76519C),
                    //     ),
                    //   ),
                    //   width: MediaQuery.of(context).size.width,
                    //   height: MediaQuery.of(context).size.width / 5,
                    // ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // SizedBox(
                    //   child: ElevatedButton(
                    //     onPressed: () => isCorrect(1),
                    //     child: Text(widget.answers[1],
                    //         style: TextStyle(fontSize: 18)),
                    //     style: ElevatedButton.styleFrom(
                    //       shadowColor: Colors.transparent,
                    //       primary: Color(0xff76519C),
                    //     ),
                    //   ),
                    //   width: MediaQuery.of(context).size.width,
                    //   height: MediaQuery.of(context).size.width / 5,
                    // ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // SizedBox(
                    //   child: ElevatedButton(
                    //     onPressed: () => isCorrect(2),
                    //     child: Text(widget.answers[2],
                    //         style: TextStyle(fontSize: 18)),
                    //     style: ElevatedButton.styleFrom(
                    //       shadowColor: Colors.transparent,
                    //       primary: Color(0xff76519C),
                    //     ),
                    //   ),
                    //   width: MediaQuery.of(context).size.width,
                    //   height: MediaQuery.of(context).size.width / 5,
                    // ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // SizedBox(
                    //   child: ElevatedButton(
                    //     onPressed: () => isCorrect(3),
                    //     child: Text(widget.answers[3],
                    //         style: TextStyle(fontSize: 18)),
                    //     style: ElevatedButton.styleFrom(
                    //       shadowColor: Colors.transparent,
                    //       primary: Color(0xff76519C),
                    //     ),
                    //   ),
                    //   width: MediaQuery.of(context).size.width,
                    //   height: MediaQuery.of(context).size.width / 5,
                    // ),
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

  var _selected = null;

  CreateAudioMatch(
      this.pathsToPlay, this.text, this.correct_answer_index, this.complete);

  @override
  _CreateAudioMatchState createState() => _CreateAudioMatchState();
}

class _CreateAudioMatchState extends State<CreateAudioMatch> {
  String path = '';


  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();

    isBtnDownClass().isBtnDown = false;
  }

  @override
  void didUpdateWidget(covariant CreateAudioMatch oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void isCorrect(int index) {
    if (!isBtnDownClass().isBtnDown) {
      if (widget.correct_answer_index == index) {
        correct(context, widget.complete, widget.pathsToPlay[widget.correct_answer_index]);
        player.setAsset('assets/audio/correct.mp3');
        player.play();
      } else {
        inCorrect(context, widget.complete);
        player.setAsset('assets/audio/wrong.mp3');
        player.play();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShowUpAnimation(
      direction: Direction.horizontal,
      curve: Curves.bounceIn,
      offset: 0.5,
      delayStart: const Duration(seconds: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTitle("Ses ile Metni Eşleştir"),

          Expanded(
            child: Column(
              children: [

                SizedBox(height: 80,),

                Text(
                  widget.text,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),

                Expanded(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Color(0xffff7548),
                              child: IconButton(
                                iconSize: 60,
                                icon: const Icon(CupertinoIcons.speaker_2_fill),
                                onPressed: () async {
                                  await player.setAsset(widget.pathsToPlay[0]);
                                  widget._selected = 0;
                                  player.play();
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Color(0xffff7548),
                              child: IconButton(
                                iconSize: 60,
                                icon: const Icon(CupertinoIcons.speaker_2_fill, color: Colors.black,),
                                onPressed: () async {
                                  await player.setAsset(widget.pathsToPlay[1]);
                                  widget._selected = 1;
                                  player.play();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 2 / 3,
              height: MediaQuery.of(context).size.width / 8,
              child: ElevatedButton(
                child: const Text(
                  "Kontrol Et",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  primary: Color(0xffff7548),
                ),
                onPressed: () {
                  isCorrect(widget._selected);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------Drag and Drop Text -------------

class CreateDragText extends StatefulWidget {

  int correct_total = 0;

  var correct_answer_index;

  List<dynamic> answers = [];

  CreateDragText(this.answers);

  @override
  _CreateDragTextState createState() => _CreateDragTextState();
}

class _CreateDragTextState extends State<CreateDragText> {
  var answerList;
  String path = '';
  var _selected;





  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();

    answerList = (widget.answers.toList()..shuffle());

    isBtnDownClass().isBtnDown = false;
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShowUpAnimation(
      direction: Direction.horizontal,
      curve: Curves.bounceIn,
      offset: 0.5,
      delayStart: const Duration(seconds: 0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Eşleştir",
              style: TextStyle(
                  color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.answers.length,
                    itemBuilder: (BuildContext context, int index) {

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Draggable(
                              childWhenDragging: SizedBox(
                                width: MediaQuery.of(context).size.width * 3 / 8,
                                //height: MediaQuery.of(context).size.width / 6,
                              ),

                              data: widget.answers[index][1],

                              feedback: SizedBox(
                                width: MediaQuery.of(context).size.width * 3 / 8,
                                //height: MediaQuery.of(context).size.width / 6,
                                child: Card(
                                  color: Color(0xffff7548),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(widget.answers[index][0], textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Color(0xffefefef),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 3 / 8,
                                //height: MediaQuery.of(context).size.width / 6,
                                child: Card(
                                  color: Color(0xffff7548),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text(widget.answers[index][0], textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Color(0xffefefef),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),)),
                                  ),
                                ),
                              ),
                            ),

                            DragTarget<String>(
                              builder: (
                                  BuildContext context,
                                  List<dynamic> accepted,
                                  List<dynamic> rejected,
                                  ){
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width * 3 / 8,
                                  //height: MediaQuery.of(context).size.width / 6,
                                  child: Card(
                                    color: Color(0xff41704F),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(answerList[index][1], textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Color(0xffefefef),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              onAccept: (String txt) {
                                if(txt == answerList[index][1]){
                                  print("DOĞRU");
                                  widget.correct_total++;

                                  print("WIDGET: ${widget.answers}");
                                  print("SHUFFLED: ${answerList}");

                                  setState(() {
                                    widget.answers.remove(answerList[index]);
                                    answerList.removeAt(index);
                                  });

                                  if(0 == widget.answers.length){
                                    player.setAsset('assets/audio/correct.mp3');
                                    player.play();
                                    correct(context, "", "");
                                  }
                                }
                                else{

                                  player.setAsset('assets/audio/wrong.mp3');
                                  player.play();

                                  inCorrect(context, "");
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------- Drag and Drop Image ---------------

class CreateDragImage extends StatefulWidget {

  int correct_total = 0;

  var correct_answer_index;

  List<dynamic> answers;

  CreateDragImage(this.answers);

  @override
  _CreateDragImageState createState() => _CreateDragImageState();
}

class _CreateDragImageState extends State<CreateDragImage> {
  var answerList;
  String path = '';
  var _selected;

  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();

    answerList = (widget.answers.toList()..shuffle());

    isBtnDownClass().isBtnDown = false;
  }

  @override
  void didUpdateWidget(covariant CreateDragImage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    answerList = (widget.answers.toList()..shuffle());

    print(" ANSWER LIST:  ${answerList}");
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShowUpAnimation(
      direction: Direction.horizontal,
      curve: Curves.bounceIn,
      offset: 1,
      delayStart: Duration(seconds: 0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Eşleştir",
              style: TextStyle(
                  color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.answers.length,
                    itemBuilder: (BuildContext context, int index) {

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Draggable(
                              childWhenDragging: SizedBox(
                                width: MediaQuery.of(context).size.height / 6,
                                height: MediaQuery.of(context).size.width / 6,
                                child: const Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                  ),
                                ),
                              ),

                              data: widget.answers[index][1],

                              feedback: SizedBox(
                                width: MediaQuery.of(context).size.height / 6,
                                height: MediaQuery.of(context).size.width / 6,
                                child: Card(
                                  color: Color(0xffff7548),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(widget.answers[index][0], textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Color(0xffefefef),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              child: SizedBox(
                                width: MediaQuery.of(context).size.height / 6,
                                height: MediaQuery.of(context).size.width / 6,
                                child: Card(
                                  color: Color(0xffff7548),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text(widget.answers[index][0], textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Color(0xffefefef),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),)),
                                  ),
                                ),
                              ),
                            ),

                            DragTarget<String>(
                              builder: (
                                  BuildContext context,
                                  List<dynamic> accepted,
                                  List<dynamic> rejected,
                                  ){
                                return SizedBox(
                                  width: MediaQuery.of(context).size.height / 7,
                                  //height: MediaQuery.of(context).size.width / 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Image.asset(
                                          answerList[index][1],
                                      )
                                    ),
                                  ),
                                );
                              },
                              onAccept: (String txt) {
                                if(txt == answerList[index][1]){
                                  print("DOĞRU");
                                  widget.correct_total++;

                                  setState(() {
                                    widget.answers.remove(answerList[index]);
                                    answerList.removeAt(index);
                                  });

                                  if(0 == widget.answers.length){
                                    player.setAsset('assets/audio/correct.mp3');
                                    player.play();

                                    correct(context, "", "");
                                  }

                                }
                                else{
                                  player.setAsset('assets/audio/wrong.mp3');
                                  player.play();

                                  inCorrect(context, "");
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Go to next page

void nextPage() {
  LessonService _service = LessonService();
  page_index.value++;
  page_index.notifyListeners();
  print(page_index.value);
}

void previousPage() {
  LessonService _service = LessonService();
  page_index.value--;
  page_index.notifyListeners();
  print(page_index.value);
}

ScaffoldMessengerState snackBarState = ScaffoldMessengerState();

class isBtnDownClass {
  bool isBtnDown = false;
}

// Correct

void correct(BuildContext context, String complete, String path) {

  ScaffoldMessenger.of(context).clearSnackBars();

  Future.delayed(Duration.zero, () {
    if (!isBtnDownClass().isBtnDown) {
      isBtnDownClass().isBtnDown = true;
      final snackBar = SnackBar(
        duration: const Duration(days: 1),
        dismissDirection: DismissDirection.none,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      const Text(
                        'Excellent!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        complete,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        child: const Text(
                          "DEVAM ET",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          isBtnDownClass().isBtnDown = false;
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          nextPage();
                        },
                      ),
                    ],
                  ),
                ),
                Align(alignment: Alignment.bottomRight, child: Image.asset("assets/images/qwe.gif", width: 100, height: 100,)),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.fixed,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  });
}

// Not Correct

void inCorrect(BuildContext context, complete) {

  ScaffoldMessenger.of(context).clearSnackBars();

  Future.delayed(Duration.zero, () {
    if (!isBtnDownClass().isBtnDown) {
      isBtnDownClass().isBtnDown = true;
      final snackBar = SnackBar(
        duration: Duration(days: 1),
        dismissDirection: DismissDirection.none,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      const Text(
                        'Hmm...',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Text(
                      //   complete,
                      //   textAlign: TextAlign.center,
                      //   style: const TextStyle(
                      //     fontSize: 14,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        child: const Text(
                          "BİR DAHA DENE",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          isBtnDownClass().isBtnDown = false;
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    ],
                  ),
                ),
                Align(alignment: Alignment.bottomLeft, child: Image.asset("assets/images/qqqq.gif", width: 100, height: 100,)),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.fixed,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  });
}