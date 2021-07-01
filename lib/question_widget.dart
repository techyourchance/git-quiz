import 'dart:async';

import 'package:flutter/material.dart';
import 'package:git_quiz/question.dart';

import 'answer.dart';

class QuestionWidget extends StatelessWidget {

  final Question question;
  final Function onAnswerSelectedCallback;
  final int selectedAnswerIndex;

  const QuestionWidget({Key? key, required this.question, required this.selectedAnswerIndex, required this.onAnswerSelectedCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${question.body}',
            style: TextStyle(
              color: Colors.grey[850],
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10),
          ...question.answers.asMap().entries.map(
                (entry) => RadioListTile(
              value: entry.key,
              groupValue: selectedAnswerIndex,
              onChanged: _onChanged,
              title: Text(entry.value.body),
            ),
          ).toList(),
        ],
      ),
    );
  }


  void _onChanged(int? clickedIndex) {
    if (clickedIndex == null) {
      return;
    }
    onAnswerSelectedCallback(clickedIndex);
  }
}
