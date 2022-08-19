import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Places [top] on top and [bottom] on bottom.
///
/// If [top] takes more than [DistancedWidgets] itself then [bottom] is hide.
class DistancedWidgets extends MultiChildRenderObjectWidget {
  DistancedWidgets({
    required Widget top,
    required Widget bottom,
    required this.onBottomHide,
    required this.onBottomShow,
    Key? key,
  }) : super(children: [top, bottom], key: key);

  /// Called after each [RenderObject.performLayout] when [bottom] is not
  /// rendering
  final void Function() onBottomHide;

  /// Called after each [RenderObject.performLayout] when [bottom] is rendering
  final void Function() onBottomShow;

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderObject renderObject) {
    (renderObject as RenderDistancedWidgets)
      ..onBottomHide = onBottomHide
      ..onBottomShow = onBottomShow;
  }

  @override
  RenderDistancedWidgets createRenderObject(BuildContext context) {
    return RenderDistancedWidgets()
      ..onBottomHide = onBottomHide
      ..onBottomShow = onBottomShow;
  }
}

class _DistancedWidgetsChildParentData extends ContainerBoxParentData<RenderBox>
    with ContainerParentDataMixin<RenderBox> {}

class RenderDistancedWidgets extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _DistancedWidgetsChildParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox,
            _DistancedWidgetsChildParentData> {
  bool _needToDrawBottomObject = true;

  void Function()? onBottomHide;
  void Function()? onBottomShow;

  @override
  void setupParentData(covariant RenderObject child) {
    child.parentData = _DistancedWidgetsChildParentData();
  }

  @override
  void performLayout() {
    final topObject = firstChild!;
    final bottomObject = childAfter(topObject)!;

    topObject.layout(constraints.copyWith(minHeight: 0), parentUsesSize: true);

    final bottomObjectConstrained = constraints.copyWith(
      minHeight: 0,
      minWidth: constraints.maxWidth,
    );

    final bottomObjectSize = bottomObject.getDryLayout(bottomObjectConstrained);
    bool enoughHeightForBottomObject() {
      final availablHeight = constraints.maxHeight - topObject.size.height;
      return availablHeight >= bottomObjectSize.height;
    }

    if (enoughHeightForBottomObject()) {
      bottomObject.layout(bottomObjectConstrained, parentUsesSize: true);
      bottomObject.lowerBy(constraints.maxHeight - bottomObject.size.height);

      _needToDrawBottomObject = true;

      if (onBottomShow != null) {
        scheduleMicrotask(onBottomShow!);
      }
    } else {
      _needToDrawBottomObject = false;

      if (onBottomHide != null) {
        scheduleMicrotask(onBottomHide!);
      }
    }

    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final topObject = firstChild!;
    final childParentData =
        topObject.parentData! as _DistancedWidgetsChildParentData;
    context.paintChild(topObject, childParentData.offset + offset);

    if (_needToDrawBottomObject) {
      final bottomObject = childAfter(topObject)!;
      final childParentData =
          bottomObject.parentData! as _DistancedWidgetsChildParentData;
      context.paintChild(bottomObject, childParentData.offset + offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}

extension on RenderBox {
  void lowerBy(double dy) {
    final parent = parentData as _DistancedWidgetsChildParentData;
    parent.offset = Offset(0, dy);
  }
}
