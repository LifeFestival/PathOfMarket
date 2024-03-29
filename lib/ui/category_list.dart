import 'package:flutter/material.dart';
import 'package:path_of_market/models/category_models.dart';
import 'package:path_of_market/ui/category_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryListWidget extends StatefulWidget {

  final List<Category> _categoryList;
  final void Function(Category)? onCategoryTap;

  CategoryListWidget(this._categoryList, { this.onCategoryTap });

  @override
  _CategoryListWidgetState createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  @override
  Widget build(BuildContext context) {

    final localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization!.categoryList),
    leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
    ),
      body: ListView.builder(
        itemCount: widget._categoryList.length,
        padding: EdgeInsets.symmetric(vertical: 3.0),
        itemBuilder: _generateCategoryTiles,
      ),
    );
  }

  Card _generateCategoryTiles(BuildContext context, int index) {

    return Card(
      color: Colors.white,
      child: CategoryTile(widget._categoryList[index], onCategoryTap: widget.onCategoryTap,),
    ) ;
  }

 
}