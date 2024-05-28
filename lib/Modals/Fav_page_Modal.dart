import 'package:flutter/material.dart';
import 'package:hostello/Modals/Data.dart';

class Fav_page_models extends ChangeNotifier {
  late productdata _fav_items_list;
  final List<int> _itemIDs = [];
  productdata get favItems => _fav_items_list;
  set productdata(productdata newList) {
    _fav_items_list = newList;
    notifyListeners();
  }

  List<Item> get Items =>
      _itemIDs.map((id) => _fav_items_list.getById(id)).toList();
  void add(Item item) {
    _itemIDs.add(item.id);
    notifyListeners();
  }

  void remove(Item item) {
    _itemIDs.remove(item.id);
    notifyListeners();
  }
}
