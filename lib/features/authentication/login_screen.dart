import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/view_models/social_auth_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/util/global_util.dart';

class LogInScreen extends ConsumerWidget {
  const LogInScreen({super.key});

  void onSignUpTap(BuildContext context) {
    // Navigator.of(context).pop();
    context.pop();
  }

  void _onLoginEmailTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginFormScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(children: [
            Gaps.v80,
            const Text(
              "Log in to TikTok",
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v20,
            const Opacity(
              opacity: .7,
              child: Text(
                "Manage your account, check notifications, comment on videos, and more.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Sizes.size14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Gaps.v40,
            GestureDetector(
              onTap: () => _onLoginEmailTap(context),
              child: const AuthButton(
                  icon: FaIcon(FontAwesomeIcons.user),
                  text: "Use Email & password"),
            ),
            Gaps.v16,
            GestureDetector(
              onTap: () {
                ref.read(socailAuthProvider.notifier).githubSignIn(context);
              },
              child: const AuthButton(
                  icon: FaIcon(FontAwesomeIcons.github),
                  text: "Continue with Github"),
            ),
            Gaps.v16,
          ]),
        ),
      ),
      bottomNavigationBar: Container(
        color:
            isDarkMode(context) ? Colors.grey.shade900 : Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.only(
            top: Sizes.size32,
            bottom: Sizes.size64,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account?",
                style: TextStyle(
                  fontSize: Sizes.size16,
                ),
              ),
              Gaps.h5,
              GestureDetector(
                onTap: () => onSignUpTap(context),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
