import 'package:store/Constants.dart';
import 'package:store/Services/Store.dart';
import 'package:store/models/Order.dart';
import 'package:store/Screens/admins/Order_Details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  static String id = "OrderScreen";
  final Store _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadProducts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text("there is no orders"),
              );
            } else {
              List<Order> orders = [];
              for (var doc in snapshot.data.docChanges) {
                orders.add(Order(
                  adderss: kAddress,
                  totallPrice: doc.doc[kTotalPrice],
                ));
              }
              return ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, OrderDetails.id,
                          arguments: orders[index].decumentID);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * .2,
                      color: SecondaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Total Price = \$${orders[index].totallPrice}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Address is ${orders[index].adderss}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                itemCount: orders.length,
              );
            }
          },
        ));
  }
}