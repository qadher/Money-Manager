import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:moneywallet/screen/welcome/controller/provider/spalshProvider/welcome_provider.dart';
import 'package:provider/provider.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<WelcomeProvidfer>(context, listen: false).gotoHome(context);
    });
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/2gif.gif',
                    width: 150,
                    height: 150,
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        'Money Manager',
                        textStyle: const TextStyle(
                          fontSize: 30,
                        ),
                        colors: [
                          Colors.black,
                          Colors.white,
                        ],
                        speed: const Duration(
                          milliseconds: 20,
                        ),
                      ),
                    ],
                    isRepeatingAnimation: true,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
