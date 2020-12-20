import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/Constants.dart';
import 'package:store/models/product.dart';
import 'package:store/Screens/admins/editProduct.dart';
import 'package:store/widgets/custom_Menu.dart';
import 'package:flutter/material.dart';
import 'package:store/Services/Store.dart';

class ManageProducts extends StatefulWidget {
  static String id = "ManageProducts";

  @override
  _ManageProductsState createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data();
              products.add(Product(
                pId: doc.id,
                pPrice: data[KProductPrice],
                pName: data[KProductName],
                pLocation: data[KProductLocation],
                pCategory: data[KProductCategory],
                pDescription: data[KProductDescription],
              ));
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .8,
              ),
              itemBuilder: (context, index) =>
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: GestureDetector(
                      onTapUp: (details) {
                        double dx = details.globalPosition.dx;
                        double dy = details.globalPosition.dy;
                        double dx2 = MediaQuery
                            .of(context)
                            .size
                            .width - dx;
                        double dy2 = MediaQuery
                            .of(context)
                            .size
                            .width - dy;
                        showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(dx, dy, dx2, dy2
                            ),
                            items: [
                              MyPopupMenuItem(
                                onClick: (){
                                  Navigator.pushNamed(context, EditProduct.id,arguments: products[index]);
                                },
                                child: Text("Edit"),
                              ),
                              MyPopupMenuItem(
                                onClick: (){
                                  _store.deleteProduct(products[index].pId);
                                },
                                child: Text("Delete"),
                              ),
                            ]);
                      },
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image(
                              fit: BoxFit.fill,
                              image: AssetImage(products[index].pLocation),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Opacity(
                              opacity: .5,
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: 60,
                                color: Colors.black,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        products[index].pName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        '\$ ${products[index].pPrice}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
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
      ),
    );
  }
}
