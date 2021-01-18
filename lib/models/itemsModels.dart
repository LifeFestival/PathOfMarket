import 'dart:convert';

import 'package:path_of_market/models/categoryModels.dart';

class CurrencyItem extends Item {
  @override
  final String itemName;

  CurrencyItem(this.itemName, int count, double value, double changePercent) : super(itemName, count, value, changePercent);

  factory CurrencyItem.fromJson(Map<String, dynamic> json) {
    return CurrencyItem(
      json["currencyTypeName"],
      json["receive"]["count"],
      json["receive"]["value"],
      json["receiveSparkLine"]["totalChange"]
    );
  }
}

class RegularItem extends Item {
  @override
  final String itemName;


  RegularItem(this.itemName, int count, double value, double changePercent) : super(itemName, count, value, changePercent);

  factory RegularItem.fromJson(Map<String, dynamic> json) {
    return RegularItem(
      json["name"],
      json["count"],
      json["chaosValue"],
      json["sparkline"]["totalChange"]
    );
  }
}