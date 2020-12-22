// import 'dart:html';

import 'package:flutter/material.dart';

class Article extends StatefulWidget {
  final Map<dynamic, dynamic> data;
  Article({this.data});
  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  List<dynamic> artikel;
  List<dynamic> searchFilter;
  bool firstSearch = true;
  String query = '';
  var etSearch = TextEditingController();
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = Text("Daftar Artikel");

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
        this._appBarTitle = new Text('Daftar Artikel');
        firstSearch = true;
        query = "";
        etSearch.clear();
      }
    });
  }

  _ArticleState() {
    etSearch.addListener(() {
      setState(() {
        firstSearch = etSearch.text.isEmpty ? true : false;
        query = etSearch.text.isEmpty ? "" : etSearch.text;
      });
    });
  }

  @override
  void initState() {
    artikel = new List();
    widget.data.forEach((key, value) {
      artikel.add(value);
    });
    artikel..sort((a, b) => a['title'].compareTo(b['title']));
    super.initState();
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
            child: firstSearch ? _createList(artikel) : _performSearch(),
          ),
        ));
  }

  Widget _performSearch() {
    searchFilter = new List();
    for (var item in artikel) {
      String s = item['title'].toString().toLowerCase();
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
            color: Colors.white,
            elevation: 5.0,
            child: Hero(
              tag: item['title'],
              child: Material(
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Text(item['title'].toString()),
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Detail(
                      data: item,
                    ),
                  )),
                ),
              ),
            ));
      },
    );
  }
}

class Detail extends StatelessWidget {
  final data;
  Detail({this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Colors.green,
        ),
        preferredSize: Size.fromHeight(0),
      ),
      body: Container(
          child: Hero(
        tag: data['title'],
        child: Material(
          child: InkWell(
            child: ListView(
              children: [
                Container(child: Image.network(data['gambar'])),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    data['title'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                      fontSize: 22,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Text(
                    data['body'],
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
