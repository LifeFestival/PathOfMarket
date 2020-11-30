import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:path_of_market/enums/categoryTypeEnum.dart';
import 'package:path_of_market/models/itemsModels.dart';

abstract class Category {
  final String categoryName;
  final CategoryType categotyType;

  final List<Item> itemList;

  final Image icon;

  Category(this.categoryName, this.categotyType, this.itemList, this.icon);
}

abstract class Item {
  final String itemName;
  final int count;
  final double value;
  final double changePercent;

  Item(this.itemName, this.count, this.value, this.changePercent);
}

class CurrencyCategory extends Category {
  final List<CurrencyItem> currencyItemsList;
  static final Image _icon = Image.asset(
    'assets/CurrencyRerollRare.png',
    width: 50.0,
    height: 50.0,
  );

  CurrencyCategory(this.currencyItemsList, categoryName)
      : super(categoryName, CategoryType.currency, currencyItemsList, _icon);

  factory CurrencyCategory.fromJson(
      Map<String, dynamic> json, String categoryName,
      {String categoryIconUri}) {
    var itemsList = json['lines'] as List;

    List<CurrencyItem> currencyList =
        itemsList.map((e) => CurrencyItem.fromJson(e)).toList();

    return CurrencyCategory(currencyList, categoryName);
  }
}

class FossilCategory extends Category {
  final List<RegularItem> fossilslist;
  static final Image _icon = Image.asset(
    'assets/Fossil.png',
    width: 50.0,
    height: 50.0,
  );

  FossilCategory(this.fossilslist, categoryName)
      : super(categoryName, CategoryType.fossils, fossilslist, _icon);

  factory FossilCategory.fromJson(
      Map<String, dynamic> json, String categoryName,
      {String categoryIconUri}) {
    var itemsList = json['lines'] as List;

    List<RegularItem> fossilsList =
        itemsList.map((e) => RegularItem.fromJson(e)).toList();

    return FossilCategory(fossilsList, categoryName);
  }
}

class ScarabCategory extends Category {
  final List<RegularItem> scarabsList;
  static final Image _icon = Image.asset(
    'assets/GreaterScarabBreach.png',
    width: 50.0,
    height: 50.0,
  );

  ScarabCategory(this.scarabsList, categoryName)
      : super(categoryName, CategoryType.scarabs, scarabsList, _icon);

  factory ScarabCategory.fromJson(
      Map<String, dynamic> json, String categoryName,
      {String categoryIconUri}) {
    var itemsList = json['lines'] as List;

    List<RegularItem> scarabsList =
        itemsList.map((e) => RegularItem.fromJson(e)).toList();

    return ScarabCategory(scarabsList, categoryName);
  }
}

class DivinationCardsCategory extends Category {
  final List<RegularItem> divinationList;
  static final Image _icon = Image.asset(
    'assets/Divination.png',
    width: 50.0,
    height: 50.0,
  );

  DivinationCardsCategory(this.divinationList, categoryName)
      : super(
            categoryName, CategoryType.divinationCards, divinationList, _icon);

  factory DivinationCardsCategory.fromJson(
      Map<String, dynamic> json, String categoryName,
      {String categoryIconUri}) {
    var itemsList = json['lines'] as List;

    List<RegularItem> divinationList = itemsList.map((e) => RegularItem.fromJson(e)).toList();

    return DivinationCardsCategory(divinationList, categoryName);
  }
}

class OilsCategory extends Category {
  final List<RegularItem> oilList;
  static final Image _icon = Image.asset(
    'assets/OpalescentOil.png',
    width: 50.0,
    height: 50.0,
  );

  OilsCategory(this.oilList, categoryName)
      : super(categoryName, CategoryType.oils, oilList, _icon);

  factory OilsCategory.fromJson(Map<String, dynamic> json, String categoryName,
      {String categoryIconUri}) {
    var itemsList = json['lines'] as List;

    List<RegularItem> oilList = itemsList.map((e) => RegularItem.fromJson(e)).toList();

    return OilsCategory(oilList, categoryName);
  }
}

class BeastsCategory extends Category {
  final List<RegularItem> beastList;
  static final Image _icon = Image.asset(
    'assets/BestiaryOrbFull.png',
    width: 50.0,
    height: 50.0,
  );

  BeastsCategory(this.beastList, categoryName)
      : super(categoryName, CategoryType.beasts, beastList, _icon);

  factory BeastsCategory.fromJson(
      Map<String, dynamic> json, String categoryName,
      {String categoryIconUri}) {
    var itemsList = json['lines'] as List;

    List<RegularItem> beastList = itemsList.map((e) => RegularItem.fromJson(e)).toList();

    return BeastsCategory(beastList, categoryName);
  }
}

class PropheciesCategory extends Category {
  final List<RegularItem> propheciesList;
  static final Image _icon = Image.asset(
    'assets/ProphecyOrbRed.png',
    width: 50.0,
    height: 50.0,
  );

  PropheciesCategory(this.propheciesList, categoryName)
      : super(categoryName, CategoryType.beasts, propheciesList, _icon);

  factory PropheciesCategory.fromJson(
      Map<String, dynamic> json, String categoryName,
      {String categoryIconUri}) {
    var itemsList = json['lines'] as List;

    List<RegularItem> propheciesList = itemsList.map((e) => RegularItem.fromJson(e)).toList();

    return PropheciesCategory(propheciesList, categoryName);
  }
}

class IncubatorsCategory extends Category {
  final List<RegularItem> incubatorsList;
  static final Image _icon = Image.asset(
    'assets/IncubationAbyss.png',
    width: 50.0,
    height: 50.0,
  );

  IncubatorsCategory(this.incubatorsList, categoryName)
      : super(categoryName, CategoryType.beasts, incubatorsList, _icon);

  factory IncubatorsCategory.fromJson(
      Map<String, dynamic> json, String categoryName,
      {String categoryIconUri}) {
    var itemsList = json['lines'] as List;

    List<RegularItem> incubatorsList = itemsList.map((e) => RegularItem.fromJson(e)).toList();

    return IncubatorsCategory(incubatorsList, categoryName);
  }
}
