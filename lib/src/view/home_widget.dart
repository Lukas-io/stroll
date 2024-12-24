import 'package:flutter/material.dart';
import 'package:stroll/src/constants/colors.dart';
import 'package:stroll/src/constants/extensions.dart';
import 'package:stroll/src/constants/images.dart';

import '../widgets/story_indicator.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            imageOnboarding,
            height: MediaQuery.sizeOf(context).height / 3 * 2,
            width: MediaQuery.sizeOf(context).width,
            fit: BoxFit.cover,
          ),
          const SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [Expanded(child: StoryIndicator()), OnboardingBody()],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Use a tag to describe what you are looking for.",
          style: context.textTheme.headlineMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const OptionsWidget(options: [
          "Relationship",
          "Casual",
          "Friendship",
          "Open to all",
        ]),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          width: double.infinity,
          decoration: BoxDecoration(
              color: secondaryCardColor.withOpacity(.6),
              borderRadius: BorderRadius.circular(12.0)),
          child: Text(
            "Deep talks & coffee dates.",
            style: context.textTheme.bodyLarge?.apply(
                color: greyColor.withOpacity(.6), fontStyle: FontStyle.italic),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "🚶‍♂️BeReal.",
                style: context.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              IconButton.outlined(
                onPressed: null,
                icon: Icon(
                  Icons.arrow_forward,
                  size: 35.0,
                  color: greyColor,
                ),
                style: IconButton.styleFrom(
                    side: BorderSide(width: 2, color: greyColor)),
              )
            ],
          ),
        )
      ],
    );
  }
}

class OptionsWidget extends StatelessWidget {
  final List<String> options;

  const OptionsWidget({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 6),
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
      ),
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return OptionWidget(text: options[index]);
      },
      itemCount: options.length,
    );
  }
}

class OptionWidget extends StatelessWidget {
  final String text;
  final Function? onTap;

  const OptionWidget({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: greyColor.withOpacity(.3), width: 2.0),
          color: secondaryCardColor.withOpacity(.8),
          borderRadius: BorderRadius.circular(12.0)),
      child: Text(
        text,
        style: context.textTheme.bodyLarge?.copyWith(
            color: greyTextColor.withOpacity(.6), fontWeight: FontWeight.w600),
      ),
    );
  }
}
