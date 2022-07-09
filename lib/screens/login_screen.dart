// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/current_user.dart';
import '../utils/app_theme.dart';
import '../widgets/header.dart';
import '../widgets/snack_bar.dart';
import 'root_screen.dart';
import 'signup_screen.dart';

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
    String? response;

    try {
      final navigator = Navigator.of(context);
      final scaffoldMessenger = ScaffoldMessenger.of(context);

      switch (type) {
        case LoginType.email:
          response =
              await currentUser.loginInWithEmail(email!, password!);
          break;
        case LoginType.google:
          response = await currentUser.loginInWithGoogle(context);
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
        scaffoldMessenger.showSnackBar( SnackBar(
            content: Text(response!),
            duration: const Duration(seconds: 2)));
      }
    } catch (e) {
      response = e.toString();
    }
  }

  void _resetPassword({BuildContext? context, String? email}) async {
    String response = 'error';
    CurrentUser currentUser = Provider.of<CurrentUser>(context!, listen: false);

    try {
      response = await currentUser.resetPassword(email!);
      if (response == "success") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
      } else {
        showSnackBar(context, "Something went wrong. Try Again");
      }
    } catch (e) {
      response = e.toString();
    }
  }

  // Widget _googleButton() {
  //   return OutlinedButton(
  //     style: OutlinedButton.styleFrom(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  //     ),
  //     onPressed: () {
  //       _logInUser(type: LoginType.google, context: context);
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: const <Widget>[
  //           // Image(image: AssetImage("assets/google_logo.png"), height: 25.0),
  //           Padding(
  //             padding: EdgeInsets.only(left: 10),
  //             child: Text(
  //               'Sign in with Google',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 color: Colors.grey,
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
  // ignore: todo
  //TODO: Add show password

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Text(
                  "Hola, Amigo",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: AppTheme().getSecondaryColor,
                  ),
                ),
                Text(
                  "Sign In into your account",
                  style: TextStyle(
                      color: AppTheme().getSecondaryColor, fontSize: 16.0),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.alternate_email_outlined,
                          ),
                          hintText: 'Email',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                          hintText: 'Password',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            _resetPassword(
                                context: context, email: _emailController.text);
                          },
                          child: Text(
                            "Forgot your password?",
                            style: TextStyle(
                              color: AppTheme().getSecondaryTextColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                            colors: [
                              Theme.of(context).primaryColor,
                              Colors.blueAccent,
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 0.0),
                            stops: const [0.0, 1.0],
                            tileMode: TileMode.clamp,
                          ),
                          // color: Colors.deepPurple.shade300,
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
                              text: ' Create',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen()));
                                },
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme().getSecondaryTextColor),
                            )
                          ]),
                        ),
                      ),
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
