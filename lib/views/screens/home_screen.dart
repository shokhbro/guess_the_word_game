import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guess_the_word_game/controller/game_controller.dart';

class HomeScreen extends StatelessWidget {
  final GameController _gameController = Get.put(GameController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: 800,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_fon.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(
          () {
            final currentQuestion = _gameController
                .questions[_gameController.currentQuestionIndex.value];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(seconds: 2),
                  child: Text(
                    currentQuestion.questionText,
                    key: ValueKey<int>(
                        _gameController.currentQuestionIndex.value),
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                _buildAnswerBoxes(currentQuestion.correctAnswer),
                const SizedBox(height: 20),
                _buildLetterButtons(currentQuestion.shuffledLetters),
                const SizedBox(height: 50),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _gameController.checkAnswer,
                    child: const Icon(Icons.check),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAnswerBoxes(String correctAnswer) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        correctAnswer.length,
        (index) => Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Center(
            child: Text(
              _gameController.userAnswer.value.length > index
                  ? _gameController.userAnswer.value[index]
                  : '',
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLetterButtons(List<String> letters) {
    return Wrap(
      spacing: 10,
      children: letters.map((letter) {
        return ElevatedButton(
          onPressed: () => _gameController.updateUserAnswer(letter),
          child: Text(letter),
        );
      }).toList(),
    );
  }
}
