import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void onSignUpTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LogInScreen(),
    ));
  }

  void _onEmailTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const UsernameScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
              child: Column(children: [
                Gaps.v32,
                Text(
                  "Sign up for TikTok",
                  style: Theme.of(context).textTheme.headlineSmall,
                  //     style: GoogleFonts.abrilFatface(
                  //   fontSize: Sizes.size24,
                  //   fontWeight: FontWeight.w700,
                  // ),
                ),
                Gaps.v20,
                const Opacity(
                  opacity: .7,
                  child: Text(
                    "Create a profile, follow other accounts, make your own videos, and more.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Sizes.size14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Gaps.v40,
                if (orientation == Orientation.portrait) ...[
                  GestureDetector(
                    onTap: () => _onEmailTap(context),
                    child: const AuthButton(
                        icon: FaIcon(FontAwesomeIcons.user),
                        text: "Use Email & password"),
                  ),
                  Gaps.v16,
                  const AuthButton(
                      icon: FaIcon(FontAwesomeIcons.apple),
                      text: "Continue with Apple"),
                ],
                if (orientation == Orientation.landscape)
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _onEmailTap(context),
                          child: const AuthButton(
                              icon: FaIcon(FontAwesomeIcons.user),
                              text: "Use Email & password"),
                        ),
                      ),
                      Gaps.h16,
                      const Expanded(
                        child: AuthButton(
                            icon: FaIcon(FontAwesomeIcons.apple),
                            text: "Continue with Apple"),
                      ),
                    ],
                  ),
                Gaps.v16,
              ]),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size32,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                    ),
                  ),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => onSignUpTap(context),
                    child: Text(
                      'Log in',
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
      },
    );
  }
}
