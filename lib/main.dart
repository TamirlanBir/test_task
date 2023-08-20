import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_task/styles/color_palette.dart';
import 'dependency_initializer/dependency_itializer.dart';
import 'dependency_provider/dependency_provide.dart';
import 'level_bloc/top_level_bloc.dart';
import 'main/login_bloc/login_bloc.dart';
import 'network/repository/hive_repository.dart';
import 'network/token/token_repository.dart';
import 'screens/auth/dynamic_link_layer/dynamic_link_layer.dart';

void main() {
  Future<bool> _initialize(BuildContext context) async {
    try {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      WidgetsFlutterBinding.ensureInitialized();
      final docDir = await getApplicationDocumentsDirectory();
      Hive.init(docDir.path);
      await context.read<HiveRepository>().init();
      await context
          .read<TokensRepository>()
          .init(context.read<HiveRepository>());
    } catch (e) {
      print(e);
      print('this fucked');
      if (kDebugMode) {
        print(e);
      }
    }
    return true;
  }

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return DependenciesProvider(
          child: TopLevelBloc(
            child: MaterialApp(
              title: 'Test',
              debugShowCheckedModeBanner: false,
              home: DependenciesInitializer(
                loadingIndicatorScreen: const Scaffold(
                  backgroundColor: ColorPalette.background,
                  body: Center(
                    child: CircularProgressIndicator(
                      color: ColorPalette.main,
                    ),
                  ),
                ),
                initializer: _initialize,
                child: const MainAuthorization(),
              ),
            ),
          ),
        );
      },
    ),
  );
}

class MainAuthorization extends StatelessWidget {
  const MainAuthorization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is AuthorizedState) {
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (_) => MainAuthorization()),
          //     (route) => route.isFirst);
          // Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      buildWhen: (p, c) =>
          c is LoadingLoginState ||
          c is UnauthorizedState ||
          c is AuthorizedState,
      builder: (context, state) {
        if (state is LoadingLoginState) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          );
        }
        if (state is UnauthorizedState) {
          return const Application(
            isAuthenticated: false,
            key: ValueKey(0),
          );
        }
        if (state is AuthorizedState) {
          return const Application(
            isAuthenticated: true,
            key: ValueKey(1),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class Application extends StatelessWidget {
  final bool isAuthenticated;

  const Application({
    required this.isAuthenticated,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicLinkLayer(isAuthenticated: isAuthenticated);
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
    // return ScreenUtilInit(
    //     designSize: const Size(375, 812),
    //     builder: (context, child) {
    //       return DependenciesProvider(
    //         child: TopLevelBloc(
    //           child: MaterialApp(
    //             title: 'Test',
    //             debugShowCheckedModeBanner: false,
    //             home: Container(),
    //           ),
    //         ),
    //       );
    //     });
//   }
// }
