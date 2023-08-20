import 'package:flutter/material.dart';

import '../../styles/color_palette.dart';
import '../../styles/text_styles.dart';
import '../main_botton/app_button.dart';
import '../main_botton/main_text_button.dart';
import 'main_dialog_container.dart';

class TwoButtonsDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String firstButtonText;
  final String secondButtonText;
  final VoidCallback? onFirstTap;
  final VoidCallback? onSecondTap;

  const TwoButtonsDialog({
    Key? key,
    this.onFirstTap,
    this.onSecondTap,
    required this.title,
    required this.subtitle,
    required this.firstButtonText,
    required this.secondButtonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainDialogContainer(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: ProjectTextStyles.ui_20Medium,
          ),
          const SizedBox(height: 8.0),
          Text(
            subtitle,
            style: ProjectTextStyles.ui_14Regular
                .copyWith(color: ColorPalette.gray),
          ),
          const SizedBox(height: 16.0),
          MainButton(
            title: firstButtonText,
            onTap: onFirstTap ?? () {},
            buttonHeight: 36.0,
            borderRadius: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Center(
              child: MainTextButton(
                  title: secondButtonText,
                  onPressed: () {
                    onSecondTap?.call();
                  }),
            ),
          )
        ],
      ),
    );
  }
}
