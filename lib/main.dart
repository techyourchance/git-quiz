import 'package:flutter/material.dart';
import 'package:git_quiz/question.dart';
import 'package:git_quiz/question_widget.dart';

import 'answer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Git Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Git Quiz Home Page'),
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

  final question = Question(
      "Command to create new Git repo?",
      [Answer("git commit"), Answer("git status"), Answer("git init"), Answer("git add")],
      2
  );

  var selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20)
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QuestionWidget(question: question, onAnswerSelectedCallback: _onAnswerSelected),
            ElevatedButton(
              style: style,
              onPressed: _onCheckAnswerClicked,
              child: const Text('Check answer'),
            ),
          ],
        ),
      ),
    );
  }

  void _onAnswerSelected(int index) {
    selectedIndex = index;
  }

  void _onCheckAnswerClicked() {
    if (selectedIndex == question.correctAnswerIndex) {
      _showSnackBar("Correct");
    } else {
      _showSnackBar("Incorrect");
    }
  }

  void _showSnackBar(String text) {
    final snackBar = SnackBar(duration: Duration(milliseconds: 500), content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
