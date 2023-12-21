import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tiktok_clone/common/widget/video_configuration/video_config.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/router.dart';

import 'constants/sizes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(const TiktokApp());
}

class TiktokApp extends StatelessWidget {
  const TiktokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // S.load(const Locale("en"));
    return ValueListenableBuilder(
      valueListenable: darkLightConfig,
      builder: (context, value, child) => MaterialApp.router(
        routerConfig: router,
        scrollBehavior: MyCustomScrollBehavior(),
        debugShowCheckedModeBanner: false,
        title: 'Tiktok Clone',
        localizationsDelegates: const [
          S.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate
        ],
        supportedLocales: const [
          Locale("en"),
          Locale("ko"),
        ],
        themeMode: darkLightConfig.value,
        theme: ThemeData(
          textTheme: Typography.blackMountainView,
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: const Color(0xFFE9435A),
          splashColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              elevation: 0,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: Sizes.size16 + Sizes.size2,
                fontWeight: FontWeight.w600,
              )),
          useMaterial3: true,
          tabBarTheme: TabBarTheme(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: Colors.black,
          ),
          listTileTheme: const ListTileThemeData(
            iconColor: Colors.black,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          textTheme: Typography.whiteMountainView,
          scaffoldBackgroundColor: Colors.black,
          primaryColor: const Color(0xFFE9435A),
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey.shade900,
          ),
          bottomAppBarTheme: BottomAppBarTheme(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            color: Colors.grey.shade900,
            height: 80,
          ),
          tabBarTheme: const TabBarTheme(
            indicatorColor: Colors.white,
          ),
        ),
        // initialRoute: "/",
        // routes: RouteNames.routes
        // {
        //   "/": (context) => const SignUpScreen(),
        //   "/username": (context) => const UsernameScreen(),
        //   "/login": (context) => const LogInScreen()
        // },
        // home: const SignUpScreen(),
      ),
    );
    // home: const MainNavigationScreen());
  }
}

// web scroll behavior
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
