import 'package:flutter/material.dart';
import 'package:itune/res/AppContextExtension.dart';
import 'package:itune/view/search/widgets/paramter_selector.dart';
import '../shared/text_view.dart';
import 'widgets/search_field.dart';
import 'widgets/submit_button.dart';

class StartSearchPage extends StatelessWidget {
  static const String id = "StartSearchPage";
  const StartSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final resources = context.resources;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: resources.screenHeight,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.apple,
                      color: resources.color.secondaryColor,
                      size: resources.dimension.iconMediumSize,
                    ),
                    const MyTextView(
                      label: "iTunes",
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                MyTextView(
                  label:
                      "Search for a variety of content from the iTunes store including iBooks, movies, podcasts, music, music videos, and audiobooks.",
                  fontSize: resources.dimension.mediumText,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 40),
                const SearchField(),
                const SizedBox(height: 40),
                MyTextView(
                  label: "Specify the parameter for the content to be searched",
                  fontSize: resources.dimension.smallText,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 40),
                const ParameterSelector(),
                const SizedBox(height: 40),
                SubmitButton(resources: resources),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
