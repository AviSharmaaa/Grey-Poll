import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../main_screen/main_screen.dart';
import 'widgets/body.dart';

class ResultScreen extends StatelessWidget {
  final AppTheme theme = AppTheme();
  ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.kPrimaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const MainScreen(),
              ),
              (route) => false,
            );
          },
        ),
        elevation: 0,
      ),
      body: Body(),
    );
  }
}
