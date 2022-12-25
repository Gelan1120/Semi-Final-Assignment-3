import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smthree/Database/notes_db.dart';
import 'package:smthree/Model/notes_model.dart';
import 'package:smthree/Pages/notes_form.dart';

class AddNotesPage extends StatefulWidget {
  final NotesModel? note;

  const AddNotesPage({
    Key? key,
    this.note,
  }) : super(key: key);
  @override
  _AddNotesPageState createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      foregroundColor: Colors.amber,
      actions: [buildButton()],
    ),
    body: Form(
      key: _formKey,
      child: NotesForm(
        title: title,
        description: description,
        onChangedTitle: (title) => setState(() => this.title = title),
        onChangedDescription: (description) =>
            setState(() => this.description = description),
      ),
    ),
  );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: isFormValid ? null : Colors.amber,
        ),
        onPressed:addOrUpdateNote,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      title: title,
      description: description,
    );

    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = NotesModel(
      title: title,
      description: description,
      createdTime: DateTime.now(),
    );

    await NotesDatabase.instance.create(note);
  }
}
