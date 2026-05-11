import 'package:flutter/foundation.dart';
import 'package:rick_and_morty/core/result.dart';
import 'package:rick_and_morty/domain/models/episode.dart';
import 'package:rick_and_morty/domain/usecases/get_episodies_usecase.dart';

class EpisodesViewModel extends ChangeNotifier {
  final GetEpisodesUseCase _getEpisodesUseCase;

  EpisodesViewModel(this._getEpisodesUseCase);

  final List<Episode> _episodes = [];

  List<Episode> get episodes => List.unmodifiable(_episodes);

  int _page = 1;
  bool _hasNext = true;
  bool _isLoading = false;
  Exception? _error;

  bool get hasNext => _hasNext;
  bool get isLoading => _isLoading;
  Exception? get error => _error;

  final _seenIds = <int>{};

  Future<void> getEpisodes() async {
    if (_isLoading || !_hasNext) return;
    _isLoading = true;
    notifyListeners();

    var isFirstEmission = true;

    await for (final result in _getEpisodesUseCase.call(page: _page)) {
      switch (result) {
        case Ok():
          final newEpisodes = result.value.results
              .where((e) => _seenIds.add(e.id))
              .toList();
          _episodes.addAll(newEpisodes);

          // Update pagination only on remote data, not on cache emission
          final isRemoteEmission = !isFirstEmission || _page > 1;
          if (isRemoteEmission) {
            _page++;
            _hasNext = result.value.hasNext;
            _isLoading = false;
          }
          _error = null;
        case Error():
          _isLoading = false;
          _error = result.error;
      }
      isFirstEmission = false;
      notifyListeners();
    }
  }
}
