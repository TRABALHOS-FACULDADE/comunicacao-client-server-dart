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
}
