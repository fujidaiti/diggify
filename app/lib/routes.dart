import 'package:diggify/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

final appRouter = GoRouter(
  initialLocation: const HomeRoute(tab: HomeTab.listenLater).location,
  routes: $appRoutes,
);

@TypedGoRoute<HomeRoute>(path: '/')
class HomeRoute extends GoRouteData {
  const HomeRoute({required this.tab});

  final HomeTab tab;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Home(tab: tab);
  }
}
