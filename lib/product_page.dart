import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:text_icon/product_detail.dart';

class Product extends StatefulWidget {
  final data;
  Product({this.data});
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  var _dataProduk = new List();
  var _dataSearch = new List();
  bool firstSearch = true;
  String query = '';
  var etSearch = TextEditingController();
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = Text("Produk Denature");

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
        this._appBarTitle = new Text('Produk Denature');
        firstSearch = true;
        query = "";
        etSearch.clear();
      }
    });
  }

  _ProductState() {
    etSearch.addListener(() {
      setState(() {
        firstSearch = etSearch.text.isEmpty ? true : false;
        query = etSearch.text.isEmpty ? "" : etSearch.text;
      });
    });
  }

  @override
  void initState() {
    setState(() {
      widget.data.forEach((k, v) {
        if (v['gdpn'] != "-" && v['video'] != "-") {
          _dataProduk.add(v);
        }
      });
      _dataProduk..sort((a, b) => a['judul'].compareTo(b['judul']));
      print("object ${_dataProduk.length}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: _appBarTitle,
        actions: [
          IconButton(
            icon: _searchIcon,
            onPressed: () {
              _searchPressed();
            },
          ),
        ],
      ),
      body: firstSearch ? _createList(_dataProduk) : _performSearch(),
    );
  }

  Widget _performSearch() {
    _dataSearch = new List();
    for (var item in _dataProduk) {
      String s = item['judul'].toString().toLowerCase();
      if (s.contains(query.toLowerCase())) _dataSearch.add(item);
    }
    return _createList(_dataSearch);
  }

  Widget _createList(List<dynamic> list) {
    var size = MediaQuery.of(context).size;
    var itemWidth = size.width / 2 * 0.8;
    var itemHeight = 200;
    return GridView.builder(
      itemCount: list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: itemWidth / itemHeight,
      ),
      itemBuilder: (context, i) {
        return Container(
          child: Hero(
            tag: list[i]['video'],
            child: Material(
              child: Container(
                child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductDetail(
                            data: list[i],
                          ))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.white,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: CachedNetworkImage(
                                imageUrl: list[i]['gdpn'],
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Text("Failed to load"),
                              ),
                            ),
                            AutoSizeText(
                              list[i]['judul']
                                  .toString()
                                  .replaceAll("De Nature", ""),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                list[i]['bpom'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[900]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
