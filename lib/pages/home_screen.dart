import 'package:flutter/material.dart';
import 'package:flutter_notes_app/pages/form_page.dart';
import 'package:flutter_notes_app/pages/login_page.dart';
import 'package:flutter_notes_app/utils/notes_database.dart';
import 'package:flutter_notes_app/utils/user_shared_preferences.dart';
import 'package:flutter_notes_app/widgets/card_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/note.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [
    Note(
        id: 1,
        title: 'Belanja',
        description:
            '''Sementara itu pada hari Minggu, 21 Agustus 2022 akan ada pertandingan seru lain yang juga disiarkan SCTV, yakni duel Newcastle vs Manchester City mulai pukul 22.30 WIB.

Newcastle dan Manchester City dalam dua pertandingan pertama sejauh ini belum terkalahkan di Liga Inggris. Manchester City dua kali menang dan sedang memuncaki klasemen sementara Liga Inggris 2022 dengan 6 poin.

Sedangkan Newcastle ada di posisi kelima klasemen Premier League dengan 4 poin dari dua pertandingan pertama. Empat poin itu hasil dari kemenangan atas Nottingham Forest di pekan pertama, dan imbang tanpa gol melawan Brighton.

Tak hanya untuk menarik melihat siapa yang bakal mendapatkan kekalahan pertama, duel Newcastle vs Manchester City selalu diwarnai banyak gol. Total dari lima duel terakhir di Premier League, ada total pada pertemuan Newcastle vs Man City tercipta 23 gol.
Sementara itu pada hari Minggu, 21 Agustus 2022 akan ada pertandingan seru lain yang juga disiarkan SCTV, yakni duel Newcastle vs Manchester City mulai pukul 22.30 WIB.

Newcastle dan Manchester City dalam dua pertandingan pertama sejauh ini belum terkalahkan di Liga Inggris. Manchester City dua kali menang dan sedang memuncaki klasemen sementara Liga Inggris 2022 dengan 6 poin.

Sedangkan Newcastle ada di posisi kelima klasemen Premier League dengan 4 poin dari dua pertandingan pertama. Empat poin itu hasil dari kemenangan atas Nottingham Forest di pekan pertama, dan imbang tanpa gol melawan Brighton.

Tak hanya untuk menarik melihat siapa yang bakal mendapatkan kekalahan pertama, duel Newcastle vs Manchester City selalu diwarnai banyak gol. Total dari lima duel terakhir di Premier League, ada total pada pertemuan Newcastle vs Man City tercipta 23 gol.
 20 gol untuk The Citizens, dan hanya 3 gol yang diciptakan The Magpies ke gawang City.''',
        time: DateTime.now()),
    Note(
        id: 1,
        title: 'Bensin',
        description: 'kesuperindo habis 1juta',
        time: DateTime.now()),
    Note(
        id: 1,
        title: 'Futsal',
        description: 'kesuperindo habis 1juta',
        time: DateTime.now()),
    Note(
        id: 1,
        title: 'Work',
        description: 'kesuperindo habis 1juta',
        time: DateTime.now()),
    Note(
        id: 1,
        title: 'Lari',
        description: 'kesuperindo habis 1juta',
        time: DateTime.now()),
  ];
  bool isLoading = false;

  Future refreshNotes() async {
    setState(() {
      isLoading = true;
    });
    notes = await NotesDatabase.instance.readAllNotes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    refreshNotes();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    NotesDatabase.instance.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Catatan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginPage();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.exit_to_app),
              label: const Text('Keluar'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade800,
              ),
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(
                16,
              ),
              child: notes.isEmpty
                  ? const Center(
                      child: Text(
                        'Belum ada catatan',
                        style: TextStyle(fontSize: 24, color: Colors.white60),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailPage(data: notes[index]),
                              ),
                            );
                            refreshNotes();
                          },
                          child: CardWidget(
                            index: index,
                            data: notes[index],
                          ),
                        );
                      },
                      itemCount: notes.length,
                    ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const FormPage(data: null),
            ),
          );
          refreshNotes();
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.note_add,
        ),
      ),
    );
  }
}
