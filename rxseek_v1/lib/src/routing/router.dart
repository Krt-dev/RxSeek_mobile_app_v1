import "dart:async";

import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:go_router/go_router.dart";
import "package:rxseek_v1/src/Faq/Faq_screen.dart";
import "package:rxseek_v1/src/controllers/auth_controller.dart";
import "package:rxseek_v1/src/enum/enum.dart";
import "package:rxseek_v1/src/screens/disclaimer/disclaimer_screen.dart";
import "package:rxseek_v1/src/screens/home/chat_screen.dart";
import "package:rxseek_v1/src/screens/auth/login.screen.dart";
import "package:rxseek_v1/src/screens/auth/registration.screen.dart";
import "package:rxseek_v1/src/screens/home/home_screen_final.dart";
import "package:rxseek_v1/src/screens/profile/profile_screen.dart";
import "package:rxseek_v1/src/screens/save_threads/save_thread.dart";
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
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const LoginScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: RegistrationScreen.route,
            name: RegistrationScreen.name,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const RegistrationScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              );
            },
          ),
          GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: DisclaimerScreen.route,
              name: DisclaimerScreen.name,
              builder: (context, _) {
                return const DisclaimerScreen();
              }),
          ShellRoute(
              navigatorKey: _shellNavigatorKey,
              routes: [
                GoRoute(
                    parentNavigatorKey: _shellNavigatorKey,
                    path: SaveThreadScreen.route,
                    name: SaveThreadScreen.name,
                    builder: (context, _) {
                      return const SaveThreadScreen();
                    }),
                GoRoute(
                    parentNavigatorKey: _shellNavigatorKey,
                    path: FaqScreen.route,
                    name: FaqScreen.name,
                    builder: (context, _) {
                      return const FaqScreen();
                    }),
                GoRoute(
                  parentNavigatorKey: _shellNavigatorKey,
                  path: ProfileScreen.route,
                  name: ProfileScreen.name,
                  pageBuilder: (context, state) {
                    return CustomTransitionPage(
                      key: state.pageKey,
                      child: const ProfileScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        // Define the start and end points for the slide transition
                        const begin =
                            Offset(1.0, 0.0); // Slide in from the right
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;

                        // Create a tween for the animation
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        // Return the SlideTransition widget
                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    );
                  },
                ),
                GoRoute(
                  parentNavigatorKey: _shellNavigatorKey,
                  path: "${ChatScreen.route}/:threadId",
                  name: ChatScreen.name,
                  pageBuilder: (context, state) {
                    final String threadIdParam =
                        state.pathParameters["threadId"] ?? "";
                    return CustomTransitionPage(
                      key: state.pageKey,
                      child: ChatScreen(threadId: threadIdParam),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    );
                  },
                ),
                GoRoute(
                  parentNavigatorKey: _shellNavigatorKey,
                  path: HomeScreenFinal.route,
                  name: HomeScreenFinal.name,
                  pageBuilder: (context, state) {
                    return CustomTransitionPage(
                      key: state.pageKey,
                      child: const HomeScreenFinal(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin =
                            Offset(-1.0, 0.0); // Slide in from the left
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  },
                ),

                //sample sa pag pass parameters using routers, sauna ni namo na code
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
