import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:text_icon/youtube_player.dart';

class TestSlider extends StatefulWidget {
  final data;
  TestSlider({@required this.data});
  @override
  _TestSliderState createState() => _TestSliderState();
}

class _TestSliderState extends State<TestSlider> {
  final dbRef = FirebaseDatabase.instance.reference().child("product");
  var xxx = new List();
  bool first = true;

  void lodData() async {
    dbRef.once().then((DataSnapshot dataSnapshot) {
      widget.data.forEach((k, v) {
        if (v['gdpn'] != "-" && v['video'] != "-") {
          xxx.add(v);
        }
      });
      setState(() {
        first = false;
      });
    });
  }

  @override
  void initState() {
    lodData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.green,
        ),
      ),
      body: CarouselSlider.builder(
        itemCount: xxx.length,
        itemBuilder: (context, i) {
          return FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => YtPlayer(
                    videoId: xxx[i]['video'],
                    child: Container(),
                    title: "",
                  ),
                ),
              );
            },
            child: Container(
              // width: _size.width * 0.9,
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 3),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: first
                  ? Container()
                  : Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Produk Herbal"),
                                Text(xxx[i]['judul'],
                                    maxLines: 1,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(xxx[i]['khasiat'],
                                    maxLines: 3, style: TextStyle()),
                                Container(
                                  width: _size.width * 0.3,
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    gradient: LinearGradient(
                                      colors: [Colors.lime[800], Colors.green],
                                    ),
                                  ),
                                  child: Text(
                                    xxx[i]['bpom'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: Center(
                            child: first
                                ? Text("Loading ....")
                                : CachedNetworkImage(imageUrl: xxx[i]['gdpn']),
                          ),
                        )
                      ],
                    ),
            ),
          );
        },
        options: CarouselOptions(
          height: _size.height * 0.25,
          autoPlay: true,
        ),
      ),
    );
  }
}
