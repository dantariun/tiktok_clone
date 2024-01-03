import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widget/main_navigation_screen.dart';
import 'package:tiktok_clone/constants/route_names.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/chat_detail_screen.dart';
import 'package:tiktok_clone/features/inbox/chats_screen.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';

import 'features/videos/views/video_recording_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: "/home",
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      if (!isLoggedIn) {
        if (state.subloc != RouteNames.signUpURL &&
            state.subloc != RouteNames.loginURL) {
          return RouteNames.signUpURL;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        name: RouteNames.signUpName,
        path: RouteNames.signUpURL,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        name: RouteNames.loginName,
        path: RouteNames.loginURL,
        builder: (context, state) => const LogInScreen(),
      ),
      GoRoute(
        name: RouteNames.interestsName,
        path: RouteNames.interestsURL,
        builder: (context, state) => const InterestsScreen(),
      ),
      GoRoute(
        path: "/:tab(home|discover|inbox|profile)",
        name: RouteNames.mainNavigationName,
        builder: (context, state) {
          final tab = state.params["tab"]!;
          return MainNavigationScreen(
            tab: tab,
          );
        },
      ),
      GoRoute(
        path: RouteNames.activityURL,
        name: RouteNames.activityName,
        builder: (context, state) => const ActivityScreen(),
      ),
      GoRoute(
        path: RouteNames.chataURL,
        name: RouteNames.chatsName,
        builder: (context, state) => const ChatsScreen(),
        routes: [
          GoRoute(
            path: RouteNames.chataDetailURL,
            name: RouteNames.chatsDetailName,
            builder: (context, state) {
              final chatId = state.params["chatId"]!;
              return ChatDetailScreen(chatId: chatId);
            },
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.postVideoURL,
        name: RouteNames.postVideoName,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const VideoRecordingScreen(),
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final position = Tween(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation);
            return SlideTransition(
              position: position,
              child: child,
            );
          },
        ),
      ),
    ],
  );
});
