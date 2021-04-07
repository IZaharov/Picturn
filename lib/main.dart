import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:picturn/Views/AddingPost/adding_post_view.dart';
import 'package:picturn/Views/login_view.dart';
import 'package:picturn/runtime_data.dart';
import 'package:provider/provider.dart';
import 'Models/post.dart';
import 'Models/profile.dart';
import 'ViewModels/post_list_view_model.dart';
import 'ViewModels/profile_view_model.dart';
import 'Views/CustomWidgets/secondary_splash.dart';
import 'Views/Post/post_list_view.dart';
import 'Views/Profile/profile_view.dart';
import 'Views/navigation_bar_view.dart';
import 'Views/onboarding_page.dart';
import 'my_shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  bool isFirstRun = true;
  bool stateUpdated = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  _MyAppState() {
    checkFirstRun();
  }

  void checkFirstRun() {
    MySharedPreferences.instance
        .getBooleanValue(MySharedPreferences.keyIsFirstRun)
        .then(
          (value) => setState(
            () {
              isFirstRun = value;
              stateUpdated = true;
              if (isFirstRun)
                MySharedPreferences.instance
                    .setBooleanValue(MySharedPreferences.keyIsFirstRun, false);
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    RuntimeData.currentOpenProfileViewModel = ProfileViewModel(null);

    // Show error message if initialization failed
    if (_error) {
      return Container(decoration: BoxDecoration(color: Colors.red));
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return SecondarySplash();
    }

    return MaterialApp(
      title: 'Picturn',
      theme: ThemeData(primarySwatch: Colors.blue),
      //home: NavigationBarView(),

       home: LoginPage()

      // home: isFirstRun
      //     ? OnBoardingPage(NavigationBarView(listTab))
      //     : NavigationBarView(listTab),
    );
  }
}
