import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_of_market/models/categoryModels.dart';
import 'package:path_of_market/ui/itemTile.dart';

class ItemListWidget extends StatefulWidget {
  static const String routeName = '/itemList';

  final List<Item> _itemList;

  ItemListWidget(this._itemList);

  @override
  _ItemListWidgetState createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency list'),
      ),
      body: Center(
          child: ListView.builder(
        itemCount: widget._itemList.length,
        itemBuilder: _generateItemTile,
        padding: EdgeInsets.symmetric(vertical: 3.0),
      )),
    );
  }

  ItemTile _generateItemTile(BuildContext context, int index) => ItemTile(widget._itemList[index]);
}
