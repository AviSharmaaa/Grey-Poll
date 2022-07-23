import 'package:flutter/material.dart';
import 'widgets/background_design.dart';
import 'widgets/bottom_container.dart';
import 'widgets/login_credentials.dart';

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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              BackgroundDesign(),
              LoginCredentials(
                emailController: _emailController,
                passwordController: _passwordController,
              ),
              BottomContainer(
                emailController: _emailController,
                passwordController: _passwordController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}