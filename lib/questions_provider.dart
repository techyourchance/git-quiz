
import 'package:git_quiz/question.dart';

import 'answer.dart';

class QuestionsProvider {

  List<Question> getQuestions() {
    List<Question> questions = [];
    questions.add(
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
    questions.add(
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

    return questions;
  }

}