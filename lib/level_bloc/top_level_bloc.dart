import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/network/repository/hive_repository.dart';
import 'package:test_task/screens/auth/bloc/auth_bloc.dart';

import '../main/login_bloc/login_bloc.dart';
import '../network/token/token_repository.dart';

class TopLevelBloc extends StatelessWidget {
  final Widget child;
  const TopLevelBloc({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => LoginBloc(
          context.read<TokensRepository>(),
        )..add(InitialLoginEvent()),
      ),
      BlocProvider(
        create: (context) => AuthBloc(
          hiverepository: context.read<HiveRepository>(),
        ),
      ),
    ], child: child);
  }
}
