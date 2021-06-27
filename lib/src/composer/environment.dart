class Environment {
  final String name;

  const Environment(this.name);

  factory Environment.test() => const TestEnvironment();
  factory Environment.prod() => const ProdEnvironment();
}

class TestEnvironment implements Environment {
  @override
  final String name = 'Test';

  const TestEnvironment();
}

class ProdEnvironment implements Environment {
  @override
  final String name = 'Production';

  const ProdEnvironment();
}
