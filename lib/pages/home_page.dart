import 'package:flutter/material.dart';
import '../models/song_model.dart';
import '../services/song_db.dart';
import '../services/auth_service.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Song> songs = [];

  final titleController = TextEditingController();
  final singerController = TextEditingController();

  String selectedGenre = "Pop";
  int? editId;

  final genres = ["Pop", "Rock", "Jazz"];

  // 🔍 FILTER STATE
  String searchQuery = "";
  String filterGenre = "All";
  String sortBy = "Judul";

  @override
  void initState() {
    super.initState();
    loadSongs();
  }

  // load data
  void loadSongs() async {
    final data = await SongDB.getFiltered(
      search: searchQuery,
      genre: filterGenre,
      sortBy: sortBy,
    );

    setState(() => songs = data);
  }

  void clearForm() {
    titleController.clear();
    singerController.clear();
    selectedGenre = "Pop";
    editId = null;
  }

  void saveSong() async {
    if (titleController.text.isEmpty || singerController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Semua field wajib diisi")));
      return;
    }

    final song = Song(
      id: editId,
      title: titleController.text,
      singer: singerController.text,
      genre: selectedGenre,
    );

    if (editId == null) {
      await SongDB.insert(song);
    } else {
      await SongDB.update(song);
    }

    clearForm();
    loadSongs();
  }

  void editSong(Song song) {
    titleController.text = song.title;
    singerController.text = song.singer;
    selectedGenre = song.genre;
    editId = song.id;
    setState(() {});
  }

  void deleteSong(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Yakin hapus lagu ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () async {
              await SongDB.delete(id);
              Navigator.pop(context);
              loadSongs();
            },
            child: const Text("Hapus"),
          ),
        ],
      ),
    );
  }

  void handleLogout() async {
    await AuthService.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MY SONG"),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: handleLogout),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //input form
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Judul Lagu
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: "Judul Lagu",
                        prefixIcon: Icon(Icons.music_note),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Penyanyi
                    TextField(
                      controller: singerController,
                      decoration: const InputDecoration(
                        labelText: "Penyanyi",
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Genre
                    DropdownButtonFormField(
                      value: selectedGenre,
                      items: genres
                          .map(
                            (g) => DropdownMenuItem(value: g, child: Text(g)),
                          )
                          .toList(),
                      onChanged: (val) {
                        setState(() => selectedGenre = val.toString());
                      },
                      decoration: const InputDecoration(
                        labelText: "Genre",
                        prefixIcon: Icon(Icons.category),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: saveSong,
                        icon: Icon(editId == null ? Icons.add : Icons.update),
                        label: Text(
                          editId == null ? "Tambah Lagu" : "Update Lagu",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            //search
            TextField(
              decoration: const InputDecoration(
                labelText: "Cari Judul Lagu",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                searchQuery = value;
                loadSongs();
              },
            ),

            const SizedBox(height: 10),

            //filter dan sort
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    value: filterGenre,
                    items: ["All", ...genres]
                        .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                        .toList(),
                    onChanged: (val) {
                      filterGenre = val.toString();
                      loadSongs();
                    },
                    decoration: const InputDecoration(
                      labelText: "Filter Genre",
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField(
                    value: sortBy,
                    items: ["Judul", "Penyanyi"]
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (val) {
                      sortBy = val.toString();
                      loadSongs();
                    },
                    decoration: const InputDecoration(labelText: "Urutkan"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            //list lagu
            Expanded(
              child: songs.isEmpty
                  ? const Center(child: Text("Belum ada lagu"))
                  : ListView.builder(
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        final s = songs[index];

                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: const Icon(Icons.music_note),
                            title: Text(
                              s.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text("${s.singer} • ${s.genre}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  ),
                                  onPressed: () => editSong(s),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => deleteSong(s.id!),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
