import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/app_theme.dart';
import 'package:online_voting_app/widgets/background_design.dart';
import 'widgets/bottom_design.dart';
import 'widgets/signup_credentials.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AppTheme theme = AppTheme();

  @override
  void dispose() {
    _nameController.dispose();
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
              Positioned(
                top: 35,
                left: 10,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 30,
                    color: theme.kSecondaryColor,
                  ),
                ),
              ),
              SignupCredentials(
                formKey: _formKey,
                nameController: _nameController,
                emailController: _emailController,
                passwordController: _passwordController,
              ),
              BottomContainer(
                formKey: _formKey,
                nameController: _nameController,
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