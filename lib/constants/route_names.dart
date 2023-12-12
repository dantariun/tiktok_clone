import '../features/authentication/login_screen.dart';
import '../features/authentication/sign_up_screen.dart';
import '../features/authentication/username_screen.dart';

class RouteNames {
  static String signUpURL = "/";
  static String signUp = "signUp";

  static String username = "username";
  static String usernameURL = "username";
  static String login = "/login";
  static String email = "email";
  static String emailURL = "email";

  static var routes = {
    signUp: (context) => const SignUpScreen(),
    username: (context) => const UsernameScreen(),
    login: (context) => const LogInScreen(),
    // email: (context) => const EmailScreen(),
  };
}
