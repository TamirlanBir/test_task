import '../repository/hive_repository.dart';

class TokensRepository {
  late final HiveRepository _hiveRepository;

  String _accessToken = '';
  String _refreshToken = '';

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;

  Future<void> init(HiveRepository hiveRepository) async {
    _hiveRepository = hiveRepository;
    final tokens = _hiveRepository.getTokens();
    _accessToken = tokens.accessToken;
    _refreshToken = tokens.refreshToken;
  }

  bool hasToken() => accessToken.isNotEmpty;

  Future<void> save(String accessToken) async {
    _accessToken = accessToken;
    await _hiveRepository.saveTokens(accessToken, refreshToken);
    _accessToken = accessToken;
  }

  Future<bool> delete() async {
    try {
      await _hiveRepository.saveTokens('', '');
      _accessToken = '';
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
