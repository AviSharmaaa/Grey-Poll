import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../state/current_user_state.dart';
import '../../../utils/app_theme.dart';

class LoginCredentials extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginCredentials({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<LoginCredentials> createState() => _LoginCredentialsState();
}

class _LoginCredentialsState extends State<LoginCredentials> {
  int passwordDepth = -40;
  int emailDepth = -40;
  bool obscureText = true;
  final AppTheme theme = AppTheme();

  void showPassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void _resetPassword({
    BuildContext? context,
    String? email,
    ScaffoldMessengerState? messenger,
  }) async {
    String response = 'error';
    CurrentUser currentUser = Provider.of<CurrentUser>(context!, listen: false);

    try {
      response = await currentUser.resetPassword(email!);
      if (response != "success") {
        messenger!.showSnackBar(
          SnackBar(
            content: Text(response),
          ),
        );
      }
    } catch (e) {
      response = e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Positioned(
      top: size.height * 0.35,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: theme.kSecondaryColor),
            ),
            Text(
              'Let\'s get started',
              style: TextStyle(
                fontSize: 20,
                color: theme.kSecondaryTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ClayAnimatedContainer(
              duration: const Duration(milliseconds: 300),
              borderRadius: 30,
              color: theme.kCanvasColor,
              depth: emailDepth,
              spread: 6,
              child: Focus(
                onFocusChange: (value) {
                  emailDepth = -emailDepth;
                },
                child: TextFormField(
                  controller: widget.emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.alternate_email_outlined),
                    hintText: 'Email',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ClayAnimatedContainer(
              duration: const Duration(milliseconds: 300),
              borderRadius: 30,
              color: theme.kCanvasColor,
              depth: passwordDepth,
              spread: 6,
              child: Focus(
                onFocusChange: (value) {
                  passwordDepth = -passwordDepth;
                },
                child: TextFormField(
                  controller: widget.passwordController,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: showPassword,
                      icon: (obscureText)
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  _resetPassword(
                    context: context,
                    email: widget.emailController.text,
                    messenger: scaffoldMessenger,
                  );
                },
                child: Text(
                  "Forgot password?",
                  style: TextStyle(
                    color: theme.kTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
