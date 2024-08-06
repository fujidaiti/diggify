import 'package:diggify/features/listen_later/listen_later.dart';
import 'package:diggify/pages/listen_later/listen_later_list.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ListenLaterView extends ConsumerWidget {
  const ListenLaterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(listenLaterListProvider)) {
      AsyncData(value: ListenLaterList(isEmpty: true)) =>
        const _NoContentView(),
      AsyncData(:final value) => _ListenLaterListView(items: value),
      // Failed to load the next page, but has items to show.
      AsyncError(hasValue: true, :final value?) =>
        _ListenLaterListView(items: value),
      // Failed to load the first page.
      AsyncError(isLoading: false, hasValue: false) =>
        const _InitialLoadErrorView(),
      _ => const _InitialLoadView(),
    };
  }
}

class _ListenLaterListView extends ConsumerWidget {
  const _ListenLaterListView({
    required this.items,
  });

  final IList<ListenLaterItem> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: ref.watch(listenLaterListProvider.notifier).refresh,
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
    void tryLoadMore(VisibilityInfo visibility) {
      if (ref.context.mounted) {
        final state = ref.read(listenLaterListProvider);
        if (!state.hasError && visibility.visibleFraction > 0.8) {
          ref.read(listenLaterListProvider.notifier).loadMore();
        }
      }
    }

    void retry() {
      ref.read(listenLaterListProvider.notifier).loadMore();
    }

    return VisibilityDetector(
      key: const Key('list-footer'),
      onVisibilityChanged: tryLoadMore,
      child: switch (ref.watch(listenLaterListProvider)) {
        AsyncData(:final value) when value.hasReachedEnd =>
          const Center(child: Text('No more items')),
        AsyncError() => Center(
            child: Row(
              children: [
                const Text('Failed to load more items'),
                const SizedBox(width: 8),
                TextButton(onPressed: retry, child: const Text('Retry')),
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

class _InitialLoadErrorView extends ConsumerWidget {
  const _InitialLoadErrorView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Something went wrong...'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: ref.watch(listenLaterListProvider.notifier).refresh,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class _InitialLoadView extends StatelessWidget {
  const _InitialLoadView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _NoContentView extends ConsumerWidget {
  const _NoContentView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return RefreshIndicator(
          onRefresh: ref.watch(listenLaterListProvider.notifier).refresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox.fromSize(
              size: constraints.biggest,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.hourglass_empty, size: 64),
                    SizedBox(height: 16),
                    Text('No items to show'),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
