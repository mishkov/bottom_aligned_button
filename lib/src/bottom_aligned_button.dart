import 'package:flutter/material.dart';

import 'distanced_widgets.dart';

/// Places [child] on top of itself and [button] on bottom.
///
/// If [child] takes more height than [BottomAlignedButton] itself then [button]
/// is moved to end of created list and becomes scrollable with child.
class BottomAlignedButton extends StatefulWidget {
  const BottomAlignedButton({
    required this.button,
    required this.child,
    Key? key,
  }) : super(key: key);

  /// Represents main content, for example login form.
  final Widget child;

  /// The button that will be placed to bottom or at end of the list
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
