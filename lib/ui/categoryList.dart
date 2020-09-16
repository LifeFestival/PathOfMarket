import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_of_market/models/categoryModels.dart';
import 'package:path_of_market/ui/categoryTile.dart';

class CategoryListWidget extends StatefulWidget {

  final List<Category> _categoryList;

  CategoryListWidget(this._categoryList);

  @override
  _CategoryListWidgetState createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget._categoryList.length,
      padding: EdgeInsets.symmetric(vertical: 3.0),
      itemBuilder: _generateCategoryTiles,
    );
  }

  Card _generateCategoryTiles(BuildContext context, int index) {

    return Card(
      color: Colors.white,
      child: CategoryTile(widget._categoryList[index]),
    ) ;
  }

 
}