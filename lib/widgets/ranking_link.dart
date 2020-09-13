import 'package:flutter/material.dart';

class RankingLink extends StatelessWidget {
  final VoidCallback onClick;
  final String label;

  RankingLink({this.onClick, this.label});
  @override
  Widget build(_) {
    return GestureDetector(
      onTap: onClick,
      child: Text(
        label,
        style: TextStyle(
          decoration: TextDecoration.underline,
          fontSize: 20,
          color: Color(0xFFcdff9d),
        ),
      ),
    );
  }
}
