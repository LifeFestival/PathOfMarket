import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:path_of_market/enums/categoryTypeEnum.dart';
import 'package:path_of_market/models/itemsModels.dart';

abstract class Category {
  final CategoryType categoryType;
  
  final Image icon;

  Category(this.categoryType, this.icon);

}

abstract class Item {
  final String itemName;
  final int count;
  final double value;
  final double changePercent;

  Item(this.itemName, this.count, this.value, this.changePercent);
}

class CurrencyCategory extends Category {
  static final Image _icon = Image.asset(
    'assets/CurrencyRerollRare.png',
    width: 50.0,
    height: 50.0,
  );
  CurrencyCategory() : super(CategoryType.currency, _icon);
}

class FossilCategory extends Category {
  static final Image _icon = Image.asset(
    'assets/Fossil.png',
    width: 50.0,
    height: 50.0,
  );

  FossilCategory() : super(CategoryType.fossils, _icon);

}

class ScarabCategory extends Category {
  static final Image _icon = Image.asset(
    'assets/GreaterScarabBreach.png',
    width: 50.0,
    height: 50.0,
  );

  ScarabCategory() : super(CategoryType.scarabs, _icon);

}

class DivinationCardsCategory extends Category {
  static final Image _icon = Image.asset(
    'assets/Divination.png',
    width: 50.0,
    height: 50.0,
  );

  DivinationCardsCategory() : super(CategoryType.divinationCards, _icon);
}

class OilsCategory extends Category {
  static final Image _icon = Image.asset(
    'assets/OpalescentOil.png',
    width: 50.0,
    height: 50.0,
  );

  OilsCategory() : super(CategoryType.oils, _icon);
}

class BeastsCategory extends Category {
  static final Image _icon = Image.asset(
    'assets/BestiaryOrbFull.png',
    width: 50.0,
    height: 50.0,
  );

  BeastsCategory() : super(CategoryType.beasts, _icon);
}

class PropheciesCategory extends Category {
  static final Image _icon = Image.asset(
    'assets/ProphecyOrbRed.png',
    width: 50.0,
    height: 50.0,
  );

  PropheciesCategory() : super(CategoryType.prophecies, _icon);
}

class IncubatorsCategory extends Category {
  static final Image _icon = Image.asset(
    'assets/IncubationAbyss.png',
    width: 50.0,
    height: 50.0,
  );

  IncubatorsCategory() : super(CategoryType.incubators, _icon);
}

extension Decode on List<dynamic> {
  List<Item> decodeCurrency() => map((e) => CurrencyItem.fromJson(e)).toList();
  List<Item> decodeRegular() => map((e) => RegularItem.fromJson(e)).toList();
}
