
import 'package:git_quiz/question.dart';
import 'package:git_quiz/questions_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'answer.dart';

class DebugManager {

  final QuestionsProvider _questionsProvider;

  bool limitQuestions = false;

  DebugManager(this._questionsProvider);

  int getMaxQuestions() {
    return limitQuestions ? 2 : _questionsProvider.getNumOfQuestions();
  }

}