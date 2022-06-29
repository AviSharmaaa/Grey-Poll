import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/current_user.dart';
import 'screens/root_screen.dart';
import 'state/vote_state.dart';
import 'utils/app_theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const GreyPoll());
}

class GreyPoll extends StatelessWidget {
  const GreyPoll({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CurrentUser(),
        ),
        ChangeNotifierProvider(
          create: (_) => VoteState()
        )

      ],
      child: MaterialApp(
        title: 'Grey Poll',
        theme: AppTheme().buildTheme(),
        home: const RootScreen(),
      ),
    );
  }
}
