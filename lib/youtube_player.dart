import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YtPlayer extends StatefulWidget {
  final videoId, title;
  final Widget child;
  YtPlayer({
    @required this.title,
    @required this.videoId,
    @required this.child,
  });
  @override
  _YtPlayerState createState() => _YtPlayerState();
}

class _YtPlayerState extends State<YtPlayer> {
  YoutubePlayerController _controller;
  bool isFullScreen = false;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: _controller),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: Colors.green,
          ),
          body: ListView(
            children: [
              player,
              widget.child,
            ],
          ),
        );
      },
    );
  }
}
