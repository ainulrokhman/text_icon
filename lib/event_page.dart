import 'package:flutter/material.dart';
import 'package:text_icon/youtube_player.dart';

class Peduli extends StatefulWidget {
  final Map<dynamic, dynamic> data;
  Peduli({this.data});
  @override
  _PeduliState createState() => _PeduliState();
}

class _PeduliState extends State<Peduli> {
  List<dynamic> peduli;
  @override
  void initState() {
    if (peduli != null) {
      peduli.clear();
    }
    peduli = new List();
    widget.data.forEach((key, value) {
      peduli.add(value);
    });
    peduli..sort((a, b) => a['title'].compareTo(b['title']));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Event Denature"), backgroundColor: Colors.green),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: ListView.builder(
              itemCount: peduli.length,
              itemBuilder: (context, i) {
                var item = peduli[i];
                return Hero(
                    tag: item['videoid'],
                    child: Material(
                      child: InkWell(
                        onTap: () =>
                            // print(item['videoid']),
                            Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Detail(
                              data: item,
                            ),
                          ),
                        ),
                        child: Card(
                          elevation: 5,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                          "https://img.youtube.com/vi/" +
                                              item['videoid'] +
                                              "/0.jpg"),
                                    )),
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(item['title'].toString()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
              },
            ),
          ),
        ));
  }
}

class Detail extends StatefulWidget {
  final data;
  Detail({this.data});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.data['videoid'],
      child: Material(
        child: YtPlayer(
          child: Container(),
          title: "",
          videoId: widget.data['videoid'],
        ),
        // child: YtPlayer(
        //   title: widget.data['title'],
        //   videoId: widget.data['videoid'],
        //   child: Container(),
        // ),
      ),
    );
  }
}
