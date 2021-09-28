import 'package:zam_core/core.dart';

import '../application/application.dart';
import 'composer.config.dart';

///
/// Utility class to compose modules, build and run app.
///
abstract class Composer implements AsyncRunnable {
  ComposerConfig get config;

  ///
  /// Use this if you want to run the app manually.
  ///
  Application build();

  ///
  /// Builds and runs the app
  ///
  @override
  Future<Object?> run() async {
    final application = build();
    await application.initialize();
    return application.run();
  }
}
