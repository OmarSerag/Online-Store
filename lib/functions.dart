import 'package:store/Constants.dart';
import 'models/product.dart';

List<Product> getProductByCategory(String kjackets, List<Product> allproducts) {
  List<Product> products = [];
  try {
    for (var product in allproducts) {
      {
        if (product.pCategory == Kjackets) {
          products.add(product);
        }
      }
    }
  } on Error catch (ex) {
    print(ex);
  }

  return products;
}