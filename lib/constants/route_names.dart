import '../features/authentication/email_screen.dart';
import '../features/authentication/login_screen.dart';
import '../features/authentication/sign_up_screen.dart';
import '../features/authentication/username_screen.dart';

class RouteNames {
  static String signUp = "/";
  static String username = "/username";
  static String login = "/login";
  static String email = "/email";

  static var routes = {
    signUp: (context) => const SignUpScreen(),
    username: (context) => const UsernameScreen(),
    login: (context) => const LogInScreen(),
    email: (context) => const EmailScreen(),
  };
}
