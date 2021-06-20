import 'answer.dart';

class Question {
  final String body;
  final List<Answer> answers;
  final int correctAnswerIndex;

  Question(this.body, this.answers, this.correctAnswerIndex);
}