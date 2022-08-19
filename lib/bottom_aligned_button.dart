library bottom_aligned_button;

import 'package:flutter/material.dart';

import 'distanced_widgets.dart';

class BottomAlignedButton extends StatefulWidget {
  const BottomAlignedButton({
    required this.button,
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Widget button;

  @override
  State<BottomAlignedButton> createState() => _BottomAlignedButtonState();
}

class _BottomAlignedButtonState extends State<BottomAlignedButton> {
  bool isButtonShowed = true;

  @override
  Widget build(BuildContext context) {
    return DistancedWidgets(
      top: ListView(
        physics: isButtonShowed ? const NeverScrollableScrollPhysics() : null,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          widget.child,
          Visibility(
            visible: !isButtonShowed,
            child: widget.button,
          ),
        ],
      ),
      bottom: widget.button,
      onBottomHide: () {
        setState(() {
          isButtonShowed = false;
        });
      },
      onBottomShow: () {
        setState(() {
          isButtonShowed = true;
        });
      },
    );
  }
}
