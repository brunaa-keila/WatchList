final class MoviesFavoriteDB {
  final Map<int, bool> _favorites = {};

  void updateFavoriteFor({required int id}) {
    if (_favorites[id] == null) {
      _favorites[id] = true;
    } else {
      _favorites[id] = !_favorites[id]!;
    }
  }

  bool isFavoriteFor({required int id}) {
    return _favorites[id] != null ? _favorites[id]! : false;
  }

  List<int> getAllFavoriteIds() {
    return _favorites.keys.where((id) => _favorites[id] == true).toList();
  }
}
