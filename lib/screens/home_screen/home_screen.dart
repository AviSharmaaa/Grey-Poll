import 'package:flutter/material.dart';
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
    Size size = MediaQuery.of(context).size;
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
            const SizedBox(
              width: 8,
            ),
            const Icon(
              Icons.poll_outlined,
              size: 28,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          BackgroundDesign(
            shapeOneRight: -size.width * 0.18,
            shapeOneTop: 0.12,
            shapeTwoLeft: 0.15,
            shapeTwoBottom: 0.05,
            shapeThreeLeft: 0.62,
            shapeThreeBottom: 0,
            shapeFourLeft: 0.03,
            shapeFourBottom: 45,
            sizedboxThreeHeight: size.height * 0.50,
          ),
          ShowPollList(),
        ],
      ),
    );
  }
}
