import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:store/Constants.dart';
import 'package:store/provider/adminMode.dart';
import 'package:store/provider/cartItem.dart';
import 'package:store/provider/modelhud.dart';
import 'package:store/Screens/admins/OrderScreen.dart';
import 'package:store/Screens/admins/Order_Details.dart';
import 'package:store/Screens/admins/addProduct.dart';
import 'package:store/Screens/admins/adminHome.dart';
import 'package:store/Screens/admins/editProduct.dart';
import 'package:store/Screens/admins/manageproduct.dart';
import 'package:store/Screens/Login.dart';
import 'package:store/Screens/signup.dart';
import 'package:store/Screens/users/CartScreen.dart';
import 'package:store/Screens/users/homepage.dart';
import 'package:store/Screens/users/productInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Initialize FlutterFire
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          return FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return MaterialApp(
                  home: Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              } else {
                isUserLoggedIn =
                    snapshot.data.getBool(kKeepMeLoggedInIn) ?? false;
                return MultiProvider(
                  providers: [
                    ChangeNotifierProvider<ModelHud>(
                      create: (context) => ModelHud(),
                    ),
                    ChangeNotifierProvider<CartItem>(
                      create: (context) => CartItem(),
                    ),
                    ChangeNotifierProvider<AdminMode>(
                      create: (context) => AdminMode(),
                    ),
                  ],
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    initialRoute:
                        FirebaseAuth.instance.currentUser== null ? LoginScreen.id : HomePage.id,
                    routes: {
                      CartScreen.id: (context) => CartScreen(),
                      ProductInfo.id: (context) => ProductInfo(),
                      EditProduct.id: (context) => EditProduct(),
                      ManageProducts.id: (context) => ManageProducts(),
                      LoginScreen.id: (context) => LoginScreen(),
                      SignupScreen.id: (context) => SignupScreen(),
                      HomePage.id: (context) => HomePage(),
                      AdminHome.id: (context) => AdminHome(),
                      AddProduct.id: (context) => AddProduct(),
                      OrderScreen.id: (context) => OrderScreen(),
                      OrderDetails.id: (context) => OrderDetails(),
                    },
                  ),
                );
              }
            },
          );
        });
  }
}




