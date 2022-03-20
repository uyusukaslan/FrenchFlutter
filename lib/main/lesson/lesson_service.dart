class LessonService {

  static final LessonService _instance = LessonService._internal();

  // passes the instantiation to the _instance object
  factory LessonService() => _instance;

  //initialize variables in here
  LessonService._internal() {
    _lesson_index = 0;
    _page_index = 0;
  }

  late int _lesson_index;
  late int _page_index;

  //short getter for my variable
  int get lesson_index => _lesson_index;
  int get page_index => _page_index;

  //short setter for my variable
  set lesson_index(int value) => _lesson_index = value;
  set page_index(int value) => _page_index = value;

  void incrementLessonIndex() => _lesson_index++;

  void incrementPageIndex() => _page_index++;
}