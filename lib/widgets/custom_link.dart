import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomLink extends StatelessWidget {
  final String url;

  CustomLink({this.url});

  void _open(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(_) {
    return InkWell(
      onTap: () {
        _open(url);
      },
      child: Text(
        url,
        style: TextStyle(
            fontSize: 20,
            color: Color(0xFF639bff),
            decoration: TextDecoration.underline),
      ),
    );
  }
}
