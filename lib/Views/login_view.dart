import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:picturn/ViewModels/login_view_model.dart';
import 'navigation_bar_view.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body());
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
      splashColor: Colors.grey,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage('res/images/google_logo.png'), height: 35),
            Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('Sign in with Google',
                    style: TextStyle(color: Colors.grey, fontSize: 25)))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.center, child: googleLoginButton());
  }
}
