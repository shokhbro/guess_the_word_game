class Question {
  final String questionText;
  final List<String> letters;
  final List<String> shuffledLetters;
  final String correctAnswer;

  Question({
    required this.questionText,
    required this.letters,
    required this.shuffledLetters,
    required this.correctAnswer,
  });
}
