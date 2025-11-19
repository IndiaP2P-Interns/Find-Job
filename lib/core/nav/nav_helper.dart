import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavHelper {
  static void goTo(BuildContext context, String route) => context.go(route);

  static void goToWithExtra(
    BuildContext context,
    String route,
    dynamic extra,
  ) => context.go(route, extra: extra);

  static void push(BuildContext context, String route) => context.push(route);

  static void replace(BuildContext context, String route) =>
      context.pushReplacement(route);

  static void clearAndGo(BuildContext context, String route) =>
      context.go(route);

  static void back(BuildContext context) => context.pop();
}
