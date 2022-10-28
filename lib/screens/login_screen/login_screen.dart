import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/size_config.dart';
import '../../widgets/background_design.dart';
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: S.width(size.width),
          height: S.height(size.height),
          child: Stack(
            children: [
              BackgroundDesign(
                shapeOneRight: 0,
                shapeOneTop: 0.05,
                shapeTwoLeft: 0.05,
                shapeTwoBottom: 0.1,
                shapeThreeLeft: 0.62,
                shapeThreeBottom: 0,
                shapeFourLeft: 0.03,
                shapeFourBottom: 45,
              ),
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
