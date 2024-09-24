import 'dart:ffi';

final class MoviesFavoriteDB {
  final Map<int, bool> _favorites = {};

  void updateFavoriteFor({id = int}) {
    if (_favorites[id] == null) {
      _favorites[id] = true;
    } else {
      _favorites[id] = !_favorites[id]!;
    }
  }

  bool isFavoriteFor({id = int}) {
    return _favorites[id] != null ? _favorites[id]! : false;
  }
}
