import 'dart:async';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:git_quiz/question.dart';

import 'answer.dart';

class QuestionWidget extends StatefulWidget {

  final Question question;
  final Function onAnswerSelectedCallback;
  final int selectedAnswerIndex;

  const QuestionWidget({Key? key, required this.question, required this.selectedAnswerIndex, required this.onAnswerSelectedCallback}) : super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();

}

class _QuestionWidgetState extends State<QuestionWidget> {
  Color _color = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${widget.question.body}',
            style: TextStyle(
              color: Colors.grey[850],
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10),
          ...widget.question.answers.asMap().entries.map(
                  (entry) => AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      color: _getAnswerColor(entry.key),
                      borderRadius: BorderRadius.circular(2)
                    ),
                    child: RadioListTile(
                      value: entry.key,
                      groupValue: widget.selectedAnswerIndex,
                      onChanged: _onChanged,
                      title: Text(
                        entry.value.body,
                        style: GoogleFonts.robotoMono()
                      ),
                    ),
                  )
          ).toList(),
        ],
      ),
    );
  }

  void _onChanged(int? clickedIndex) {
    if (clickedIndex == null) {
      return;
    }
    widget.onAnswerSelectedCallback(clickedIndex);
  }

  Color _getAnswerColor(int answerIndex) {
    if (widget.selectedAnswerIndex >= 0
        && answerIndex == widget.selectedAnswerIndex
        && answerIndex != widget.question.correctAnswerIndex) {
      return Colors.red;
    } else {
      return Colors.transparent;
    }
  }
}
