import 'dart:convert';

import 'package:isn_manager/provider/modalHud.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:isn_manager/constant/colors.dart';
import 'package:isn_manager/screens/homeScreen.dart';
import 'package:isn_manager/services/auth.dart';
import 'package:isn_manager/widgets/customTextField.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static String id = '/login';
  final Auth auth = Auth();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  String? _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * .3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'ISN',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 40),
                    ),
                    Text(
                      'Manager',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 40),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              CustomTextField(
                icon: Icons.email,
                hint: 'Email',
                onChange: (value) {
                  _email = value;
                },
              ),
              SizedBox(height: 20),
              CustomTextField(
                icon: Icons.lock,
                hint: 'Password',
                onChange: (value) {
                  _password = value;
                },
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () async {
                      final modalHud =
                          Provider.of<ModalHud>(context, listen: false);
                      modalHud.changeIsLoading(true);

                      if (_globalKey.currentState!.validate()) {
                        _globalKey.currentState!.save();
                        try {
                          final res = await auth.login(_email!, _password!);
                          final data = jsonDecode(res) as Map<String, dynamic>;

                          if (!data.containsKey('msg')) {
                            await Auth.setToken(data['token']);
                            modalHud.changeIsLoading(false);
                            Navigator.pushNamed(context, HomeScreen.id);
                          } else {
                            modalHud.changeIsLoading(false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text(data['msg']),
                              ),
                            );
                          }
                        } catch (e) {
                          modalHud.changeIsLoading(false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text('Error: ${e.toString()}'),
                            ),
                          );
                        }
                      } else {
                        modalHud.changeIsLoading(false);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor),
                    ),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
