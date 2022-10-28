import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_voting_app/state/misc_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'state/current_user_state.dart';
import 'screens/onboarding_screen/onboarding_screen.dart';
import 'screens/root_screen.dart';
import 'state/poll_state.dart';
import 'utils/app_theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final bool showHome = prefs.getBool('showHome') ?? false;

  runApp(GreyPoll(showHome: showHome));
}

class GreyPoll extends StatelessWidget {
  final bool showHome;
  const GreyPoll({Key? key, required this.showHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CurrentUser(),
        ),
        ChangeNotifierProvider(
          create: (_) => PollState(),
        ),
        ChangeNotifierProvider(
          create: (_) => MiscState(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grey Poll',
        theme: AppTheme().buildTheme(),
        home: showHome ? const RootScreen() : const OnboardingScreen(),
      ),
    );
  }
}
