import 'package:path_of_market/models/categoryModels.dart';

class CurrencyItem extends Item{
  @override
  final String itemName;

  final int count;
  final double value;
  final double changePercent;

  CurrencyItem(this.itemName, this.count, this.value, this.changePercent) : super(itemName);

  factory CurrencyItem.fromJson(Map<String, dynamic> json) {
    return CurrencyItem(
      json["currencyTypeName"],
      json["receive"]["count"],
      json["receive"]["value"],
      json["receiveSparkLine"]["totalChange"]
    );
  }
}