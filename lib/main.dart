import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:text_icon/chat_page.dart';
import 'package:text_icon/home_page.dart';
import 'package:text_icon/article_page.dart';
import 'package:text_icon/event_page.dart';
import 'package:text_icon/medsos.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';

void main() {
  runApp(new MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ProgressDialog progresDialog;
  final dbRef = FirebaseDatabase.instance.reference();
  int _posisi = 2;
  var _widget;
  bool first = true;

  void database() async {
    dbRef.once().then((DataSnapshot snapshot) => {
          setState(() {
            _widget = new List(5);

            snapshot.value.forEach((k, v) {
              switch (k) {
                case "konsultan":
                  _widget[0] = Chat(data: v);
                  break;
                case "artikel":
                  _widget[1] = Article(data: v);
                  break;
                case "peduli":
                  _widget[3] = Peduli(data: v);
                  _widget[4] = Center(child: Medsos());
                  break;
                default:
                  _widget[2] = HomePage(data: snapshot.value);
                  break;
              }
            });
            first = false;
          }),
        });
  }

  @override
  void initState() {
    database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progresDialog = ProgressDialog(context);
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            backgroundColor: Colors.green,
          ),
          preferredSize: Size.fromHeight(0)),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        child: first
            ? Container(
                child: Center(child: Text("Loading ...")),
              )
            : _widget[_posisi],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[900], Colors.lime],
          ),
        ),
        child: FFNavigationBar(
          theme: FFNavigationBarTheme(
              barBackgroundColor: Colors.green,
              selectedItemBackgroundColor: Colors.white,
              selectedItemIconColor: Colors.green,
              selectedItemLabelColor: Colors.white,
              unselectedItemIconColor: Colors.grey[50],
              unselectedItemLabelColor: Colors.white),
          selectedIndex: _posisi,
          onSelectTab: (index) {
            setState(() {
              _posisi = index;
            });
          },
          items: [
            FFNavigationBarItem(
              iconData: Icons.message,
              label: 'Pesan',
            ),
            FFNavigationBarItem(
              iconData: Icons.article,
              label: 'Artikel',
            ),
            FFNavigationBarItem(
              iconData: Icons.home,
              label: 'Home',
            ),
            FFNavigationBarItem(
              iconData: Icons.event,
              label: 'Event',
            ),
            FFNavigationBarItem(
              iconData: Icons.ad_units,
              label: 'Medsos',
            ),
          ],
        ),
      ),
    );
  }
}
