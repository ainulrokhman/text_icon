import 'package:flutter/material.dart';
import 'package:text_icon/youtube_player.dart';

class Review extends StatefulWidget {
  final Map<dynamic, dynamic> data;
  Review({this.data});
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  List<dynamic> review;
  @override
  void initState() {
    review = new List();
    widget.data.forEach((key, value) {
      review.add(value);
    });
    review..sort((a, b) => a['nama'].compareTo(b['nama']));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
            itemCount: review.length,
            itemBuilder: (context, i) {
              return Container(
                padding:
                    EdgeInsets.only(top: 8, bottom: 4, right: 10, left: 10),
                child: Hero(
                  tag: review[i]['nama'],
                  child: Material(
                    child: InkWell(
                        onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Detail(
                                  data: review[i],
                                ),
                              ),
                            ),
                        child: Card(
                          elevation: 2,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Container(
                                              child: Row(
                                        children: [
                                          Container(
                                            width: 50.0,
                                            height: 50.0,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  review[i]['image'],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                            padding: EdgeInsets.only(left: 8),
                                            child: Text(
                                              review[i]['nama'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )),
                                        ],
                                      ))),
                                      Expanded(
                                          child: Container(
                                        // color: Colors.green,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Produk: ${review[i]['produk']}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Text(
                                              "Penyakit: ${review[i]['penyakit']}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                                Text(
                                  review[i]['desc'],
                                  maxLines: 3,
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  "... See More",
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
              );
            }),
      ),
    );
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
    var data = widget.data;
    return Hero(
      tag: data['nama'],
      child: Material(
        child: InkWell(
          child: YtPlayer(
            title: data['nama'],
            videoId: data['videoId'],
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          data['image'],
                        ),
                      ),
                    ),
                  ),
                ),
                Text(data['produk']),
                Text(data['penyakit']),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    data['desc'],
                    style: TextStyle(),
                    textAlign: TextAlign.justify,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
