import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_of_market/models/category_models.dart';
import 'package:path_of_market/ui/item_list.dart';
import 'package:path_of_market/enums/category_type.dart';
import 'package:uuid/uuid.dart';

class CategoryTile extends StatefulWidget {
  final Category _category;
  final void Function(Category)? onCategoryTap;

  CategoryTile(this._category, { this.onCategoryTap });

  @override
  _CategoryTileState createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    final Uuid uuid = Uuid();

    return ListTile(
      key: Key(uuid.v1()),
      leading: widget._category.icon,
      title: Text(widget._category.categoryType.name ?? ''),
      onTap: () {
        if (widget.onCategoryTap == null) {
          _defaultCategoryTap();
        } else {
          widget.onCategoryTap!(widget._category);
        }
      },
    );
  }

  void _defaultCategoryTap() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ItemListWidget(widget._category.categoryType, true)));
  }
}