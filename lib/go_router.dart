import 'package:financeflow/screen/login.dart';
import 'package:financeflow/screen/signUp.dart';
import 'package:financeflow/tools/sessionManager.dart';
import 'package:go_router/go_router.dart';

import 'main.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',

  redirect: (context, state) {
    final loggedIn = SessionManager.isLoggedIn;
    final location = state.matchedLocation;

    final isPublicPage = location == '/login' || location == '/signup';

    if (!loggedIn && !isPublicPage) {
      return '/login';
    }

    if (loggedIn && isPublicPage) {
      return '/';
    }

    return null;
  },

  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(title: "finance flow"),
    ),

    GoRoute(
      name: "login",
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),

    GoRoute(
      name: "Signup",
      path: '/signup',
      builder: (context, state) => SignupPage(),
    ),
  ],
);
