import 'package:flutter/material.dart';
import 'package:itune/res/AppContextExtension.dart';
import '../common/text_view.dart';
import 'widgets/search_field.dart';

class StartSearchPage extends StatelessWidget {
  static const String id = "StartSearchPage";
  const StartSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final resources = context.resources;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                height: resources.screenHeight,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.apple,
                          color: resources.color.secondaryColor,
                          size: resources.dimension.iconMediumSize,
                        ),
                        const SizedBox(width: 10),
                        const TextWidget(
                          label: "iTunes",
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    TextWidget(
                      label:
                          "Explore a wide variety of content from the iTunes store including iBooks, movies, podcasts, music, music videos, and audiobooks.",
                      fontSize: resources.dimension.mediumText,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                    const SizedBox(height: 40),
                    const AnimatedOpacity(
                      opacity: 1.0,
                      duration: Duration(seconds: 1),
                      child: SearchField(),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
