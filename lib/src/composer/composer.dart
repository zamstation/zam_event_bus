import '../application/application.dart';
import 'composer.config.dart';

///
/// Utility class to compose modules, build and run app.
///
abstract class Composer {
  ComposerConfig get config;

  ///
  /// Use this if you want to run the app manually.
  ///
  Application buildApp();

  ///
  /// Builds and runs the app
  ///
  Future<Object?> runApp() async {
    final application = buildApp();
    await application.initialize();
    return application.run();
  }
}
