import 'package:path_of_market/enums/categoryTypeEnum.dart';
import 'package:path_of_market/models/itemsModels.dart';

abstract class Category {
  final String categoryName;
  final CategoryType categotyType;

  final List<Item> itemList;

  final String categoryIconUri;

  
  Category(this.categoryName, this.categotyType, this.itemList, {this.categoryIconUri});
}

abstract class Item {
  final String itemName;

  Item(this.itemName);
}

class CurrencyCategory extends Category {
  final List<CurrencyItem> currencyItemsList;

  CurrencyCategory(this.currencyItemsList, categoryName,
      {String categoryIconUri})
      : super(categoryName, CategoryType.currency, currencyItemsList, categoryIconUri: categoryIconUri);

  factory CurrencyCategory.fromJson(
      Map<String, dynamic> json, String categoryName,
      {String categoryIconUri}) {

        var itemsList = json['lines'] as List;

        List<CurrencyItem> currencyList = itemsList.map((e) => CurrencyItem.fromJson(e)).toList();
        
        return CurrencyCategory(currencyList, categoryName, categoryIconUri: categoryIconUri);
  }
}
