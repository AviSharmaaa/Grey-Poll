import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/current_user_state.dart';
import 'login_screen/login_screen.dart';
import 'main_screen/main_screen.dart';

enum AuthStatus {
  notLoggedIn,
  loggedIn,
}

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);
    
    String val = await currentUser.onStartUp();
    
    if (val == "success") {
      setState(() {
        _authStatus = AuthStatus.loggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget response;
    switch (_authStatus) {
      case AuthStatus.loggedIn:
        response =  const MainScreen();
        break;
      case AuthStatus.notLoggedIn:
        response = const LoginScreen();
        break;
    }
    return response;
  }
}
