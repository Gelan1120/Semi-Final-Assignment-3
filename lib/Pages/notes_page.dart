import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smthree/Model/notes_model.dart';
import 'package:smthree/Pages/notes_add.dart';
import 'package:smthree/notes_card.dart';
import 'package:smthree/Database/notes_db.dart';
import 'package:smthree/Pages/notes_details.dart';
import 'package:lottie/lottie.dart';

class NotesPage extends StatefulWidget {

  const NotesPage({super.key});

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  late List<NotesModel> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    notes = await NotesDatabase.instance.readAllNotes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: const Icon(Icons.list_rounded, color: Colors.black),
      title: const Text('Notes',
        style: TextStyle(
            fontSize: 24, color: Colors.black,
        ),
      ),
    ),
    body: Center(
      child: isLoading
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animation/loading-list.json',
            repeat: true,
            fit: BoxFit.cover,
          )
        ],
      )
          : notes.isEmpty
          ? const Text( 'No Notes',
        style: TextStyle(
            color: Colors.white,
            fontSize: 24),
      )
          : buildNotes(),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.black,
      foregroundColor: Colors.amber,
      child: const Icon(Icons.add),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddNotesPage()),
        );

        refreshNotes();
      },
    ),
  );

  Widget buildNotes() => StaggeredGridView.countBuilder(
    padding: const EdgeInsets.all(8),
    itemCount: notes.length,
    staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
    crossAxisCount: 4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    itemBuilder: (context, index) {
      final note = notes[index];

      return GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NoteDetailPage(noteId: note.id!),
          ));

          refreshNotes();
        },
        child: NoteCardWidget(
            note: note,
            index: index),
      );
    },
  );
}
