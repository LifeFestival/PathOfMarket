import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_of_market/models/itemsModels.dart';
import 'package:uuid/uuid.dart';

class ItemTile extends StatefulWidget {
  final CurrencyItem _item;

  ItemTile(this._item);

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final Uuid uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return _buildTile();
  }

  Widget _buildTile() {
    return Card(
      color: Colors.white,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.filter_frames,
              color: Colors.orange,
            ),
            Expanded(child: Text(widget._item.itemName, textAlign: TextAlign.center), flex: 2,)
          ],
        ),
      ),
    );
  }
}
