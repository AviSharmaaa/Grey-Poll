import 'package:flutter/material.dart';
import 'widgets/build_page.dart';
import 'widgets/navigation_container.dart';

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
              ),
              buildPage(
                context,
                'assets/undraw_election_day_w842.svg',
                "Vote",
                "Participate on the topics you strongly feel about. Use your power to vote and be the voice of change.",
              ),
              buildPage(
                context,
                'assets/undraw_like_dislike_re_dwcj.svg',
                "Share your Opinion",
                "Give your opinions on various topics by participating in polls. Grey Poll is a very easy way to make your voice heard.",
              ),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: TabPageSelector(
              selectedColor: const Color(0xFF00BFA6),
              controller: tabController,
              borderStyle: BorderStyle.none,
            ),
          ),
          navigationContainer(context, controller, isLastPage),
        ],
      ),
    );
  }
}
