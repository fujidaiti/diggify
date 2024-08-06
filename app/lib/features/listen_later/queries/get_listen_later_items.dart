import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'get_listen_later_items.freezed.dart';

@freezed
sealed class ListenLaterItem with _$ListenLaterItem {
  @Assert('artists.length > 0', 'At least one artist is required')
  const factory ListenLaterItem.track({
    required String mediaId,
    required DateTime addedAt,
    required Uri thumbnail,
    required String title,
    required AboutAlbum album,
    required List<AboutArtist> artists,
  }) = ListenLaterTrack;

  @Assert('artists.length > 0', 'At least one artist is required')
  const factory ListenLaterItem.album({
    required String mediaId,
    required DateTime addedAt,
    required Uri thumbnail,
    required String title,
    required int releaseYear,
    required List<AboutArtist> artists,
  }) = ListenLaterAlbum;

  const factory ListenLaterItem.artist({
    required String mediaId,
    required DateTime addedAt,
    required Uri thumbnail,
    required String name,
  }) = ListenLaterArtist;
}

@freezed
class AboutAlbum with _$AboutAlbum {
  const factory AboutAlbum({
    required String mediaId,
    required String title,
    required int releaseYear,
    required Uri thumbnail,
  }) = _AboutAlbum;
}

@freezed
class AboutArtist with _$AboutArtist {
  const factory AboutArtist({
    required String mediaId,
    required String name,
    required Uri thumbnail,
  }) = _AboutArtist;
}

final listenLaterItemsProvider =
    FutureProvider.autoDispose.family((ref, ({int limit, int offset}) _) async {
  return const <ListenLaterItem>[];
});
