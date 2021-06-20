import 'dart:async';

import 'package:flutter/material.dart';
import 'package:git_quiz/question.dart';

import 'answer.dart';

class QuestionWidget extends StatefulWidget {

  final Question question;
  final Function onAnswerSelectedCallback;

  const QuestionWidget({Key? key, required this.question, required this.onAnswerSelectedCallback}) : super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}


class _QuestionWidgetState extends State<QuestionWidget> {

  int selectedIndex = -1;

  _QuestionWidgetState();

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              '${widget.question.body}',
            ),
            ...widget.question.answers.asMap().entries.map(
                  (entry) => RadioListTile(
                    value: entry.key,
                    groupValue: selectedIndex,
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
    setState(() {
      selectedIndex = clickedIndex;
      widget.onAnswerSelectedCallback(clickedIndex);
    });
  }


}
