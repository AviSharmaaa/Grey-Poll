import 'package:flutter/material.dart';
import '../../../state/poll_state.dart';
import '../../../utils/app_theme.dart';

class DisplayOptions extends StatelessWidget {
  final AppTheme theme = AppTheme();
  DisplayOptions({
    Key? key,
    required this.provider,
    required this.option,
  }) : super(key: key);

  final PollState provider;
  final String option;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 15.0,
      ),
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        onTap: () {
          provider.selectedOption = option;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            color: (provider.selecetedOption == option)
                ? theme.kSecondaryColor2
                : Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 4,
                blurRadius: 5,
                offset: const Offset(3, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  option,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: (provider.selecetedOption == option)
                        ? FontWeight.bold
                        : FontWeight.w500,
                    color: (provider.selecetedOption == option)
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                if (provider.selecetedOption == option)
                  const Icon(
                    Icons.check_circle_outline_sharp,
                    color: Colors.white,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
