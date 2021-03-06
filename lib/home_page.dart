import 'package:flutter/material.dart';
import 'package:text_icon/profile_page.dart';
import 'package:text_icon/product_page.dart';
import 'package:text_icon/diagnosa_page.dart';
import 'package:text_icon/review_page.dart';
import 'package:text_icon/sertifikat_page.dart';
import 'package:text_icon/test_slider.dart';
import 'package:text_icon/toga_page.dart';

class HomePage extends StatefulWidget {
  final data;
  HomePage({this.data});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _product, _profile, _sertifikat, _diagnosa, _review, _toga;

  _database() {
    widget.data.forEach((key, value) {
      setState(() {
        switch (key) {
          case "product":
            _product = value;
            break;
          case "profile":
            _profile = value;
            break;
          case "sertifikat":
            _sertifikat = value;
            break;
          case "diagnosa":
            _diagnosa = value;
            break;
          case "review":
            _review = value;
            break;
          case "toga":
            _toga = value;
            break;
          default:
            break;
        }
      });
    });
  }

  @override
  void initState() {
    _database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: new Column(
        children: [
          Container(
            child: Image.asset(
              "images/header_main.jpg",
            ),
          ),
          Flexible(
            child: Column(
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    child: TestSlider(
                      data: _product,
                    ),
                  ),
                  flex: 2,
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ButtonMenu(
                                text: "COMPANY\nPROFILE",
                                icon: "ic_profile",
                                widget: Profile(
                                  data: _profile,
                                ),
                              ),
                              ButtonMenu(
                                text: "DIAGNOSA\nPENYAKIT",
                                icon: "ic_diagnosa",
                                widget: Diagnosa(
                                  data: _diagnosa,
                                ),
                              ),
                              ButtonMenu(
                                text: "LIST PRODUK",
                                icon: "ic_produk",
                                widget: Product(
                                  data: _product,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ButtonMenu(
                                text: "PRESTASI\nPERUSAHAAN",
                                icon: "ic_prestasi",
                                widget: Sertifikat(
                                  data: _sertifikat,
                                ),
                              ),
                              ButtonMenu(
                                text: "REVIEW",
                                icon: "ic_review",
                                widget: Review(
                                  data: _review,
                                ),
                              ),
                              ButtonMenu(
                                text: "TOGA",
                                icon: "ic_review",
                                widget: Toga(
                                  data: _toga,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class ButtonMenu extends StatelessWidget {
  ButtonMenu({this.text, this.icon, this.widget});
  final String text;
  final String icon;
  final widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
      child: RaisedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return widget;
          }));
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green[900], Colors.lime],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("images/$icon.jpg"),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
