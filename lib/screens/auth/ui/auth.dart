import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:test_task/screens/auth/bloc/auth_bloc.dart';
import 'package:test_task/styles/color_palette.dart';
import 'package:test_task/styles/text_styles.dart';

import '../../../main/login_bloc/login_bloc.dart';
import '../../../widgets/app_dialog.dart';
import '../../../widgets/app_loader_overlay.dart';
import '../../../widgets/main_botton/app_button.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool validate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      appBar: AppBar(
        title: const Text('Авторизация', style: ProjectTextStyles.ui_15_w500),
        centerTitle: true,
        backgroundColor: ColorPalette.white,
        elevation: 0,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: AppLoaderOverlay(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is StateAuthLoading) {
                return context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }
              if (state is StateErrorSignIn) {
                showAppDialog(
                  context,
                  body: state.errorMessage,
                );
              }
              if (state is StateSuccessSignIn) {
                context.read<LoginBloc>().add(
                      LogInEvent(
                        state.accessToken,
                      ),
                    );
              }
            },
            builder: (context, state) {
              return _mainBuild(context);
            },
          ),
        ),
      ),
    );
  }

  Column _mainBuild(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 375.w,
          height: 60.h,
          child: TextFormField(
            controller: email,
            maxLines: 1,
            keyboardType: TextInputType.emailAddress,
            onEditingComplete: () {
              FocusScope.of(context).nextFocus();
            },
            onChanged: (value) {
              if (email.text.isNotEmpty && password.text.isNotEmpty) {
                setState(() {
                  validate = true;
                });
              } else {
                setState(() {
                  validate = false;
                });
              }
            },
            decoration: const InputDecoration(
              filled: true,
              fillColor: ColorPalette.white,
              hintText: 'Логин или почта',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 375.w,
          height: 60.h,
          child: TextFormField(
            controller: password,
            maxLines: 1,
            onChanged: (value) {
              if (email.text.isNotEmpty && password.text.isNotEmpty) {
                setState(() {
                  validate = true;
                });
              } else {
                setState(() {
                  validate = false;
                });
              }
            },
            decoration: const InputDecoration(
              filled: true,
              fillColor: ColorPalette.white,
              hintText: 'Пароль',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        MainButton(
          isEnabled: validate,
          title: 'Войти',
          width: 343.w,
          buttonHeight: 64.h,
          onTap: () {
            context
                .read<AuthBloc>()
                .add(EventAuthEmail(email.text, password.text));
          },
          borderRadius: 8.0,
        ),
        SizedBox(height: 15.h),
        MainButton(
          title: 'Зарегистрироваться',
          width: 343.w,
          buttonHeight: 64.h,
          onTap: () {
            context
                .read<AuthBloc>()
                .add(EventAuthEmail(email.text, password.text));
          },
          borderRadius: 8.0,
        ),
      ],
    );
  }
}
