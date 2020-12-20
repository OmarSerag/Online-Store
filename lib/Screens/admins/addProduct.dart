import 'package:store/models/product.dart';
import 'package:store/widgets/custom_TextField.dart';
import 'package:flutter/material.dart';
import 'package:store/Services/Store.dart';

class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';
  String _name, _price, _description, _category, _imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(
              isObsecure: false,
              hintText: 'Product Name',
              onClick: (value) {
                _name = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              isObsecure: false,
              onClick: (value) {
                _price = value;
              },
              hintText: 'Product Price',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              isObsecure: false,
              onClick: (value) {
                _description = value;
              },
              hintText: 'Product Description',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              isObsecure: false,
              onClick: (value) {
                _category = value;
              },
              hintText: 'Product Category',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              isObsecure: false,
              onClick: (value) {
                _imageLocation = value;
              },
              hintText: 'Product Location',
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                if (_globalKey.currentState.validate()) {
                  _globalKey.currentState.save();

                  _store.addProduct(Product(
                      pName: _name,
                      pPrice: _price,
                      pDescription: _description,
                      pLocation: _imageLocation,
                      pCategory: _category));
                }
              },
              child: Text('Add Product'),
            )
          ],
        ),
      ),
    );
  }
}