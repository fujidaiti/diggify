import 'package:diggify/fake/fake.dart';
import 'package:diggify/routes.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      overrides: fakes,
      child: const _Diggify(),
    ),
  );
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
