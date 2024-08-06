import 'dart:async';

import 'package:diggify/features/listen_later/listen_later.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _pageLimit = 25;

final listenLaterListProvider =
    AsyncNotifierProvider.autoDispose<ListenLaterList, ListenLaterListState>(
  ListenLaterList.new,
);

extension type ListenLaterListState(List<ListenLaterItem> items) {
  bool get hasNext => items.isEmpty || items.length % _pageLimit == 0;
  bool get hasReachedEnd => !hasNext;
}

class ListenLaterList extends AutoDisposeAsyncNotifier<ListenLaterListState> {
  @override
  FutureOr<ListenLaterListState> build() async {
    final items = await ref
        .read(listenLaterItemsProvider((limit: _pageLimit, offset: 0)).future);
    return ListenLaterListState(items);
  }

  Future<void> loadMore() async {
    if (state
        case AsyncData(isLoading: false, :final value) ||
            AsyncError(isLoading: false, :final value?) when value.hasNext) {
      final prevState = state;
      state = const AsyncLoading<ListenLaterListState>()
          .copyWithPrevious(prevState, isRefresh: true);
      assert(state is AsyncData && state.isLoading);

      state = await AsyncValue.guard(() async {
        final nextPage = await ref.read(
          listenLaterItemsProvider((
            limit: _pageLimit,
            offset: value.items.length,
          )).future,
        );
        return ListenLaterListState([...value.items, ...nextPage]);
      }).then((state) => state.copyWithPrevious(prevState));
      assert((state is AsyncData && !state.hasError) ||
          (state is AsyncError && state.hasValue));
    }
  }
}
