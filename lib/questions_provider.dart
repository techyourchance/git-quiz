
import 'package:git_quiz/question.dart';

import 'answer.dart';

class QuestionsProvider {

  List<Question> _questions = [];

  QuestionsProvider() {
    _initQuestions();
  }

  void _initQuestions() {
    _questions.add(
        Question(
          "Which command initializes new local Git repository?",
          [
            Answer("git create"),
            Answer("git init"),
            Answer("git start"),
            Answer("git initialize"),
          ],
          1,
        )
    );
    _questions.add(
        Question(
          "Which command shows information about the current Git repository?",
          [
            Answer("git stats"),
            Answer("git info"),
            Answer("git status"),
            Answer("git information"),
          ],
          2,
        )
    );
    _questions.add(
        Question(
          "Which command stages files for commit?",
          [
            Answer("git add"),
            Answer("git reset"),
            Answer("git track"),
            Answer("git watch"),
          ],
          0,
        )
    );
    _questions.add(
        Question(
          "Which command discards non-staged changes?",
          [
            Answer("git reset"),
            Answer("git revert"),
            Answer("git checkout"),
            Answer("git drop"),
          ],
          2,
        )
    );
    _questions.add(
        Question(
          "Which command removes changes from staging area?",
          [
            Answer("git revert"),
            Answer("git reset --hard"),
            Answer("git checkout"),
            Answer("git reset"),
          ],
          3,
        )
    );
  }

  int getNumOfQuestions() {
    return _questions.length;
  }

  Question getQuestionAtIndex(int index) {
    return _questions[index];
  }

}