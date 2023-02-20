import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:growcery/features/user/userNav.dart';

class AppRoutes{
  var routes = GoRouter(
    initialLocation: '/user',
    routes: [
      GoRoute(
        path: '/user',
        builder: (context, state) => UserNav(),
      ),
    ],
  );
}