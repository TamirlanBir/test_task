import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_task/network/models/login_response_model.dart';
import 'package:test_task/network/repository/hive_repository.dart';
import 'package:test_task/styles/text_styles.dart';

import '../../main/login_bloc/login_bloc.dart';
import '../../styles/color_palette.dart';
import '../../widgets/dialogs/two_buttons_dialog.dart';

class ProfileMain extends StatefulWidget {
  ProfileMain({Key? key, required this.hiveRepository}) : super(key: key);
  HiveRepository hiveRepository;
  @override
  State<ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  late User _dataUser;
  @override
  void initState() {
    super.initState();
    final user = widget.hiveRepository.getUser();
    _dataUser = user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      appBar: AppBar(
        title: const Text(
          'Профиль',
          style: ProjectTextStyles.ui_15_w500,
        ),
        centerTitle: true,
        backgroundColor: ColorPalette.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30.h),
          Center(
            child: SvgPicture.asset('assets/icons/profile_ava.svg'),
          ),
          SizedBox(height: 20.h),
          Text(
            _dataUser.nickname,
            style: ProjectTextStyles.ui_24_w600,
          ),
          SizedBox(height: 10.h),
          Text(
            _dataUser.email,
            style:
                ProjectTextStyles.ui_16_w400.copyWith(color: ColorPalette.gray),
          ),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => TwoButtonsDialog(
                  title: "Вы уверены что хотите выйти?",
                  subtitle:
                      "Если вы выйдете из аккаунта, то больше не сможете пользоваться услугами до следующего входа",
                  firstButtonText: "Да",
                  secondButtonText: "Нет",
                  onFirstTap: () {
                    Navigator.pop(ctx);
                    context.read<LoginBloc>().add(LogOutEvent());
                  },
                  onSecondTap: () {
                    Navigator.pop(ctx);
                  },
                ),
              );
            },
            child: Container(
              width: 375.w,
              height: 55.h,
              color: ColorPalette.white,
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Text(
                'Выйти',
                style: ProjectTextStyles.ui_16_w400.copyWith(
                  color: ColorPalette.red,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
