import 'package:store/Constants.dart';
import 'package:store/Screens/admins/OrderScreen.dart';
import 'package:store/Screens/admins/addProduct.dart';
import 'package:store/Screens/admins/manageproduct.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, AddProduct.id);
            },
            child: Text("Add Product"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, ManageProducts.id);
            },
            child: Text("Edit Product"),
          ),
          RaisedButton(
            onPressed: ()
            {
              Navigator.pushNamed(context, OrderScreen.id);
            },
            child: Text("View orders"),
          ),
        ],
      ),
    );
  }
}
