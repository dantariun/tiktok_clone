import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/util/global_util.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void onSignUpTap(BuildContext context) async {
    // await Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => const LogInScreen(),
    // ));

    // await Navigator.of(context).pushNamed(RouteNames.login);
    // context.push(RouteNames.login);
  }

  void _onEmailTap(BuildContext context) {
    /* Navigator.of(context).push(
      // MaterialPageRoute(
      //   builder: (context) => const UsernameScreen(),
      // ),
      PageRouteBuilder(
          transitionDuration: const Duration(seconds: 1),
          reverseTransitionDuration: const Duration(seconds: 1),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const UsernameScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final offSetAnimation = Tween(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(animation);
            final opacityAnimation = Tween(
              begin: 0.5,
              end: 1.0,
            ).animate(animation);
            return SlideTransition(
              position: offSetAnimation,
              child: FadeTransition(
                opacity: opacityAnimation,
                child: child,
              ),
            );
          }),
    ); */
    // Navigator.of(context).pushNamed(RouteNames.username);
    // context.push(RouteNames.username);
    // context.pushNamed("username_screen");
    // context.push("/users/pepper?show=likes");
    // context.pushNamed(RouteNames.username);
  }

  @override
  Widget build(BuildContext context) {
    // S.load(const Locale("en"));
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
              child: Column(children: [
                Gaps.v32,
                Text(
                  S.of(context).signUpTitle("TikTok", DateTime.now()),
                  style: Theme.of(context).textTheme.headlineSmall,
                  //     style: GoogleFonts.abrilFatface(
                  //   fontSize: Sizes.size24,
                  //   fontWeight: FontWeight.w700,
                  // ),
                ),
                Gaps.v20,
                Opacity(
                  opacity: .7,
                  child: Text(
                    S.of(context).signUpSubtitle(2),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: Sizes.size14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Gaps.v40,
                if (orientation == Orientation.portrait) ...[
                  GestureDetector(
                    onTap: () => _onEmailTap(context),
                    child: AuthButton(
                      icon: const FaIcon(FontAwesomeIcons.user),
                      text: S.of(context).emailPasswordButton,
                    ),
                  ),
                  Gaps.v16,
                  AuthButton(
                    icon: const FaIcon(FontAwesomeIcons.apple),
                    text: S.of(context).appleButton,
                  ),
                ],
                if (orientation == Orientation.landscape)
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _onEmailTap(context),
                          child: AuthButton(
                              icon: const FaIcon(FontAwesomeIcons.user),
                              text: S.of(context).emailPasswordButton),
                        ),
                      ),
                      Gaps.h16,
                      Expanded(
                        child: AuthButton(
                          icon: const FaIcon(FontAwesomeIcons.apple),
                          text: S.of(context).appleButton,
                        ),
                      ),
                    ],
                  ),
                Gaps.v16,
              ]),
            ),
          ),
          bottomNavigationBar: Container(
            color: isDarkMode(context)
                ? Colors.grey.shade900
                : Colors.grey.shade200,
            child: Padding(
              padding: const EdgeInsets.only(
                top: Sizes.size32,
                bottom: Sizes.size64,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).alreadyHaveAnAccount,
                    style: const TextStyle(
                      fontSize: Sizes.size16,
                    ),
                  ),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => onSignUpTap(context),
                    child: Text(
                      S.of(context).logIn("male"),
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
