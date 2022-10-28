import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/size_config.dart';
import 'package:provider/provider.dart';
import '../../state/poll_state.dart';
import '../../utils/app_theme.dart';
import '../../widgets/background_design.dart';
import 'widgets/show_poll_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AppTheme theme = AppTheme();
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<PollState>(context, listen: false).clearState();
      Provider.of<PollState>(context, listen: false).loadPollList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'GreyPoll',
              style: TextStyle(
                fontSize: 26,
                color: theme.kWhiteText,
              ),
            ),
            SizedBox(
              width: S.width(8),
            ),
            Icon(
              Icons.poll_outlined,
              size: S.width(28),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          BackgroundDesign(
            shapeOneRight:  S.percentWidth(-0.18)!,
            shapeOneTop: 0.12,
            shapeTwoLeft: 0.15,
            shapeTwoBottom: 0.05,
            shapeThreeLeft: 0.62,
            shapeThreeBottom: 0,
            shapeFourLeft: 0.03,
            shapeFourBottom: 45,
            sizedboxThreeHeight: S.percentHeight(0.50),
          ),
          ShowPollList(),
        ],
      ),
    );
  }
}
