import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'debug_manager.dart';

class DebugDrawer extends StatefulWidget {

  final DebugManager _debugManager;

  const DebugDrawer(this._debugManager, {Key? key}) : super(key: key);

  @override
  _DebugDrawerState createState() => _DebugDrawerState();
}

class _DebugDrawerState extends State<DebugDrawer> {

  final maxQuestionsCtrl = TextEditingController();

  var isLimit = true;

  @override
  void initState() {
    super.initState();
    maxQuestionsCtrl.text = widget._debugManager.getMaxQuestions().toString();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(top: 100, left: 20.0, right: 20.0),
      child: Column(
          children: [
            Row(
              children: [
                Text("Max questions:"),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Switch.adaptive(
                    value: widget._debugManager.limitQuestions,
                    onChanged: (newValue) => setState(() {
                      widget._debugManager.limitQuestions = newValue;
                    }),
                  ),
                ),
              ],
            )
          ],
        ),
      );
  }
}
