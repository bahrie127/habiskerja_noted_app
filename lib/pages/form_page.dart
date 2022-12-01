import 'package:flutter/material.dart';
import 'package:flutter_notes_app/utils/notes_database.dart';

import '../models/note.dart';

class FormPage extends StatefulWidget {
  final Note? data;
  const FormPage({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  String? title;
  String? description;

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    if (widget.data != null) {
      titleController.text = widget.data!.title;
      descController.text = widget.data!.description;
    }
    super.initState();
  }

  Future addNote() async {
    final note = Note(
      title: titleController.text,
      description: descController.text,
      time: DateTime.now(),
    );
    await NotesDatabase.instance.create(note);
  }

  Future updateNote() async {
    final note = widget.data!.copyWith(
      title: titleController.text,
      description: descController.text,
    );

    await NotesDatabase.instance.update(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade700,
              ),
              onPressed: () async {
                if (widget.data != null) {
                  updateNote();
                } else {
                  addNote();
                }
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.save,
              ),
              label: Text(widget.data != null ? 'Update' : 'Simpan'),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 2, color: Colors.white70),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 2, color: Colors.white70),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Title',
                  hintStyle: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: descController,
                maxLines: 16,
                style: const TextStyle(
                  color: Colors.white60,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 2, color: Colors.white70),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 2, color: Colors.white70),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'catatan...',
                  hintStyle: const TextStyle(
                    color: Colors.white60,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
