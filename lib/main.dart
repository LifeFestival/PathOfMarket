import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_of_market/api/mainApiService.dart';
import 'package:path_of_market/enums/categoryTypeEnum.dart';
import 'package:path_of_market/models/categoryModels.dart';
import 'package:path_of_market/models/itemsModels.dart';
import 'package:path_of_market/ui/ItemTile.dart';
import 'package:path_of_market/ui/categoryList.dart';
import 'package:path_of_market/ui/currencyTile.dart';
import 'package:path_of_market/utils/localization.dart';

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

  List<Category> _categoryList;

  Category _selectedCategory;

  @override
  void initState() {
    super.initState();
    _categoryList = _makeCategories();
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
        body: Center(child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 500) {
              return Row(
                children: [
                  Expanded(
                    child: CategoryListWidget(
                      _categoryList,
                      onCategoryTap: onCategoryTapCallback,
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: _selectedCategory == null
                        ? Center(child: Text('Select category'))
                        : Center(
                            child:
                                generateItems(_selectedCategory.categoryType)),
                    flex: 2,
                  )
                ],
              );
            } else {
              return CategoryListWidget(_categoryList);
            }
          },
        )));}

  void onCategoryTapCallback(Category category) {

    if (_selectedCategory == category) return;

    setState(() {
      _selectedCategory = category;
    });
  }

  Widget generateItems(CategoryType catType) {

    return FutureBuilder<List<Item>>(
      future: mainApiService.getItemList(catType),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              Item _item = snapshot.data[index];

              if (_item is CurrencyItem) {
                return CurrencyTile(_item);
              } else
                return ItemTile(_item);
            },
            padding: EdgeInsets.symmetric(vertical: 3.0),
          );
        } else if (snapshot.hasError) {
          log(localization.categoryListError +
              ' ' +
              snapshot.error.toString() +
              '\n' +
              snapshot.stackTrace.toString());
          return Text(
              localization.categoryListError + ' ' + snapshot.error.toString());}
        return CircularProgressIndicator();
      },
    );
  }

  List<Category> _makeCategories() {
    return [
      CurrencyCategory(),
      FossilCategory(),
      ScarabCategory(),
      DivinationCardsCategory(),
      OilsCategory(),
      BeastsCategory(),
      PropheciesCategory(),
      IncubatorsCategory()
    ];
  }
}
