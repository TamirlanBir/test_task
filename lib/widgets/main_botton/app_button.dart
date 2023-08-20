import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../styles/color_palette.dart';
import '../../styles/text_styles.dart';

class MainButton extends StatelessWidget {
  final String? title;

  final Color color;

  final Color textColor;

  final bool isEnabled;

  final VoidCallback onTap;

  final Color? borderColor;

  final double buttonHeight;

  final String? icon;
  final Color? iconColor;

  final double? width;

  final double fontSize;

  final double borderRadius;

  final Color? disabledTextColor;

  final Color? disabledBackgroundColor;

  const MainButton({
    Key? key,
    this.title,
    this.color = ColorPalette.main,
    this.isEnabled = true,
    this.textColor = ColorPalette.white,
    required this.onTap,
    this.buttonHeight = 50,
    this.borderColor,
    this.icon,
    this.iconColor,
    this.width,
    this.fontSize = 16,
    this.borderRadius = 12,
    this.disabledTextColor,
    this.disabledBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: buttonHeight,
          width: width ?? MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ButtonStyle(
              shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
              backgroundColor: MaterialStateProperty.all<Color>(
                !isEnabled && disabledBackgroundColor != null
                    ? disabledBackgroundColor!
                    : color,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: (borderColor != null)
                      ? BorderSide(color: borderColor!)
                      : BorderSide.none,
                ),
              ),
            ),
            onPressed: isEnabled ? onTap : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset(
                          icon!,
                          color: iconColor,
                          width: 20,
                          height: 20,
                        ),
                      )
                    : const SizedBox.shrink(),
                title != null
                    ? Text(
                        title!,
                        style: ProjectTextStyles.ui_16_w400.copyWith(
                          color: !isEnabled && disabledBackgroundColor != null
                              ? disabledTextColor
                              : textColor,
                          height: 1.5,
                          fontSize: fontSize,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
        if (!isEnabled && disabledBackgroundColor == null)
          Positioned.fill(
            child: Container(
              height: buttonHeight,
              width: width ?? MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: ColorPalette.white.withOpacity(0.55),
              ),
            ),
          ),
      ],
    );
  }
}
