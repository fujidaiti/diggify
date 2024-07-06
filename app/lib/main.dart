import 'package:diggify/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const _Diggify());
}

class _Diggify extends StatelessWidget {
  const _Diggify();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
    );
  }
}
