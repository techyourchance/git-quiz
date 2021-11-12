import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:git_quiz/debug_manager.dart';
import 'package:git_quiz/question.dart';
import 'package:git_quiz/question_widget.dart';
import 'package:git_quiz/questions_provider.dart';
import 'package:git_quiz/quiz_results.dart';
import 'package:git_quiz/quiz_results_tracker.dart';
import 'package:git_quiz/quiz_results_widget.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:shared_preferences/shared_preferences.dart';

import 'answer.dart';
import 'debug_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //debugPaintSizeEnabled = true; // show widget bounds

    return MaterialApp(
      title: 'Git Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Git Quiz'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  late final questionsProvider;
  late final quizResultsTracker;
  late final DebugManager debugManager;

  late int currentQuestionIndex;
  late int selectedAnswerIndex;

  bool quizCompeted = false;

  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<Offset> _slideOutAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(-1, 0.0),
  ).animate(_animationController);

  late final Animation<Offset> _slideInAnimation = Tween<Offset>(
    begin: const Offset(1, 0.0),
    end: Offset.zero,
  ).animate(_animationController)..addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      _animationController.reset();
      _nextQuestionShown();
    }
  });

  _MyHomePageState() {
    questionsProvider = QuestionsProvider();
    quizResultsTracker = QuizResultsTracker();
    debugManager = DebugManager(questionsProvider);
  }

  @override
  void initState() {
    super.initState();
    resetQuiz();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      endDrawer: Foundation.kDebugMode ? Drawer(child: DebugDrawer(debugManager)) : null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (quizCompeted) ...[
            QuizResultsWidget(
              quizResults: quizResultsTracker.getQuizResults(),
              onRestartClickedCallback: _onRestartClicked,
            ),
          ] else ...[
            Stack(
              children: [
                if (_animationController.isAnimating) ...[
                  SlideTransition(
                    position: _slideOutAnimation,
                    child: QuestionWidget(
                        question: _getCurrentQuestion(),
                        selectedAnswerIndex: selectedAnswerIndex,
                        onAnswerSelectedCallback: _onAnswerSelected
                    ),
                  ),
                  SlideTransition(
                    position: _slideInAnimation,
                    child: QuestionWidget(
                        question: _getNextQuestion(),
                        selectedAnswerIndex: -1,
                        onAnswerSelectedCallback: () => {}
                    ),
                  ),
                ] else ...[
                  QuestionWidget(
                      question: _getCurrentQuestion(),
                      selectedAnswerIndex: selectedAnswerIndex,
                      onAnswerSelectedCallback: _onAnswerSelected
                  )
                ]
              ],
            )
          ],
        ],
      ),
    );
  }

  Question _getCurrentQuestion() {
    return questionsProvider.getQuestionAtIndex(currentQuestionIndex);
  }

  Question _getNextQuestion() {
    return questionsProvider.getQuestionAtIndex(currentQuestionIndex + 1);
  }

  int _getLastQuestionIndex() {
    if (debugManager.limitQuestions) {
      return debugManager.getMaxQuestions() - 1;
    } else {
      return questionsProvider.getNumOfQuestions() - 1;
    }
  }

  void _onAnswerSelected(int index) {
    setState(() {
      selectedAnswerIndex = index;
      quizResultsTracker.answerAttempt(_getCurrentQuestion());
      if (selectedAnswerIndex == _getCurrentQuestion().correctAnswerIndex) {
        var lastQuestionIndex = _getLastQuestionIndex();
        if (currentQuestionIndex < lastQuestionIndex) {
          _animationController.forward();
        } else {
          _quizCompleted();
        }
      }
    });
  }

  void _nextQuestionShown() {
    setState(() {
      currentQuestionIndex++;
      selectedAnswerIndex = -1;
    });
  }

  void _quizCompleted() {
    setState(() {
      quizCompeted = true;
    });
  }

  void _showSnackBar(String text) {
    final snackBar = SnackBar(duration: Duration(milliseconds: 500), content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onRestartClicked() {
    setState(() {
      //_showSnackBar("restart");
      resetQuiz();
    });
  }

  void resetQuiz() {
    quizResultsTracker.reset();
    currentQuestionIndex = 0;
    selectedAnswerIndex = -1;
    quizCompeted = false;
  }

}

