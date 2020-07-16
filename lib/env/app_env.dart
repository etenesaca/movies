abstract class AppEnvironment {
  static String headerKey;
  static String baseApiUrl;

  static setupEnv(Environment env) {
    switch (env) {
      case Environment.dev:
        {
          headerKey = 'Authorization';
          baseApiUrl = 'https://api-todo-flutter.herokuapp.com';

          break;
        }
      case Environment.prod: {
        headerKey = 'Authorization';
        baseApiUrl = 'https://api-todo-flutter.herokuapp.com';
        break;
      }
    }
  }


}

enum Environment {
  dev,
  prod
}