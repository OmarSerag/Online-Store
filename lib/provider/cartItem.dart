import 'package:store/models/product.dart';
import 'package:flutter/cupertino.dart';

class CartItem extends ChangeNotifier {
  List<Product> products = [];

  Future<bool> addProduct(Product product) async{
    await products.add(product);
    notifyListeners();
    return true;
  }
  deleteProduct(Product product){
    products.remove(product);
    notifyListeners();
  }
}