import 'package:faker/faker.dart';

Future<void> fakeDelay() {
  final duration = faker.randomGenerator.element(const [
    Duration(milliseconds: 300),
    Duration(milliseconds: 500),
    Duration(milliseconds: 1000),
  ]);
  return Future.delayed(duration);
}

String fakeTrackName() => faker.food.dish();

String fakeAlbumName() => faker.food.dish();

String fakeArtistName() => faker.person.name();
