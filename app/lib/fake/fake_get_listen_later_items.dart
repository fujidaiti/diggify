import 'package:diggify/features/listen_later/listen_later.dart';

final fakeListenLaterItemsProvider = listenLaterItemsProvider
    .overrideWith((ref, ({int limit, int offset}) params) async {
  await Future<dynamic>.delayed(const Duration(milliseconds: 700));
  final itemCount = params.offset > 50 ? params.limit - 1 : params.limit;
  return [
    for (var i = 0; i < itemCount; i++)
      ListenLaterItem.track(
        mediaId: i.toString(),
        addedAt: DateTime.now(),
        thumbnail: Uri.parse('https://example.com/$i.jpg'),
        title: 'Track $i',
        album: AboutAlbum(
          mediaId: 'album_$i',
          title: 'Album $i',
          releaseYear: 2021,
          thumbnail: Uri.parse('https://example.com/album_$i.jpg'),
        ),
        artists: [
          AboutArtist(
            mediaId: 'artist_$i',
            name: 'Artist $i',
            thumbnail: Uri.parse('https://example.com/artist_$i.jpg'),
          ),
        ],
      ),
  ];
});
