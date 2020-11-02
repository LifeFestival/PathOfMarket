
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
  static final Image _icon = Image.asset('assets/CurrencyRerollRare.png', width: 50.0, height: 50.0,);

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
  static final Image _icon = Image.asset('assets/Fossil.png', width: 50.0, height: 50.0,);

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
  static final Image _icon = Image.asset('assets/GreaterScarabBreach.png', width: 50.0, height: 50.0,);

  ScarabCategory(this.scarabsList, categoryName) : super(categoryName, CategoryType.scarabs, scarabsList, _icon);

  factory ScarabCategory.fromJson(
      Map<String, dynamic> json, String categoryName,
      {String categoryIconUri}) {
    var itemsList = json['lines'] as List;

    List<RegularItem> scarabsList =
        itemsList.map((e) => RegularItem.fromJson(e)).toList();

    return ScarabCategory(scarabsList, categoryName);
  }
  
}
