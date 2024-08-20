import 'package:diggify/fake/utils.dart';
import 'package:diggify/features/listen_later/listen_later.dart';
import 'package:faker/faker.dart';

final fakeGetListenLaterItemsProvider = getListenLaterItemsProvider
    .overrideWithValue(const _FakeGetListenLaterItems());

class _FakeGetListenLaterItems implements GetListenLaterItems {
  const _FakeGetListenLaterItems();

  @override
  Future<List<ListenLaterItem>> call({
    required int limit,
    required int offset,
  }) async {
    await fakeDelay();
    final prob = faker.randomGenerator.decimal();
    final itemCount = switch (prob) {
      < 0.1 => throw Exception('Something went wrong!'),
      < 0.8 => limit,
      _ => limit / 2,
    };
    return [
      for (var i = 0; i < itemCount; i++)
        switch (faker.randomGenerator.decimal()) {
          < 0.5 => _fakeTrack(),
          < 0.8 => _fakeAlbum(),
          _ => _fakeArtist(),
        }
    ];
  }
}

ListenLaterTrack _fakeTrack() {
  return ListenLaterTrack(
    mediaId: faker.guid.guid(),
    addedAt: DateTime.now(),
    thumbnail: Uri.parse(faker.image.image()),
    title: fakeTrackName(),
    album: AboutAlbum(
      mediaId: faker.guid.guid(),
      title: faker.lorem.sentence(),
      releaseYear: faker.randomGenerator.integer(2024, min: 1960),
      thumbnail: Uri.parse(faker.image.image()),
    ),
    artists: [
      AboutArtist(
        mediaId: faker.guid.guid(),
        name: faker.person.name(),
        thumbnail: Uri.parse(faker.image.image()),
      ),
    ],
  );
}

ListenLaterAlbum _fakeAlbum() {
  return ListenLaterAlbum(
    mediaId: faker.guid.guid(),
    addedAt: DateTime.now(),
    thumbnail: Uri.parse(faker.image.image()),
    title: faker.lorem.sentence(),
    releaseYear: faker.randomGenerator.integer(2024, min: 1960),
    artists: [
      AboutArtist(
        mediaId: faker.guid.guid(),
        name: faker.person.name(),
        thumbnail: Uri.parse(faker.image.image()),
      ),
    ],
  );
}

ListenLaterArtist _fakeArtist() {
  return ListenLaterArtist(
    mediaId: faker.guid.guid(),
    addedAt: DateTime.now(),
    thumbnail: Uri.parse(faker.image.image()),
    name: faker.person.name(),
  );
}
