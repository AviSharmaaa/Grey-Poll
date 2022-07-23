import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_theme.dart';

class SignupCredentials extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final TextEditingController emailController;

  const SignupCredentials({
    Key? key,
    required this.nameController,
    required this.passwordController,
    required this.emailController,
    required this.formKey,
  }) : super(key: key);

  @override
  State<SignupCredentials> createState() => _SignupCredentialsState();
}

class _SignupCredentialsState extends State<SignupCredentials> {
  int nameDepth = -40;
  int emailDepth = -40;
  int passwordDepth = -40;
  bool obscureText = true;
  final AppTheme theme = AppTheme();

  void showPassword() {
    setState(() {
      obscureText = !obscureText;
    });
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
              'Hey!!',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: theme.kSecondaryColor2),
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
            Form(
              key: widget.formKey,
              child: Column(
                children: [
                  ClayAnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    borderRadius: 30,
                    color: theme.kCanvasColor,
                    depth: nameDepth,
                    spread: 6,
                    child: Focus(
                      onFocusChange: (value) {
                        setState(() {
                          nameDepth = -nameDepth;
                        });
                      },
                      child: TextFormField(
                        controller: widget.nameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_outline_sharp),
                          hintText: 'Full name',
                        ),
                        validator: (val) {
                          if (val!.length < 6) {
                            return 'Username should be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ClayAnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    borderRadius: 30,
                    color: theme.kCanvasColor,
                    depth: emailDepth,
                    spread: 6,
                    child: Focus(
                      onFocusChange: (value) {
                        setState(() {
                          emailDepth = -emailDepth;
                        });
                      },
                      child: TextFormField(
                        controller: widget.emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.alternate_email_outlined),
                          hintText: 'Email',
                        ),
                        validator: (val) {
                          if ((val!.isNotEmpty) &&
                              !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                  .hasMatch(val)) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ClayAnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    borderRadius: 30,
                    color: theme.kCanvasColor,
                    depth: passwordDepth,
                    spread: 6,
                    child: Focus(
                      onFocusChange: (value) {
                        setState(() {
                          passwordDepth = -passwordDepth;
                        });
                      },
                      child: TextFormField(
                        controller: widget.passwordController,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: showPassword,
                            icon: obscureText
                                ? const Icon(Icons.visibility_outlined)
                                : const Icon(Icons.visibility_off_outlined),
                          ),
                        ),
                        validator: (val) {
                          if (val!.length <= 6) {
                            return "Password must contain more than 6 characters";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
