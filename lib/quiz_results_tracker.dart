
import 'package:git_quiz/question.dart';
import 'package:git_quiz/quiz_results.dart';

import 'answer.dart';

class QuizResultsTracker {

  final Map<Question, _QuestionResult> _questionsResults = Map();

  void reset() {
    _questionsResults.clear();
  }

  void answerAttempt(Question question) {
    _questionsResults.update(
      question,
      (existing) => _QuestionResult(question, existing.attempts + 1),
      ifAbsent: () =>_QuestionResult(question, 1),
    );
  }

  QuizResults getQuizResults() {
    var totalQuestions = _questionsResults.length;

    var score = 0.0;
    _questionsResults.values.forEach((questionResult) {
      if (questionResult.attempts == 1) {
        score += 1;
      } else if (questionResult.attempts == 2) {
        score += 0.5;
      }
    });
    var normalizedScore = (100.0 / totalQuestions) * score;

    return QuizResults(_questionsResults.length, normalizedScore.round());
  }

}

class _QuestionResult {
  final Question question;
  final int attempts;

  _QuestionResult(this.question, this.attempts);
}