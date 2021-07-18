import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:git_quiz/question.dart';
import 'package:git_quiz/question_widget.dart';
import 'package:git_quiz/questions_provider.dart';
import 'package:git_quiz/quiz_results.dart';
import 'package:git_quiz/quiz_results_tracker.dart';
import 'package:git_quiz/quiz_results_widget.dart';

import 'answer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    debugPaintSizeEnabled = false; // show widget bounds

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
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final questionsProvider = QuestionsProvider();
  final quizResultsTracker = QuizResultsTracker();

  late int currentQuestionIndex;
  late int selectedAnswerIndex;

  bool quizCompeted = false;

  @override
  void initState() {
    super.initState();
    currentQuestionIndex = 0;
    selectedAnswerIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20)
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (quizCompeted) ...[
              QuizResultsWidget(quizResults: quizResultsTracker.getQuizResults()),
            ] else ...[
              QuestionWidget(
                  question: _getCurrentQuestion(),
                  selectedAnswerIndex: selectedAnswerIndex,
                  onAnswerSelectedCallback: _onAnswerSelected
              ),
            ],
          ],
        ),
      ),
    );
  }

  Question _getCurrentQuestion() {
    return questionsProvider.getQuestionAtIndex(currentQuestionIndex);
  }

  void _onAnswerSelected(int index) {
    setState(() {
      selectedAnswerIndex = index;
      quizResultsTracker.answerAttempt(_getCurrentQuestion());
      if (selectedAnswerIndex == _getCurrentQuestion().correctAnswerIndex) {
        if (currentQuestionIndex < questionsProvider.getNumOfQuestions() - 1) {
          currentQuestionIndex++;
          selectedAnswerIndex = -1;
        } else {
          _quizCompleted();
        }
      }
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

}

