import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_of_market/models/categoryModels.dart';
import 'package:uuid/uuid.dart';

class ItemTile extends StatefulWidget {

  final Item _item;

  ItemTile(this._item);

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {

  final Uuid uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(uuid.v1()),
      leading: Icon(Icons.list, color: Colors.green,),
      title: Text(widget._item.itemName),
    );
  }
}