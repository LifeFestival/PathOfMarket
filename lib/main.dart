import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_of_market/api/mainApiService.dart';
import 'package:path_of_market/models/categoryModels.dart';
import 'package:path_of_market/ui/categoryList.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_of_market/utils/localization.dart';
import 'package:path_of_market/models/itemsModels.dart';
import 'package:path_of_market/ui/ItemTile.dart';
import 'package:path_of_market/ui/currencyTile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Path of Market',
      theme: ThemeData(primarySwatch: Colors.green),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('ru', ''),
      ],
      home: StartScreen(),
    );
  }
}

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  MainApiService mainApiService = MainApiService();

  Future<List<Category>> _categoryList;

  Category _selectedCategory;
  List<Item> _selectedItems;

  @override
  void initState() {
    super.initState();
    _categoryList = mainApiService.getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.categoryList),
        actions: [IconButton(icon: Icon(Icons.more_vert), onPressed: () {})],
      ),
      backgroundColor: Colors.grey[100],
      body: Center(
        child: FutureBuilder<List<Category>>(
          future: _categoryList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              onSuccessLog(snapshot.data);

              return LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 500) {
                    return Row(
                      children: [
                        Expanded(
                          child: CategoryListWidget(snapshot.data, onCategoryTap: onCategoryTapCallback,),
                          flex: 1,
                        ),
                        Expanded(
                          child: _selectedCategory == null
                              ? Center(child: Text('Select category'))
                              : Center(child: generateItems(_selectedCategory.itemList)),
                          flex: 2,
                        )
                      ],
                    );
                  } else {
                    return CategoryListWidget(snapshot.data);
                  }
                },
              );
            } else if (snapshot.hasError) {
              log(localization.categoryListError +
                  ' ' +
                  snapshot.error.toString() +
                  '\n' +
                  snapshot.stackTrace.toString());

              return Text(localization.categoryListError +
                  ' ' +
                  snapshot.error.toString());
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  void onCategoryTapCallback(Category category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void onSuccessLog(List<Category> catList) {
    catList.forEach((element) {
      log(element.categotyType.toString() +
          'items: ' +
          element.itemList.map((e) => e.itemName + ', ').join() +
          '\n');
    });
  }

  Widget generateItems(List<Item> items) {

    _selectedItems = items;

    return ListView.builder(
      itemCount: _selectedItems.length,
      itemBuilder: _generateItemTile,
      padding: EdgeInsets.symmetric(vertical: 3.0),
    );
  }

  Widget _generateItemTile(BuildContext context, int index) {
    Item _item = _selectedItems[index];

    if (_item is CurrencyItem) {
      return CurrencyTile(_item);
    } else
      return ItemTile(_item);
  }
}
