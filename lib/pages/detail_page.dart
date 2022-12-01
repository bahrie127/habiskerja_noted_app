import 'package:flutter/material.dart';
import 'package:flutter_notes_app/pages/form_page.dart';
import 'package:flutter_notes_app/utils/notes_database.dart';
import 'package:intl/intl.dart';

import '../models/note.dart';

class DetailPage extends StatefulWidget {
  final Note data;
  const DetailPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Note note;

  @override
  void initState() {
    note = widget.data;
    super.initState();
  }

  Future refreshNote() async {
    note = await NotesDatabase.instance.readNote(widget.data.id!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FormPage(
                    data: note,
                  ),
                ),
              );
              refreshNote();
            },
            icon: const Icon(
              Icons.edit_note_rounded,
            ),
          ),
          IconButton(
            onPressed: () async {
              await NotesDatabase.instance.delete(widget.data.id!);
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.delete_outline_outlined,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
        backgroundColor: Colors.transparent,
        // elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: ListView(
          children: [
            Text(
              note.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              DateFormat('dd MMMM yyyy hh:mm a', 'id_ID').format(note.time),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white38,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              note.description,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
