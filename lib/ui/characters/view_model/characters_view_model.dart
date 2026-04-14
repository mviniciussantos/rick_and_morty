import 'package:flutter/foundation.dart';
import 'package:rick_and_morty/core/result.dart';
import 'package:rick_and_morty/domain/models/character.dart';
import 'package:rick_and_morty/domain/usecases/get_characters_usecase.dart';

class CharactersViewModel extends ChangeNotifier {
  final GetCharactersUseCase _getCharactersUseCase;

  CharactersViewModel(this._getCharactersUseCase);

  final List<Character> _characters = [];

  List<Character> get characters => List.unmodifiable(_characters);

  bool _isLoading = false;
  Exception? _error;

  bool get isLoading => _isLoading;
  Exception? get error => _error;

  void clear() {
    _characters.clear();
  }

  Future<void> getCharacters(List<String> ids) async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    final result = await _getCharactersUseCase.call(ids: ids);
    switch (result) {
      case Ok(value: final characters):
        characters.sort((a, b) => a.name.compareTo(b.name));
        _characters.addAll(characters);
        _error = null;
      case Error(error: final error):
        _error = error;
    }
    _isLoading = false;
    notifyListeners();
  }
}
