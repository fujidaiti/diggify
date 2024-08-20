import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as m;

class IconButton extends m.StatelessWidget {
  const IconButton({
    super.key,
    required this.icon,
    this.onPressed,
  });

  final m.IconData icon;
  final VoidCallback? onPressed;

  @override
  m.Widget build(m.BuildContext context) {
    return m.IconButton(
      icon: m.Icon(icon),
      onPressed: onPressed,
    );
  }
}
