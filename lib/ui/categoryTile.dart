import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_of_market/models/categoryModels.dart';
import 'package:path_of_market/ui/itemList.dart';
import 'package:uuid/uuid.dart';

class CategoryTile extends StatefulWidget {
  final Category _category;

  CategoryTile(this._category);

  @override
  _CategoryTileState createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
final Uuid uuid = Uuid();

    return ListTile(
      key: Key(uuid.v1()),
      leading: Icon(Icons.list, color: Colors.green,),
      title: Text(widget._category.categoryName),
      onTap: () {
        Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => ItemListWidget(widget._category.itemList)
          ));
      },
    );
  }
}