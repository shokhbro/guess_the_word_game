import 'package:get/get.dart';
import 'package:guess_the_word_game/model/question.dart';

class GameController extends GetxController {
  var questions = <Question>[];
  RxInt currentQuestionIndex = 0.obs;
  RxString userAnswer = ''.obs;
  RxInt correctAnswersCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadQuestions();
  }

  void _loadQuestions() {
    questions.addAll([
      Question(
        questionText: 'What is the color of the sky?',
        letters: ['B', 'L', 'U', 'E'],
        shuffledLetters: _shuffle(['B', 'L', 'U', 'E']),
        correctAnswer: 'BLUE',
      ),
      Question(
        questionText: 'What is the capital of France?',
        letters: ['P', 'A', 'R', 'I', 'S'],
        shuffledLetters: _shuffle(['P', 'A', 'R', 'I', 'S']),
        correctAnswer: 'PARIS',
      ),
      Question(
        questionText: 'What is the largest planet in our solar system?',
        letters: ['J', 'U', 'P', 'I', 'T', 'E', 'R'],
        shuffledLetters: _shuffle(['J', 'U', 'P', 'I', 'T', 'E', 'R']),
        correctAnswer: 'JUPITER',
      ),
      Question(
        questionText: 'What do you call a baby cat?',
        letters: ['K', 'I', 'T', 'T', 'E', 'N'],
        shuffledLetters: _shuffle(['K', 'I', 'T', 'T', 'E', 'N']),
        correctAnswer: 'KITTEN',
      ),
      Question(
        questionText: 'What is the hardest natural substance on Earth?',
        letters: ['D', 'I', 'A', 'M', 'O', 'N', 'D'],
        shuffledLetters: _shuffle(['D', 'I', 'A', 'M', 'O', 'N', 'D']),
        correctAnswer: 'DIAMOND',
      ),
      Question(
        questionText:
            'What is the name of the main character in "Alice in Wonderland"?',
        letters: ['A', 'L', 'I', 'C', 'E'],
        shuffledLetters: _shuffle(['A', 'L', 'I', 'C', 'E']),
        correctAnswer: 'ALICE',
      ),
      Question(
        questionText: 'Which planet is known as the Red Planet?',
        letters: ['M', 'A', 'R', 'S'],
        shuffledLetters: _shuffle(['M', 'A', 'R', 'S']),
        correctAnswer: 'MARS',
      ),
      Question(
        questionText: 'What is the largest ocean on Earth?',
        letters: ['P', 'A', 'C', 'I', 'F', 'I', 'C'],
        shuffledLetters: _shuffle(['P', 'A', 'C', 'I', 'F', 'I', 'C']),
        correctAnswer: 'PACIFIC',
      ),
      Question(
        questionText: 'What is the chemical symbol for water?',
        letters: ['H', '2', 'O'],
        shuffledLetters: _shuffle(['H', '2', 'O']),
        correctAnswer: 'H2O',
      ),
    ]);
  }

  List<String> _shuffle(List<String> list) {
    list.shuffle();
    return list;
  }

  void checkAnswer() {
    final currentQuestion = questions[currentQuestionIndex.value];
    if (userAnswer.value.toUpperCase() == currentQuestion.correctAnswer) {
      correctAnswersCount.value++;
      Get.defaultDialog(
        title: 'Correct!',
        middleText: 'You guessed correctly!',
        onConfirm: () {
          _nextQuestion();
          Get.back();
        },
      );
    } else {
      Get.defaultDialog(
        title: 'Incorrect!',
        onConfirm: () {
          _nextQuestion();
          Get.back();
        },
      );
    }
  }

  void _nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      userAnswer.value = '';
    } else {
      Get.defaultDialog(
        title: 'Game Over!',
        middleText:
            'You got ${correctAnswersCount.value} out of ${questions.length} correct.',
        onConfirm: () => Get.back(),
      );
    }
  }

  void updateUserAnswer(String letter) {
    if (userAnswer.value.length <
        questions[currentQuestionIndex.value].correctAnswer.length) {
      userAnswer.value += letter;
    }
  }
}
