import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/Constants.dart';
import 'package:store/models/product.dart';
import 'dart:async';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addProduct(Product product) {
    _firestore.collection(KProductsCollection).add({
      KProductName: product.pName,
      KProductDescription: product.pDescription,
      KProductLocation: product.pLocation,
      KProductCategory: product.pCategory,
      KProductPrice: product.pPrice,
    });
  }

  Stream<QuerySnapshot> loadProduct() {
    return _firestore.collection(KProductsCollection).snapshots();
  }

  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection(kOrders).snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails(documentId) {
    return _firestore
        .collection(kOrders)
        .doc(documentId)
        .collection(kOrdersDetails)
        .snapshots();
  }

  deleteProduct(documentId) {
    _firestore.collection(KProductsCollection).doc(documentId).delete();
  }

  editProduct(data, documentId) {
    _firestore.collection(KProductsCollection).doc(documentId).update(data);
  }

  storeOrders(data, List<Product> products) {
    var documentRef = _firestore.collection(kOrders).doc();
    documentRef.set(data);
    for (var product in products) {
      documentRef.collection(kOrdersDetails).doc().set({
        KProductName: product.pName,
        KProductPrice: product.pPrice,
        kQuantity: product.pQuantity,
        KProductLocation: product.pLocation,
        KProductCategory: product.pCategory,
      });
    }
  }
}
