import 'dart:async';

import 'package:diggify/features/listen_later/listen_later.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _pageLimit = 25;

final listenLaterListProvider =
    AsyncNotifierProvider.autoDispose<ListenLaterListNotifier, ListenLaterList>(
  ListenLaterListNotifier.new,
);

extension type ListenLaterList(IList<ListenLaterItem> self)
    implements IList<ListenLaterItem> {
  bool get hasNext => self.isEmpty || self.length % _pageLimit == 0;
  bool get hasReachedEnd => !hasNext;
}

/// A [Notifier] that progressively loads items for the Listen Later list.
///
/// Each state of the pagination is represented by [AsyncValue] as follows:
/// - **Loading** : Fetching the first page, or refreshing after either
///   an error state or an empty list. Represented by `AsyncLoading()`.
/// - **LoadingWithPrevious** : Fetching the next page, or refreshing after
///   non-error state. Represented by `AsyncData(isLoading: true)`.
/// - **Loaded** : Pages have been successfully fetched without errors.
///   Represented by `AsyncData()`.
/// - **FailedInitialLoad** : Failed to fetch the first page. Represented by
///  `AsyncError()`.
/// - **FailedLoadMore** : Failed to fetch a subsequent page. Represented by
///  `AsyncError(hasValue: true)`.
class ListenLaterListNotifier
    extends AutoDisposeAsyncNotifier<ListenLaterList> {
  late GetListenLaterItems _getItems;

  /// Fetches the first page.
  @override
  FutureOr<ListenLaterList> build() async {
    _getItems = ref.watch(getListenLaterItemsProvider);
    final items = await _getItems(offset: 0, limit: _pageLimit);
    return ListenLaterList(items.lock);
  }

  /// Fetches a subsequent page.
  ///
  /// While loading, the state is set to `AsyncData(isLoading: true)`
  /// and eventually transitions to `AsyncData()` if it succeeds.
  /// Otherwise, it transitions to `AsyncError(hasValue: true)`
  /// retaining the previous items.
  Future<void> loadMore() async {
    final prevItems = state.valueOrNull;
    if (!state.isLoading && prevItems != null && prevItems.hasNext) {
      final prevState = state;
      state = const AsyncLoading<ListenLaterList>()
          .copyWithPrevious(AsyncData(prevItems), isRefresh: true);
      assert(state is AsyncData && state.isLoading);

      state = await AsyncValue.guard(() async {
        final nextItems =
            await _getItems(limit: _pageLimit, offset: prevItems.length);
        return ListenLaterList([...prevItems, ...nextItems].lock);
      }).then(
        // This ensures that the previous items are kept
        // even if the new state is an AsyncError.
        (state) => state.copyWithPrevious(prevState),
      );
      assert((state is AsyncData && !state.hasError) ||
          (state is AsyncError && state.hasValue));
    }
  }

  /// Discards the current items and fetches the first page again.
  /// 
  /// While loading, the state is set to either:
  /// - `AsyncLoading()` if the previous state was an error or an empty list, or
  /// - `AsyncData(isLoading: true)` otherwise.
  Future<void> refresh() async {
    if (!state.isLoading) {
      final prevItems = state.valueOrNull;
      state = state.hasError || prevItems == null || prevItems.isEmpty
          ? const AsyncLoading<ListenLaterList>()
          : const AsyncLoading<ListenLaterList>()
              .copyWithPrevious(AsyncData(prevItems), isRefresh: true);
      assert(state is AsyncLoading || (state is AsyncData && state.isLoading));

      state = await AsyncValue.guard(() async {
        final items = await _getItems(offset: 0, limit: _pageLimit);
        return ListenLaterList(items.lock);
      });
    }
  }
}
