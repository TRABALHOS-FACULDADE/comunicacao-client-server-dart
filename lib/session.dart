import 'question.dart';

class Session {
  final int port;
  final String name;
  final List<Question> questions;

  Session({
    required this.port,
    required this.name,
    required this.questions,
  });

  String get roomName => '<Room: $name>';

  bool get allQuestionAnswered => questions.every((q) => q.answered);
}
