import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:path_of_market/api/main_api_service.dart';
import 'package:path_of_market/enums/category_type.dart';
import 'package:path_of_market/models/category_models.dart';
import 'package:path_of_market/models/items_models.dart';
import 'package:path_of_market/ui/Item_tile.dart';
import 'package:path_of_market/ui/currency_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItemListWidget extends StatefulWidget {
  static const String routeName = '/itemList';

  final CategoryType _catType;
  final bool _isFullMode;

  ItemListWidget(this._catType, this._isFullMode);

  @override
  _ItemListWidgetState createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  final MainApiService _mainApiService = MainApiService();

  List<Item> _itemList = [];

  Icon _searchIcon = Icon(Icons.search);
  Widget? _titleWidget;

  String _filterString = '';

  @override
  void initState() {
    super.initState();
    _titleWidget = Text(widget._catType.name ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return Scaffold(
        appBar: widget._isFullMode ? _buildAppbar() : null,
        body: FutureBuilder<List<Item>>(
            future: _mainApiService.getItemList(widget._catType),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _itemList = snapshot.data!;
                return Center(child: _buildList());
              } else if (snapshot.hasError) {
                log(localization!.categoryListError +
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
    } else if (_item is RegularItem) {
      return ItemTile(_item);
    } else
      throw Exception('Unknown item type - ${_item.runtimeType}');
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

  PreferredSizeWidget _buildAppbar() {
    if (_searchIcon.icon == Icons.search) {
      _titleWidget = Text(widget._catType.name ?? '');
    }

    return AppBar(
      title: _titleWidget,
      centerTitle: true,
      actions: [
        IconButton(
            icon: _searchIcon,
            onPressed: () {
              setState(() {
                if (_searchIcon.icon == Icons.search) {
                  _searchIcon = Icon(Icons.cancel);
                  _titleWidget = TextField(
                    onChanged: (String value) {
                      setFilterString(value);
                    },
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.white30)),
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  );
                } else {
                  setState(() {
                    _filterString = '';
                    _searchIcon = Icon(Icons.search);
                    _titleWidget = Text(widget._catType.name ?? '');
                  });
                }
              });
            }),
      ],
    );
  }

  void setFilterString(String str) {
    setState(() {
      _filterString = str;
    });
  }
}
