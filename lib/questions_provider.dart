
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
          "Command to show information about the current Git repository",
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
          "Command to initialize new local Git repository",
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
          "Command to stage files for commit",
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
          "Command to discard non-staged changes",
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
          "Command to remove changes from staging area",
          [
            Answer("git revert"),
            Answer("git reset --hard"),
            Answer("git checkout"),
            Answer("git reset"),
          ],
          3,
        )
    );
    _questions.add(
        Question(
          "Command to read all configuration options",
          [
            Answer("git config"),
            Answer("git options --list"),
            Answer("git config --list"),
            Answer("git listconfig"),
          ],
          2,
        )
    );
    _questions.add(
        Question(
          "Command to create a global alias",
          [
            Answer("git config --global alias.<name> <command>"),
            Answer("git config --alias <name> <command>"),
            Answer("git config --local alias.<name> <command>"),
            Answer("git alias add <name> <command>"),
          ],
          0,
        )
    );
    _questions.add(
        Question(
          "Command to list all local branches",
          [
            Answer("git branch"),
            Answer("git branch show"),
            Answer("git branch --show"),
            Answer("git branch --local"),
          ],
          0,
        )
    );
    _questions.add(
        Question(
          "Command to create and check out new local branch",
          [
            Answer("git checkout -b <branch>"),
            Answer("git branch <branch>"),
            Answer("git branch add <branch>"),
            Answer("git branch -s <branch>"),
          ],
          0,
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