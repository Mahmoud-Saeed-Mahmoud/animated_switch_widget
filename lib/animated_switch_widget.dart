import 'package:flutter/material.dart';

/// AnimatedCustomSwitch
class AnimatedCustomSwitchWidget extends StatelessWidget {
  /// Whether the switch is active or not.
  ///
  /// When this changes, the switch will animate to the new position.
  ///
  /// Defaults to `false`.
  final bool active;

  /// The widget displayed when the switch is active.
  final Widget widgetOn;

  /// The widget displayed when the switch is not active.
  final Widget widgetOff;

  /// The color of the switch when it is active.
  ///
  /// Defaults to `Colors.blue`.
  final Color onColor;

  /// The color of the switch when it is not active.
  ///
  /// Defaults to `Colors.grey`.
  final Color offColor;

  /// The width of the switch.
  ///
  /// Defaults to `90.0`.
  final double width;

  /// The height of the switch.
  ///
  /// Defaults to `40.0`.
  final double height;

  /// The duration of the animation when the switch is changed.
  ///
  /// Defaults to `const Duration(milliseconds: 600)`.
  final Duration animationDuration;

  /// The curve of the animation when the switch is changed to the on state.
  ///
  /// Defaults to `Curves.easeOutExpo`.
  final Curve switchInCurve;

  /// The curve of the animation when the switch is changed to the off state.
  ///
  /// Defaults to `Curves.easeInExpo`.
  final Curve switchOutCurve;

  const AnimatedCustomSwitchWidget({
    super.key,
    required this.active,
    required this.widgetOn,
    required this.widgetOff,
    required this.onColor,
    required this.offColor,
    this.width = 90,
    this.height = 40,
    this.animationDuration = const Duration(milliseconds: 600),
    this.switchInCurve = Curves.easeOutExpo,
    this.switchOutCurve = Curves.easeInExpo,
  });
  @override

  /// Builds the AnimatedCustomSwitch widget.
  ///
  /// The switch is animated in and out by rotating and fading in/out the
  /// [widgetOn] and [widgetOff] widgets.
  ///
  /// The switch is colored using the [onColor] and [offColor] properties.
  ///
  /// The [animationDuration], [switchInCurve], and [switchOutCurve] properties
  /// control the animation when the switch is changed.
  ///
  /// The [width] and [height] properties control the size of the switch.
  ///
  /// The [active] property determines which widget is displayed.
  ///
  /// The [widgetOn] and [widgetOff] properties determine the widgets displayed
  /// when the switch is active and inactive respectively.
  Widget build(BuildContext context) {
    return AnimatedContainer(
      key: key,
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: active ? onColor : offColor,
      ),
      child: AnimatedAlign(
        duration: animationDuration ~/ 2,
        alignment: active ? Alignment.centerRight : Alignment.centerLeft,
        child: AnimatedSwitcher(
          duration: animationDuration,
          transitionBuilder: (child, animation) {
            final rotateAnimation =
                Tween<double>(begin: 0.0, end: 1.0).animate(animation);
            final reverseAnimation =
                Tween<double>(begin: 1.0, end: 0.0).animate(animation);
            return RotationTransition(
              turns: active ? rotateAnimation : reverseAnimation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          layoutBuilder: (currentChild, previousChildren) {
            return Stack(
              fit: StackFit.loose,
              children: [
                // Show the current child.
                if (currentChild != null) currentChild,
                // Show the previous children in a stack.
                ...previousChildren.map(
                  (child) {
                    return IgnorePointer(child: child);
                  },
                ),
              ],
            );
          },
          switchInCurve: switchInCurve,
          switchOutCurve: switchOutCurve,
          child: active
              ? KeyedSubtree(
                  key: const ValueKey(true),
                  child: widgetOn,
                )
              : KeyedSubtree(
                  key: const ValueKey(false),
                  child: widgetOff,
                ),
        ),
      ),
    );
  }
}
