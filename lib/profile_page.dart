import 'package:flutter/material.dart';
import 'package:text_icon/youtube_player.dart';

class Profile extends StatefulWidget {
  final data;
  Profile({this.data});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return YtPlayer(
      title: "Denature Indonesia",
      videoId: "WSpVXqwCaSM",
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Image.asset(
                    "images/launcher.jpg",
                    width: 75,
                    height: 75,
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        "PT. Denature Indonesia Group",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.green[900],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              widget.data,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
