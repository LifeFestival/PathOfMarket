import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_of_market/models/categoryModels.dart';
import 'package:path_of_market/models/itemsModels.dart';
import 'package:path_of_market/ui/ItemTile.dart';
import 'package:path_of_market/ui/currencyTile.dart';

class ItemListWidget extends StatefulWidget {
  static const String routeName = '/itemList';

  final List<Item> _itemList;

  ItemListWidget(this._itemList);

  @override
  _ItemListWidgetState createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {

  Icon searchIcon = Icon(Icons.search);
  Widget titleWidget = Text('ItemsList'); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleWidget,
        actions: [
            IconButton(icon: searchIcon, onPressed: () {
              setState(() {
              if (this.searchIcon.icon == Icons.search) {
                this.searchIcon = Icon(Icons.cancel);
                this.titleWidget = TextField(
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Colors.white30
                    )
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0
                  ),
                );
              } else {
                this.searchIcon = Icon(Icons.search);
                this.titleWidget = Text('ItemsList');
              }
            });
            }),
          ],
      ),
      body: Center(
          child: ListView.builder(
        itemCount: widget._itemList.length,
        itemBuilder: _generateItemTile,
        padding: EdgeInsets.symmetric(vertical: 3.0),
      )),
    );
  }

  Widget _generateItemTile(BuildContext context, int index) {
    var _item = widget._itemList[index];

    if (_item is CurrencyItem) {
      return CurrencyTile(_item);
    } else return ItemTile(_item);
  }
}
