import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_of_market/api/mainApiService.dart';
import 'package:path_of_market/enums/categoryTypeEnum.dart';
import 'package:path_of_market/models/categoryModels.dart';
import 'package:path_of_market/models/itemsModels.dart';
import 'package:path_of_market/ui/ItemTile.dart';
import 'package:path_of_market/ui/currencyTile.dart';
import 'package:path_of_market/utils/localization.dart';

class ItemListWidget extends StatefulWidget {
  static const String routeName = '/itemList';

  final CategoryType _catType;

  ItemListWidget(this._catType);

  @override
  _ItemListWidgetState createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  final MainApiService _mainApiService = MainApiService();

  List<Item> _itemList = [];

  Icon _searchIcon = Icon(Icons.search);
  Widget _titleWidget = Text('ItemsList');

  String _filterString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _titleWidget,
          actions: [
            IconButton(
                icon: _searchIcon,
                onPressed: () {
                  setState(() {
                    if (_searchIcon.icon == Icons.search) {
                      _searchIcon = Icon(Icons.cancel);
                      _titleWidget = TextField(
                        onChanged: (String value) {
                          setState(() {
                            _textSearchCallback(value);
                          });
                        },
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search',
                            hintStyle: TextStyle(color: Colors.white30)),
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      );
                    } else {
                      _filterString = '';
                      _searchIcon = Icon(Icons.search);
                      _titleWidget = Text('ItemsList');
                    }
                  });
                }),
          ],
        ),
        body: FutureBuilder<List<Item>>(
            future: _mainApiService.getItemList(widget._catType),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _itemList = snapshot.data;
                return Center(child: _buildList());
              } else if (snapshot.hasError) {
                log(localization.categoryListError +
                    ' ' +
                    snapshot.error.toString() +
                    '\n' +
                    snapshot.stackTrace.toString());
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  Widget _generateItemTile(BuildContext context, int index) {
    Item _item = _filterItemList()[index];

    if (_item is CurrencyItem) {
      return CurrencyTile(_item);
    } else
      return ItemTile(_item);
  }

  _textSearchCallback(String text) {
    _filterString = text;
  }

  Widget _buildList() {
    List<Item> filteredList = _filterItemList();

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: _generateItemTile,
      padding: EdgeInsets.symmetric(vertical: 3.0),
    );
  }

  List<Item> _filterItemList() {
    if (_filterString == '') return _itemList;

    return _itemList
        .where((item) =>
            item.itemName.toLowerCase().contains(_filterString.toLowerCase()))
        .toList();
  }
}
