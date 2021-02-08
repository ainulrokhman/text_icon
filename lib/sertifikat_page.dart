import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Sertifikat extends StatefulWidget {
  final data;
  Sertifikat({this.data});
  @override
  _SertifikatState createState() => _SertifikatState();
}

class _SertifikatState extends State<Sertifikat> {
  int current = 0;
  var img = new List();
  var text = new List();
  var title = new List();

  @override
  void initState() {
    setState(() {
      widget.data.forEach((key, value) {
        img.add(value['gambar']);
        text.add(value['text']);
        title.add(value['title']);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Prestasi Perusahaan"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.65,
              padding: EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/main_bg.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CarouselSlider.builder(
                      options: CarouselOptions(
                        height: height * 0.65 * 0.75,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        onPageChanged: (index, x) {
                          setState(() {
                            current = index;
                          });
                        },
                      ),
                      itemCount: img.length,
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl: img[index],
                          placeholder: (context, url) => Center(
                            child: Text(
                              "Loading ...",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Text("Failed to load"),
                        );
                      },
                    ),
                  ),
                  AnimatedSmoothIndicator(
                    activeIndex: current,
                    count: img.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Colors.orange,
                      dotColor: Colors.white54,
                      dotWidth: 10,
                      dotHeight: 10,
                    ),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title[current] + "\n",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.green),
                      ),
                      Text(
                        text[current] + "\n",
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 16),
                      ),
                    ]))
          ],
        ),
      ),
    );
  }
}
