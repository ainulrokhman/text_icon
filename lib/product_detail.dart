import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetail extends StatefulWidget {
  final data;
  ProductDetail({this.data});
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List img = new List();
  int current = 0;
  @override
  void initState() {
    setState(() {
      img.add(widget.data['gdpn']);
      img.add(widget.data['gkom']);
      img.add(widget.data['gkhasiat']);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Text(widget.data['judul']),
      ),
      body: Hero(
        tag: widget.data['video'],
        child: Material(
          child: SingleChildScrollView(
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
                      CarouselSlider.builder(
                        options: CarouselOptions(
                          height: height * 0.65 * 0.75,
                          autoPlay: true,
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Text("Failed to load"),
                          );
                        },
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
                          "KHASIAT :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          widget.data['khasiat'] + "\n",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "KOMPOSISI :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          widget.data['komposisi'] + "\n",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "ATURAN PAKAI :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          widget.data['penggunaan'] + "\n",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "KEMASAN :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          widget.data['kemasan'] + "\n",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget w() {
  //   var height = MediaQuery.of(context).size.height;
  //   var width = MediaQuery.of(context).size.width;
  //   return ;
  // }
}
