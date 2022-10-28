import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/size_config.dart';
import '../../utils/app_theme.dart';
import '../../widgets/background_design.dart';
import 'widgets/build_page.dart';
import 'widgets/navigation_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController controller = PageController();
  TabController? tabController;
  bool isLastPage = false;
  final AppTheme theme = AppTheme();

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  void _incrementCounter(value) {
    setState(() {
      tabController!.index = value;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundDesign(
            shapeOneRight: 0,
            shapeOneTop: 0.05,
            shapeTwoLeft: 0.05,
            shapeTwoBottom: 0.1,
            shapeThreeLeft: 0.62,
            shapeThreeBottom: 0,
            shapeFourLeft: 0.03,
            shapeFourBottom: 95,
          ),
          PageView(
            onPageChanged: (value) {
              setState(() {
                isLastPage = (value == 2);
              });
              _incrementCounter(value);
            },
            controller: controller,
            children: [
              buildPage(
                context,
                'assets/undraw_wait_in_line_o2aq.svg',
                "Create",
                "Create polls with just a couple of taps, and weigh in on all the topics you care about.",
                0,
              ),
              buildPage(
                context,
                'assets/undraw_election_day_w842.svg',
                "Vote",
                "Participate on the topics you strongly feel about. Use your power to vote and be the voice of change.",
                20,
              ),
              buildPage(
                context,
                'assets/undraw_like_dislike_re_dwcj.svg',
                "Share your Opinion",
                "Give your opinions on various topics by participating in polls. Grey Poll is a very easy way to make your voice heard.",
                0,
              ),
            ],
          ),
          Container(
            alignment: Alignment(S.width(0)!, S.height(0.75)!),
            child: TabPageSelector(
              selectedColor: theme.kPrimaryColor,
              controller: tabController,
              borderStyle: BorderStyle.solid,
            ),
          ),
          NavigationWidget(
            isLastPage: isLastPage,
            controller: controller,
            theme: theme,
          ),
        ],
      ),
    );
  }
}
