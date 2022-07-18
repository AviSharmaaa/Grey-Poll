import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Column buildPage(BuildContext context, String imagePath, String title, String content) {
  return Column(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.90,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100),
          child: Column(
            children: [
              SvgPicture.asset(
                height: MediaQuery.of(context).size.height * 0.40,
                imagePath,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
