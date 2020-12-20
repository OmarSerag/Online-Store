import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/Constants.dart';
import 'package:store/Screens/signup.dart';
import 'package:store/Screens/users/homepage.dart';
import 'package:store/Services/auth.dart';
import 'package:store/provider/adminMode.dart';
import 'package:store/provider/modelhud.dart';
import 'package:store/widgets/custom_TextField.dart';
import 'package:store/widgets/custom_logo.dart';

import 'admins/adminHome.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _PasswordTextEditingController =
      TextEditingController();

  final _auth = Auth();

  final adminPassword = 'admin1234';

  bool keepMeLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: widget.globalKey,
          child: ListView(
            children: [
              CustomLogo(),
              CustomTextField(
                controller: _emailTextEditingController,
                hintText: 'Enter your email',
                data: Icons.email,
                isObsecure: false,
              ),
              SizedBox(
                height: height * .01,
              ),
              CustomTextField(
                controller: _PasswordTextEditingController,
                hintText: 'Enter your password',
                data: Icons.lock,
                isObsecure: true,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: Checkbox(
                        checkColor: SecondaryColor,
                        activeColor: MainColor,
                        value: keepMeLoggedIn,
                        onChanged: (value) {
                          setState(() {
                            keepMeLoggedIn = value;
                          });
                        },
                      ),
                    ),
                    Text(
                      "Remmber Me",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * .03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) => FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        if (keepMeLoggedIn == true) {
                          keepUserLoggedIn();
                        }
                        _validate(context);
                      },
                      color: Colors.black,
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              SizedBox(
                height: height * .03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don`t have an account ?',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    child: Text(
                      'Signup',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final modelhud = Provider.of<ModelHud>(context, listen: false);
    modelhud.changeisLoading(true);

    if (widget.globalKey.currentState.validate()) {
      widget.globalKey.currentState.save();

      if (_PasswordTextEditingController.text == adminPassword) {
        try {
          await _auth.signIn(_emailTextEditingController.text, adminPassword);
          Navigator.pushNamed(context, AdminHome.id);
        } catch (e) {
          modelhud.changeisLoading(false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
          ));
        }
      } else {
        try {
          await _auth.signIn(_emailTextEditingController.text,
              _PasswordTextEditingController.text);
          Navigator.pushNamed(context, HomePage.id);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
          ));
        }
      }
    }
    modelhud.changeisLoading(false);
  }

  void keepUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(kKeepMeLoggedInIn, keepMeLoggedIn);
  }
}
