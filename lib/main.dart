import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_of_market/api/mainApiService.dart';
import 'package:path_of_market/models/categoryModels.dart';
import 'package:path_of_market/ui/categoryList.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

  Future<List<Category>> _categoryList;

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

              return CategoryListWidget(snapshot.data);
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

  void onSuccessLog(List<Category> catList) {
    catList.forEach((element) {
      log(element.categotyType.toString() +
          'items: ' +
          element.itemList.map((e) => e.itemName + ', ').join() +
          '\n');
    });
  }
}
