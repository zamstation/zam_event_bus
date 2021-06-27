import 'environment.dart';

///
/// Configuration for composing the application.
///
abstract class ComposerConfig {
  Environment get environment;
}

///
/// Test Configuration
///
abstract class TestComposerConfig implements ComposerConfig {
  @override
  final environment = const TestEnvironment();

  const TestComposerConfig();
}

///
/// Prod Configuration
///
abstract class ProdComposerConfig implements ComposerConfig {
  @override
  final environment = const ProdEnvironment();

  const ProdComposerConfig();
}
