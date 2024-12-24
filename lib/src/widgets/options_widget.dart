import 'package:flutter/material.dart';
import 'package:stroll/src/constants/extensions.dart';

import '../constants/colors.dart';

class OptionsWidget extends StatefulWidget {
  final List<String> options;

  const OptionsWidget({super.key, required this.options});

  @override
  State<OptionsWidget> createState() => _OptionsWidgetState();
}

class _OptionsWidgetState extends State<OptionsWidget> {
  late int selectedIndex;

  @override
  void initState() {
    selectedIndex = widget.options.length + 1;
    super.initState();
  }

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
        return OptionWidget(
          text: widget.options[index],
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          selected: selectedIndex == index,
        );
      },
      itemCount: widget.options.length,
    );
  }
}

class OptionWidget extends StatelessWidget {
  final String text;
  final Function() onTap;

  final bool selected;

  const OptionWidget(
      {super.key,
      required this.text,
      required this.onTap,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
                color: selected ? primaryColor : greyColor.withOpacity(.3),
                width: 2.0),
            color: secondaryCardColor.withOpacity(.8),
            borderRadius: BorderRadius.circular(12.0)),
        child: Text(
          text,
          style: context.textTheme.bodyLarge?.copyWith(
              color: selected ? whiteTextColor : greyTextColor.withOpacity(.6),
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
