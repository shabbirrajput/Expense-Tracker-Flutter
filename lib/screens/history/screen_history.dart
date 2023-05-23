import 'package:flutter/material.dart';

class ScreenHistory extends StatefulWidget {
  const ScreenHistory({Key? key}) : super(key: key);

  @override
  State<ScreenHistory> createState() => _ScreenHistoryState();
}

class _ScreenHistoryState extends State<ScreenHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('History'),
      ),
    );
  }
}
