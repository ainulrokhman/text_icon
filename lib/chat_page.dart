import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Chat extends StatefulWidget {
  final Map<dynamic, dynamic> data;
  Chat({@required this.data});
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<dynamic> konsultan;
  List<dynamic> searchFilter;
  bool firstSearch = true;
  String query = '';
  var etSearch = TextEditingController();
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = FittedBox(
    fit: BoxFit.fill,
    child: new Text('Chat Bersama Konsultan Herbal'),
  );

  _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: etSearch,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Cari...'),
          autofocus: true,
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = FittedBox(
            fit: BoxFit.fill, child: new Text('Chat Bersama Konsultan Herbal'));
        firstSearch = true;
        query = "";
        etSearch.clear();
      }
    });
  }

  _ChatState() {
    etSearch.addListener(() {
      setState(() {
        firstSearch = etSearch.text.isEmpty ? true : false;
        query = etSearch.text.isEmpty ? "" : etSearch.text;
      });
    });
  }
  @override
  void initState() {
    konsultan = new List();
    List<dynamic> dummy = new List();
    List<int> arr = new List();
    widget.data.forEach((key, value) {
      dummy.add(value);
    });

    for (var i = 0; i < 10; i++) {
      random(dummy.length, arr);
    }

    for (var item in arr) {
      konsultan.add(dummy[item]);
    }
    super.initState();
  }

  void random(int size, List i) {
    int rand = Random().nextInt(size);
    if (i.isEmpty) {
      i.add(rand);
    } else {
      if (!i.contains(rand)) {
        i.add(rand);
      } else {
        random(size, i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _appBarTitle,
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: _searchIcon,
            onPressed: () {
              _searchPressed();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: firstSearch ? _createList(konsultan) : _performSearch(),
          ),
        ));
  }

  Widget _performSearch() {
    searchFilter = new List();
    for (var item in konsultan) {
      String s = item['nama'].toString().toLowerCase();
      if (s.contains(query.toLowerCase())) searchFilter.add(item);
    }
    return _createList(searchFilter);
  }

  Widget _createList(List<dynamic> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, i) {
        var item = list[i];
        return Card(
          child: Padding(
            padding: EdgeInsets.all(2),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            item['image'],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['nama'],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text("0${item['wa']}", textAlign: TextAlign.left),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: Colors.orange[900],
                      onPressed: () async => await launch(
                          "https://wa.me/62${item['wa']}?text=Hallo%2C%20konsultan%20herbal%20denature%3f",
                          forceSafariVC: false),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            children: [
                              Text(
                                "Chat",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Sekarang",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
