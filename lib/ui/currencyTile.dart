import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_of_market/models/itemsModels.dart';
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
            Expanded(child: Text(widget._item.itemName, textAlign: TextAlign.center), flex: 2,),
            Padding(
              padding: EdgeInsets.only(),
              child: Column(
              children: [
                Icon(
                Icons.attach_money,
                color: Colors.orange,),
                Text(widget._item.value.toStringAsFixed(1))
              ],
            )),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Column(
              children: [
                Icon(
                  Icons.content_copy,
                  color: Colors.orange,
                ),
                Text(widget._item.count.toString())
              ],
            )),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Column(
              children: [
                Icon(
                  Icons.equalizer,
                  color: widget._item.changePercent >= 0 ? Colors.green : Colors.red,
                ),
                Text(widget._item.changePercent.round().toString())
              ],
            ))
          ],
        ),
      ),
    );
  }
}
