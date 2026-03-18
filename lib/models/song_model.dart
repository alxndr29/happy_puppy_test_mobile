class Song {
  final int? id;
  final String title;
  final String singer;
  final String genre;

  Song({
    this.id,
    required this.title,
    required this.singer,
    required this.genre,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'singer': singer, 'genre': genre};
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      id: map['id'],
      title: map['title'],
      singer: map['singer'],
      genre: map['genre'],
    );
  }
}
