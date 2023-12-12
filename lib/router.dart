import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/args.dart';
import 'package:tiktok_clone/constants/route_names.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/user/user_profile_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: RouteNames.signUp,
      path: RouteNames.signUpURL,
      builder: (context, state) => const SignUpScreen(),
      routes: [
        GoRoute(
            name: RouteNames.username,
            path: RouteNames.usernameURL,
            builder: (context, state) => const UsernameScreen(),
            routes: [
              GoRoute(
                name: RouteNames.email,
                path: RouteNames.emailURL,
                builder: (context, state) {
                  final args = state.extra as EmailScreenArgs;
                  return EmailScreen(username: args.username);
                },
              ),
            ])
      ],
    ),
    // GoRoute(
    //   path: RouteNames.login,
    //   builder: (context, state) => const LogInScreen(),
    // ),
    // GoRoute(
    //   name: "username_screen",
    //   path: RouteNames.username,
    //   pageBuilder: (context, state) {
    //     return CustomTransitionPage(
    //       child: const UsernameScreen(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return FadeTransition(
    //           opacity: animation,
    //           child: ScaleTransition(
    //             scale: animation,
    //             child: child,
    //           ),
    //         );
    //       },
    //     );
    //   },
    // ),

    GoRoute(
      path: "/users/:username",
      builder: (context, state) {
        final username = state.params['username'];
        final tab = state.queryParams['show'] ?? "";
        return UserProfileScreen(
          username: username!,
          tab: tab,
        );
      },
    )
  ],
);
