import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:online_voting_app/models/current_user.dart';
import 'package:online_voting_app/screens/root_screen.dart';
import 'package:online_voting_app/screens/signup_screen.dart';
import 'package:online_voting_app/widgets/header.dart';
import 'package:provider/provider.dart';

enum LoginType {
  email,
  google,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final double _headerHeight = 250;

  final Key _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _logInUser(
      {@required LoginType? type,
      String? email,
      String? password,
      BuildContext? context}) async {
    CurrentUser currentUser = Provider.of<CurrentUser>(context!, listen: false);

    try {
      final navigator = Navigator.of(context);
      final scaffoldMessenger = ScaffoldMessenger.of(context);

      String? response;

      switch (type) {
        case LoginType.email:
          response = await currentUser.loginInWithEmail(email!, password!);
          break;
        case LoginType.google:
          response = await currentUser.loginInWithGoogle();
          break;
        default:
      }

      if (response == "success") {
        navigator.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const RootScreen(),
          ),
          (route) => false,
        );
      } else {
        scaffoldMessenger.showSnackBar(const SnackBar(
            content: Text('Incorrect Login Info'),
            duration: Duration(seconds: 2)));
      }
    } catch (e) {
      print(e);
    }
  }

  Widget _googleButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        // splashColor: Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        // highlightElevation: 0,
        // borderSide: BorderSide(color: Colors.grey),
      ),
      onPressed: () {
        _logInUser(type: LoginType.google, context: context);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            // Image(image: AssetImage("assets/google_logo.png"), height: 25.0),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: _headerHeight,
            child: Header(_headerHeight, true, Icons.login_rounded),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Column(children: <Widget>[
                const Text(
                  "Hello",
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Sign In into your account",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "Username",
                          hintText: 'Enter your username',
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: 'Enter your password',
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: const Text(
                            "Forgot your password?",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 4),
                                blurRadius: 5.0)
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: const [0.0, 1.0],
                            colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).accentColor,
                            ],
                          ),
                          color: Colors.deepPurple.shade300,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            minimumSize:
                                MaterialStateProperty.all(const Size(50, 50)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: Text(
                              "SIGN IN",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            _logInUser(
                                type: LoginType.email,
                                email: _emailController.text,
                                password: _passwordController.text,
                                context: context);
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Text.rich(
                          TextSpan(children: [
                            const TextSpan(text: "Dont't have an account?"),
                            TextSpan(
                              text: 'Create',
                              recognizer: TapGestureRecognizer()..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen()));
                                },
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).accentColor),
                            )
                          ]),
                        ),
                      ),
                      _googleButton(),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      )),
    );
  }
}
