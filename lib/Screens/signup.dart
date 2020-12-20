import 'package:store/Constants.dart';
import 'package:store/Screens/users/homepage.dart';
import 'package:store/provider/modelhud.dart';
import 'package:store/widgets/custom_TextField.dart';
import 'package:store/widgets/custom_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:store/Services/auth.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController _nameTextEditingController =
  TextEditingController();
  final TextEditingController _emailTextEditingController =
  TextEditingController();
  final TextEditingController _PasswordTextEditingController =
  TextEditingController();
  final TextEditingController _cPasswordTextEditingController =
  TextEditingController();
  final GlobalKey<FormState> _globalkey = GlobalKey<FormState>();
  static String id = 'SignupScreen';
  String _email, _password;
  final _auth = Auth();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: _globalkey,
          child: ListView(
            children: [
              CustomLogo(),
              CustomTextField(
                controller: _nameTextEditingController,
                data: Icons.person,
                hintText: "Name",
                isObsecure: false,
              ),
              CustomTextField(
                controller: _emailTextEditingController,
                data: Icons.email,
                hintText: "Email",
                isObsecure: false,
              ),
              CustomTextField(
                controller: _PasswordTextEditingController,
                data: Icons.lock,
                hintText: "Password",
                isObsecure: true,
              ),
              CustomTextField(
                controller: _cPasswordTextEditingController,
                data: Icons.lock,
                hintText: "Confirm Paswword",
                isObsecure: true,
              ),
              // SizedBox(
              //   height: height * .1,
              // ),
              // CustomTextField(
              //   onClick: (value) {},
              //   data: Icons.perm_identity,
              //   hintText: 'Enter Your name',
              // ),
              // SizedBox(
              //   height: height * .02,
              // ),
              // CustomTextField(
              //   onClick: (value) {
              //     _email = value;
              //   },
              //   hintText: "Enter Your Email",
              //   data: Icons.email,
              // ),
              // SizedBox(
              //   height: height * .02,
              // ),
              // CustomTextField(
              //   onClick: (value) {
              //     _password = value;
              //   },
              //   hintText: "Enter Your Password",
              //   data: Icons.lock,
              // ),
              SizedBox(
                height: height * .05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) => FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () async {
                        final modelhud =
                            Provider.of<ModelHud>(context, listen: false);
                        modelhud.changeisLoading(true);
                        if (_globalkey.currentState.validate()) {
                          _globalkey.currentState.save();

                          try {
                            await _auth.signUp(_emailTextEditingController.text, _PasswordTextEditingController.text);
                            modelhud.changeisLoading(false);
                            Navigator.pushNamed(context, HomePage.id);
                          } on PlatformException catch (e) {
                            modelhud.changeisLoading(false);
                            print(e.toString());
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.message),
                              ),
                            );
                          }
                        }
                        modelhud.changeisLoading(false);
                      },
                      color: Colors.black,
                      child: Text(
                        'Signup',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              SizedBox(
                height: height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do have an account ?',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login',
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
}
