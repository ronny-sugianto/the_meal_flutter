/// Build-time environment configs
///
/// These values are coming from `--dart-define` command arguments
class EnvConfig {
  static const BASE_URL = String.fromEnvironment(
    'BASE_URL',
  );
}
