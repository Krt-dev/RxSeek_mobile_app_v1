import "dart:async";

import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:go_router/go_router.dart";
import "package:rxseek_v1/src/controllers/auth_controller.dart";
import "package:rxseek_v1/src/enum/enum.dart";
import "package:rxseek_v1/src/screens/disclaimer/disclaimer_screen.dart";
import "package:rxseek_v1/src/screens/home/home_screen.dart";
import "package:rxseek_v1/src/screens/auth/login.screen.dart";
import "package:rxseek_v1/src/screens/auth/registration.screen.dart";
import "package:rxseek_v1/src/screens/profile/profile_screen.dart";
import "package:rxseek_v1/src/screens/splash/splash_screen.dart";
import "package:rxseek_v1/src/screens/wrapper/wrapperScreen.dart";

/// https://pub.dev/packages/go_router

class GlobalRouter {
  // Static method to initialize the singleton in GetIt
  static void initialize() {
    GetIt.instance.registerSingleton<GlobalRouter>(GlobalRouter());
  }

  // Static getter to access the instance through GetIt
  static GlobalRouter get instance => GetIt.instance<GlobalRouter>();

  static GlobalRouter get I => GetIt.instance<GlobalRouter>();

  late GoRouter router;
  late GlobalKey<NavigatorState> _rootNavigatorKey;
  late GlobalKey<NavigatorState> _shellNavigatorKey;

  FutureOr<String?> handleRedirect(
      BuildContext context, GoRouterState state) async {
    if (AuthController.I.state == AuthState.authenticated) {
      if (state.matchedLocation == LoginScreen.route) {
        return DisclaimerScreen.route;
      }
      if (state.matchedLocation == RegistrationScreen.route) {
        return DisclaimerScreen.route;
      }
      return null;
    }
    if (AuthController.I.state != AuthState.authenticated) {
      if (state.matchedLocation == LoginScreen.route) {
        return null;
      }
      if (state.matchedLocation == RegistrationScreen.route) {
        return null;
      }
      return SplashScreen.route;
    }
    return null;
  }

  GlobalRouter() {
    _rootNavigatorKey = GlobalKey<NavigatorState>();
    _shellNavigatorKey = GlobalKey<NavigatorState>();
    router = GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: SplashScreen.route,
        redirect: handleRedirect,
        refreshListenable: AuthController.I,
        routes: [
          GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: SplashScreen.route,
              name: SplashScreen.name,
              builder: (context, _) {
                return const SplashScreen();
              }),
          GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: LoginScreen.route,
              name: LoginScreen.name,
              builder: (context, _) {
                return const LoginScreen();
              }),
          GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: RegistrationScreen.route,
              name: RegistrationScreen.name,
              builder: (context, _) {
                return const RegistrationScreen();
              }),
          GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: DisclaimerScreen.route,
              name: DisclaimerScreen.name,
              builder: (context, _) {
                return const DisclaimerScreen();
              }),

          //for testing rani sa profile need pani i balhin sa hellroute kay dapat naa ni nav bar

          ShellRoute(
              navigatorKey: _shellNavigatorKey,
              routes: [
                GoRoute(
                    parentNavigatorKey: _shellNavigatorKey,
                    path: ProfileScreen.route,
                    name: ProfileScreen.name,
                    builder: (context, _) {
                      return const ProfileScreen();
                    }),
                GoRoute(
                    parentNavigatorKey: _shellNavigatorKey,
                    path: HomeScreen.route,
                    name: HomeScreen.name,
                    builder: (context, _) {
                      return const HomeScreen();
                    }),
                // GoRoute(
                //   parentNavigatorKey: _shellNavigatorKey,
                //   path: "${GameScreen.route}/:gameId/:playerId",
                //   name: GameScreen.name,
                //   builder: (context, state) {
                //     final String gameId = state.pathParameters['gameId'] ?? "";
                //     final String playerId =
                //         state.pathParameters['playerId'] ?? "";
                //     return GameScreen(
                //       gameId: gameId,
                //       playerId: playerId,
                //     );
                //   },
                // ),
              ],
              builder: (context, state, child) {
                return HomeWrapper(child: child);
              }),
        ]);
  }
}
