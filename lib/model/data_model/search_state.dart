import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'media_model/media_model.dart';

class SearchState {
  final AsyncValue<List<Result>> mediaList;
  final bool loading;

  SearchState({
    required this.mediaList,
    this.loading = false,
  });

  SearchState copyWith({
    AsyncValue<List<Result>>? mediaList,
    bool? loading,
  }) {
    return SearchState(
      mediaList: mediaList ?? this.mediaList,
      loading: loading ?? this.loading,
    );
  }
}
