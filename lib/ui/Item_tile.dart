import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_of_market/models/items_models.dart';
import 'package:path_of_market/widgets/Item_card.dart';

class ItemTile extends StatefulWidget {

  final RegularItem _item;

  ItemTile(this._item);

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    return _buildTile();
  }

  Widget _buildTile() {
    return ItemCard(widget._item);
  }
}