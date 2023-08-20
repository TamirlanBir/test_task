import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/network/services/api_service.dart';

import '../network/repository/hive_repository.dart';
import '../network/token/token_repository.dart';

class DependenciesProvider extends StatelessWidget {
  final Widget child;
  const DependenciesProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      RepositoryProvider(
        create: (_) => ApiService(),
      ),
      RepositoryProvider(
        create: (_) => TokensRepository(),
      ),
      RepositoryProvider(
        create: (_) => HiveRepository(),
      ),
    ], child: child);
  }
}
