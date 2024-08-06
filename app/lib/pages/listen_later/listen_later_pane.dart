import 'package:diggify/features/listen_later/listen_later.dart';
import 'package:diggify/pages/listen_later/listen_later_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ListenLaterPane extends ConsumerWidget {
  const ListenLaterPane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(listenLaterListProvider)) {
      AsyncData<ListenLaterListState>(:final value) =>
        _ListenLaterListView(items: value.items),
      // Failed to load the next page, but has items to show.
      AsyncError(:final value?) => _ListenLaterListView(items: value.items),
      AsyncError(:final error) => Center(child: Text('$error')),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}

class _ListenLaterListView extends ConsumerWidget {
  const _ListenLaterListView({
    required this.items,
  });

  final List<ListenLaterItem> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () => ref.refresh(listenLaterListProvider.future),
      child: ListView.builder(
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index < items.length) {
            return switch (items[index]) {
              final ListenLaterTrack track =>
                ListTile(title: Text(track.title)),
              final ListenLaterAlbum album =>
                ListTile(title: Text(album.title)),
              final ListenLaterArtist artist =>
                ListTile(title: Text(artist.name)),
            };
          } else {
            return const _ListenLaterListFooter();
          }
        },
      ),
    );
  }
}

class _ListenLaterListFooter extends ConsumerWidget {
  const _ListenLaterListFooter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onVisibilityChanged(VisibilityInfo visibility) {
      if (ref.context.mounted) {
        final state = ref.read(listenLaterListProvider);
        if (!state.hasError && visibility.visibleFraction > 0.8) {
          ref.read(listenLaterListProvider.notifier).loadMore();
        }
      }
    }

    void onRetry() {
      ref.read(listenLaterListProvider.notifier).loadMore();
    }

    return VisibilityDetector(
      key: const Key('list-footer'),
      onVisibilityChanged: onVisibilityChanged,
      child: switch (ref.watch(listenLaterListProvider)) {
        AsyncData(:final value) when value.hasReachedEnd =>
          const Center(child: Text('No more items')),
        AsyncError() => Center(
            child: Row(
              children: [
                const Text('Failed to load more items'),
                const SizedBox(width: 8),
                TextButton(onPressed: onRetry, child: const Text('Retry')),
              ],
            ),
          ),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      },
    );
  }
}
