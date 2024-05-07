class Question {
  final String question;
  final String answer;
  bool answered;

  Question({
    required this.question,
    required this.answer,
    this.answered = false,
  });
}
