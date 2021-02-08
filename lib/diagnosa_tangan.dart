import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DiagnosaTangan extends StatefulWidget {
  final data, img, title;
  DiagnosaTangan({this.data, this.img, this.title});
  @override
  _DiagnosaTanganState createState() => _DiagnosaTanganState();
}

class _DiagnosaTanganState extends State<DiagnosaTangan> {
  var _tangan = List();
  List<Item> _items = new List();
  @override
  void initState() {
    widget.data.forEach((k, v) {
      _tangan.add(v);
      _items.add(new Item(title: v['title'], webView: v['body']));
    });
    super.initState();
  }

  Widget _buildListPanel() {
    return ExpansionPanelList(
      elevation: 0,
      expansionCallback: (index, isExpanded) {
        setState(() {
          _items[index].isExpand = !isExpanded;
        });
      },
      children: _items.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (context, isExpanded) {
            return ListTile(
              title: Text(item.title),
            );
          },
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Html(data: item.webView),
          ),
          isExpanded: item.isExpand,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: Column(
          children: [
            Image.asset("images/${widget.img}"),
            Flexible(
              child: SingleChildScrollView(
                child: Material(
                  child: _buildListPanel(),
                  elevation: 2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Item {
  String title;
  String webView;
  bool isExpand;

  Item({this.title, this.webView, this.isExpand = false});
}
