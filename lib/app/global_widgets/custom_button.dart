import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final String? label;
  final Widget? child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconData? icons;
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double borderRadiusValue;
  final String? tooltip;
  final Color? disabledColor;
  final double? elevation;
  const CustomButton({
    super.key,
    this.label,
    this.child,
    this.onPressed,
    this.icons,
    this.backgroundColor,
    this.foregroundColor = const Color.fromARGB(255, 255, 255, 255),
    this.width,
    this.height,
    this.padding,
    this.borderRadiusValue = 18,
    this.tooltip,
    this.disabledColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: MaterialButton(
        height: height ?? 50,
        minWidth: width ?? double.infinity,
        onPressed: onPressed,
        disabledTextColor: Colors.grey,
        disabledColor: disabledColor,
        disabledElevation: 2,
        elevation: elevation,
        color: backgroundColor ?? Get.theme.colorScheme.primary,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          // side: const BorderSide(
          //   color: Colors.grey,
          // ),
        ),
        child: icons == null
            ? child ??
                Text(
                  label ?? '',
                  style: TextStyle(fontSize: 18, color: foregroundColor),
                )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icons, color: foregroundColor),
                  if (label != null) const SizedBox(width: 8.0),
                  if (label != null)
                    Text(
                      label!,
                      style: TextStyle(fontSize: 18, color: foregroundColor),
                    ),
                ],
              ),
      ),
    );
  }
}

class CustomButtonWithLoading extends StatefulWidget {
  const CustomButtonWithLoading({
    super.key,
    required this.onPressed,
    this.label,
    this.color,
    this.height,
    this.width,
    this.padding,
    this.loadingColor,
  });

  final Future<void> Function()? onPressed;
  final Widget? label;
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? loadingColor;

  @override
  State<CustomButtonWithLoading> createState() =>
      _CustomButtonWithLoadingState();
}

class _CustomButtonWithLoadingState extends State<CustomButtonWithLoading> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: widget.padding ?? const EdgeInsets.all(14.0),
      color: widget.color,
      minWidth: widget.width ?? double.infinity,
      height: widget.height,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      onPressed: () async {
        setState(() => isLoading = true);
        await widget.onPressed?.call().whenComplete(() => null);
        setState(() => isLoading = false);
      },
      child: isLoading
          ? Center(
              child: LinearProgressIndicator(
                color: widget.loadingColor,
              ),
            )
          : widget.label,
    );
  }
}
