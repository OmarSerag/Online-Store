import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store/Constants.dart';
import 'package:store/Screens/users/productInfo.dart';
import 'package:store/Services/Store.dart';
import 'package:store/models/product.dart';

Widget TrousersView() {
  final _store = Store();
  List<Product> _products;
  return StreamBuilder<QuerySnapshot>(
    stream: _store.loadProduct(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        List<Product> products = [];
        for (var doc in snapshot.data.documents) {
          var data = doc.data();
          if (doc[KProductCategory] == KTrousers) {
            products.add(
              Product(
                pId: doc.id,
                pPrice: data[KProductPrice],
                pName: data[KProductName],
                pDescription: data[KProductDescription],
                pLocation: data[KProductLocation],
                pCategory: data[KProductCategory],
              ),
            );
          }
        }
        _products = [...products];
        // products.clear();
        // products = getProductByCategory(Kjackets, _products);

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .8,
          ),
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProductInfo.id,
                    arguments: _products[index]);
              },
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage(_products[index].pLocation),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Opacity(
                      opacity: .6,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _products[index].pName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('\$ ${_products[index].pPrice}')
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          itemCount: products.length,
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}
