import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_of_market/models/itemsModels.dart';
import 'package:path_of_market/widgets/ItemCard.dart';
import 'package:uuid/uuid.dart';

class CurrencyTile extends StatefulWidget {
  final CurrencyItem _item;

  CurrencyTile(this._item);

  @override
  _CurrencyTileState createState() => _CurrencyTileState();
}

class _CurrencyTileState extends State<CurrencyTile> {
  final Uuid uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return _buildTile();
  }

  Widget _buildTile() {
    return ItemCard(widget._item);
  }
}
