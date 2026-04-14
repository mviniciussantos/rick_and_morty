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

  Future<void> getEpisodes() async {
    if (_isLoading || !_hasNext) return;
    _isLoading = true;
    notifyListeners();
    final result = await _getEpisodesUseCase.call(page: _page);
    switch (result) {
      case Ok():
        _episodes.addAll(result.value.results);
        _page++;
        _hasNext = result.value.hasNext;
        _error = null;
      case Error():
        _error = result.error;
    }
    _isLoading = false;
    notifyListeners();
  }
}
