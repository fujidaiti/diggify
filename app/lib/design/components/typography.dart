import 'package:flutter/material.dart';

class TitleLarge extends StatelessWidget {
  const TitleLarge(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}

class DisplayLarge extends StatelessWidget {
  const DisplayLarge(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.displayLarge,
    );
  }
}

class DisplayMedium extends StatelessWidget {
  const DisplayMedium(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}

class DisplaySmall extends StatelessWidget {
  const DisplaySmall(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}

class HeadlineLarge extends StatelessWidget {
  const HeadlineLarge(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineLarge,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class HeadlineMedium extends StatelessWidget {
  const HeadlineMedium(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineMedium,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class HeadlineSmall extends StatelessWidget {
  const HeadlineSmall(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineSmall,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class TitleMedium extends StatelessWidget {
  const TitleMedium(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class TitleSmall extends StatelessWidget {
  const TitleSmall(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleSmall,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class BodyLarge extends StatelessWidget {
  const BodyLarge(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}

class BodyMedium extends StatelessWidget {
  const BodyMedium(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}

class BodySmall extends StatelessWidget {
  const BodySmall(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}

class LabelLarge extends StatelessWidget {
  const LabelLarge(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class LabelMedium extends StatelessWidget {
  const LabelMedium(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelMedium,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class LabelSmall extends StatelessWidget {
  const LabelSmall(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelSmall,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
