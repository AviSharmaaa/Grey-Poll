import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../state/current_user_state.dart';
import '../../../utils/app_theme.dart';
import '../../root_screen.dart';
import '../../signup_screen/signup_screen.dart';

enum LoginType {
  email,
  google,
}

class BottomContainer extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const BottomContainer({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<BottomContainer> createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {
  int buttonDepth = 40;
  final AppTheme theme = AppTheme();

  void _logInUser({
    @required LoginType? type,
    String? email,
    String? password,
    BuildContext? context,
  }) async {
    CurrentUser currentUser = Provider.of<CurrentUser>(context!, listen: false);
    String? response;

    try {
      final navigator = Navigator.of(context);
      final scaffoldMessenger = ScaffoldMessenger.of(context);

      switch (type) {
        case LoginType.email:
          response = await currentUser.loginInWithEmail(email!, password!);
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
        scaffoldMessenger.showSnackBar(SnackBar(
            content: Text(response!), duration: const Duration(seconds: 2)));
      }
    } catch (e) {
      response = e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 60,
      left: 0,
      right: 0,
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.07,
          ),
          ClayAnimatedContainer(
            duration: const Duration(milliseconds: 300),
            surfaceColor: theme.kSecondaryColor,
            depth: buttonDepth,
            borderRadius: 30,
            curveType: CurveType.concave,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
              child: GestureDetector(
                onTapDown: (val) {
                  setState(() {
                    buttonDepth = -buttonDepth;
                  });
                },
                onTapUp: (val) {
                  setState(() {
                    buttonDepth = -buttonDepth;
                  });
                  _logInUser(
                    type: LoginType.email,
                    email: widget.emailController.text,
                    password: widget.passwordController.text,
                    context: context,
                  );
                },
                child: Text(
                  "SIGN IN",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: theme.kCanvasColor,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Dont't have an account?",
                    style: TextStyle(
                      color: theme.kTextColor,
                    ),
                  ),
                  TextSpan(
                    text: ' Create',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
