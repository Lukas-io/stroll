import 'package:flutter/material.dart';
import 'package:stroll/src/constants/extensions.dart';

import '../../constants/colors.dart';

class OptionsWidget extends StatefulWidget {
  final List<String> options;
  final List<String>? numbering;
  final bool showBorders;
  final int childAspectRatio;
  final Color? optionColor;
  final double paddingVertical;

  const OptionsWidget({
    super.key,
    required this.options,
    this.numbering,
    this.showBorders = true,
    this.optionColor,
    this.childAspectRatio = 6,
    this.paddingVertical = 24.0,
  });

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
            (MediaQuery.of(context).size.height / widget.childAspectRatio),
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
      ),
      padding: EdgeInsets.symmetric(vertical: widget.paddingVertical),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return OptionWidget(
          text: widget.options[index],
          showBorders: widget.showBorders,
          numbering: widget.numbering?[index],
          optionColor: widget.optionColor,
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
  final String? numbering;
  final bool showBorders;
  final Color? optionColor;

  final bool selected;

  const OptionWidget({
    super.key,
    required this.text,
    required this.onTap,
    required this.selected,
    this.showBorders = true,
    this.optionColor = secondaryCardColor,
    this.numbering,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
                color: selected
                    ? primaryColor
                    : showBorders
                        ? greyColor.withOpacity(.3)
                        : Colors.transparent,
                width: 2.0),
            color: optionColor,
            borderRadius: BorderRadius.circular(12.0)),
        child: Row(
          children: [
            if (numbering != null)
              Container(
                padding: const EdgeInsets.all(6.0),
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: selected ? primaryColor : greyColor, width: 2.0),
                  color: selected ? primaryColor : null,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  numbering!.toUpperCase(),
                  style: context.textTheme.bodyLarge?.copyWith(
                      color: selected ? whiteTextColor : greyTextColor),
                ),
              ),
            Expanded(
              child: Text(
                text,
                textAlign: numbering != null ? null : TextAlign.center,
                maxLines: 2,
                style: showBorders
                    ? context.textTheme.bodyLarge?.copyWith(
                        color: selected
                            ? whiteTextColor
                            : greyTextColor.withOpacity(.6),
                        height: 1,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600)
                    : context.textTheme.bodyMedium?.copyWith(
                        height: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
