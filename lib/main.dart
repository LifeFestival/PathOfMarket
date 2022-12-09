import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_of_market/api/main_api_service.dart';
import 'package:path_of_market/models/category_models.dart';
import 'package:path_of_market/ui/category_list.dart';
import 'package:path_of_market/ui/item_list.dart';

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

  List<Category> _categoryList = [];
  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _categoryList = _makeCategories();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return Scaffold(
        appBar:
            PreferredSize(child: AppBar(), preferredSize: Size.fromHeight(0)),
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
                        ? Center(child: Text(localization!.selectCategory))
                        : Center(
                            child: ItemListWidget(
                                _selectedCategory!.categoryType, true),
                          ),
                    flex: 2,
                  )
                ],
              );
            } else {
              return CategoryListWidget(_categoryList);
            }
          },
        )));
  }

  void onCategoryTapCallback(Category category) {
    if (_selectedCategory == category) return;

    setState(() {
      _selectedCategory = category;
    });
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
