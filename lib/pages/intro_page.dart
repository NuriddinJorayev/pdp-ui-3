import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdpui4/pages/home_page.dart';
import 'package:pdpui4/util/strings.dart';

class Intro extends StatefulWidget {
  final String id = "intro_page";

  const Intro({Key? key}) : super(key: key);

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  PageController? _pageController;
  int _carrentIndex = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // main board center pageView widget
        PageView(
          controller: _pageController,
          onPageChanged: (int value) {
            setState(() {
              _carrentIndex = value;
            });
          },
          children: [
            _pageViewItemBuilder(
              Strings.stepOneTitle,
              Strings.stepOneContent,
              "assets/images/image_1.png",
            ),
            _pageViewItemBuilder(
              Strings.stepTwoTitle,
              Strings.stepTwoContent,
              "assets/images/image_2.png",
            ),
            Stack(
              children: [
                _pageViewItemBuilder(
                  Strings.stepThreeTitle,
                  Strings.stepThreeContent,
                  "assets/images/image_3.png",
                ),

                // skip button
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushReplacementNamed(
                              context, Home().id),
                          child: Text(
                            "Skip",
                            style: TextStyle(color: Colors.red, fontSize: 18.0),
                          ),
                        ),
                        SizedBox(width: 20.0)
                      ],
                    ),
                    SizedBox(height: 30.0)
                  ],
                )
              ],
            ),
          ],
        ),

        // indicator panel
        Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _indicatorBuilder(),
              )
            ],
          ),
        ),
      ],
    ));
  }

  // maker indecator function
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      margin: EdgeInsets.all(3.0),
      height: 6.0,
      width: isActive ? 30 : 6.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0), color: Colors.red),
    );
  }

  // indicator builder function
  List<Widget> _indicatorBuilder() {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      if (i == _carrentIndex) {
        list.add(_indicator(true));
      } else {
        list.add(_indicator(false));
      }
    }

    return list.toList();
  }

// pageView item builder function
  Widget _pageViewItemBuilder(title, content, image) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.red, fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          Text(content,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
              ),
          ),
          Image.asset(image),
        ],
      ),
    );
  }
}
