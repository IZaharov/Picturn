import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturn/ViewModels/login_view_model.dart';
import 'navigation_bar_view.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  LoginViewModel loginViewModel = LoginViewModel();

  @override
  void initState() {
    super.initState();
    this.loginViewModel.signOutGoogle();
  }

  void click() {
    this.loginViewModel.signInWithGoogle().then(
          (_) => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NavigationBarView(),
              ),
            ),
          },
        );
  }

  Widget googleLoginButton() {
    return OutlineButton(
      onPressed: this.click,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
      splashColor: Colors.indigo[400],
      borderSide: BorderSide(color: Colors.black),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage('res/images/google_logo.png'), height: 35),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(color: Colors.indigo, fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final bottom = 282.28;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    print(bottom.toString());
    double height = MediaQuery.of(context).size.height;
    double dx = bottom - height / 5;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottom),
          child: Column(
            children: <Widget>[
              Container(
                // decoration: BoxDecoration(
                //     border: Border.all(color: Colors.green, width: 2)),
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, height * 0.2 , 0, height * 0.05),
                child: Text(
                  'Picturn',
                  style: TextStyle(
                    fontFamily: 'RammettoOne',
                    color: Colors.indigo,
                    fontSize: 50,
                  ),
                ),
              ),
              Container(
                // decoration: BoxDecoration(
                //     border: Border.all(color: Colors.red, width: 2)),
                height: height * 0.05,
              ),
              googleLoginButton(),
              Container(
                // decoration: BoxDecoration(
                //     border: Border.all(color: Colors.red, width: 2)),
                height: height * 0.05,
              ),
              Column(
                children: [
                  FractionallySizedBox(
                    alignment: Alignment.center,
                    widthFactor: 0.8,
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Login',
                          isDense: true,
                          contentPadding: EdgeInsets.all(13.5)),
                    ),
                  ),
                  Container(
                    // decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.red, width: 2)),
                    height: height * 0.01,
                  ),
                  FractionallySizedBox(
                    alignment: Alignment.center,
                    widthFactor: 0.8,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          isDense: true,
                          contentPadding: EdgeInsets.all(13.5)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.indigo)),
                    child: Text('      Sign in      '),
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
