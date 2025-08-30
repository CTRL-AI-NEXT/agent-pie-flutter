import 'package:agent_pie/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class QuizTab extends StatelessWidget {
  const QuizTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bottomNavTabAppBar(),
    );
  }
}
