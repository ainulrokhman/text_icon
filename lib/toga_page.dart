import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';

class Toga extends StatefulWidget {
  final Map<dynamic, dynamic> data;
  Toga({this.data});
  @override
  _TogaState createState() => _TogaState();
}

class _TogaState extends State<Toga> {
  List<dynamic> toga;
  List<dynamic> searchFilter;
  bool firstSearch = true;
  String query = '';
  var etSearch = TextEditingController();
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = Text("Daftar Tanaman");

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
        this._appBarTitle = new Text('Daftar Tanaman');
        firstSearch = true;
        query = "";
        etSearch.clear();
      }
    });
  }

  _TogaState() {
    etSearch.addListener(() {
      setState(() {
        firstSearch = etSearch.text.isEmpty ? true : false;
        query = etSearch.text.isEmpty ? "" : etSearch.text;
      });
    });
  }

  @override
  void initState() {
    toga = new List();
    widget.data.forEach((key, value) {
      toga.add(value);
    });
    toga..sort((a, b) => a['judul'].compareTo(b['judul']));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _appBarTitle,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: _searchIcon,
              onPressed: () {
                _searchPressed();
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: firstSearch ? _createList(toga) : _performSearch(),
          ),
        ));
  }

  Widget _performSearch() {
    searchFilter = new List();
    for (var item in toga) {
      String s = item['judul'].toString().toLowerCase();
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
              tag: item['judul'],
              child: Material(
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Text(item['judul'].toString()),
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
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Tanaman'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                data['judul'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            Text(
              data['latin'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Text(
              data['desk'],
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16),
            ),
            data['img'] != 'NULL'
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Image.network(data['img']),
                  )
                : Container(),
            data['khasiat'] != 'null'
                ? createWidget('KHASIAT', data['khasiat'])
                : Container(),
            data['kandungan'] != 'null'
                ? createWidget('KANDUNGAN', data['kandungan'])
                : Container(),
            data['cara'] != 'null'
                ? createWidget('CARA PENGOBATAN', data['cara'])
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget createWidget(title, text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.symmetric(vertical: 8),
          color: Colors.grey,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
