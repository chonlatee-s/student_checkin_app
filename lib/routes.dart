import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_checkin_app/pages/checkin_page.dart';
import 'package:student_checkin_app/pages/home_page.dart';
import 'package:student_checkin_app/pages/loading_page.dart';
import 'package:student_checkin_app/pages/login_page.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState state) {
      return const LoadingPage();
    },
  ),
  GoRoute(
    path: '/login',
    builder: (BuildContext context, GoRouterState state) {
      return LoginPage();
    },
  ),
  GoRoute(
    path: '/home',
    builder: (BuildContext context, GoRouterState state) {
      return HomePage();
    },
  ),
  GoRoute(
    path: '/checkin',
    builder: (BuildContext context, GoRouterState state) {
      return const CheckInPage();
    },
  ),
]);
