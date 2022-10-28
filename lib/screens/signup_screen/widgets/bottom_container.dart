import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/size_config.dart';
import 'package:provider/provider.dart';
import '../../../state/current_user_state.dart';
import '../../../utils/app_theme.dart';

enum LoginType {
  email,
  google,
}

class BottomContainer extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const BottomContainer({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  }) : super(key: key);

  @override
  State<BottomContainer> createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {
  int buttonDepth = 40;
  final AppTheme theme = AppTheme();

  void _signUpUser(
      String name, String email, String password, BuildContext context) async {
    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);
    String? response;

    try {
      final navigator = Navigator.of(context);
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      response = await currentUser.signUpUser(email, password, name);
      if (response == "success") {
        navigator.pop();
      } else {
        scaffoldMessenger.showSnackBar(SnackBar(
            content: Text(response), duration: const Duration(seconds: 2)));
      }
    } catch (e) {
      response = e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: S.height(80),
      left: S.width(0),
      right: S.width(0),
      child: Column(
        children: [
          ClayAnimatedContainer(
            duration: const Duration(milliseconds: 300),
            surfaceColor: theme.kSecondaryColor,
            depth: buttonDepth,
            borderRadius: 30,
            curveType: CurveType.concave,
            child: Padding(
              padding: S.symmetric(
                horizontal: 50,
                vertical: 15,
              ),
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
                  if (widget.formKey.currentState!.validate()) {
                    _signUpUser(
                      widget.nameController.text,
                      widget.emailController.text,
                      widget.passwordController.text,
                      context,
                    );
                  }
                },
                child: Text(
                  "SIGN UP",
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
            margin: S.symmetric(horizontal: 10,vertical: 20),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Already have an account?",
                    style: TextStyle(
                      color: theme.kTextColor,
                    ),
                  ),
                  TextSpan(
                    text: ' Log In',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pop(context);
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
