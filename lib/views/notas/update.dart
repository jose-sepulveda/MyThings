import 'package:flutter/material.dart';
import 'package:mythings/models/note.dart';
import 'package:mythings/services/notes.dart';

class UpdateNoteScreen extends StatefulWidget {
  const UpdateNoteScreen({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  get note => null;

  @override
  void initState() {
    titleController.text = widget.note.title;
    contentController.text = widget.note.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Nota'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Contenido'),
              minLines: 5,
              maxLines: 10,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(Colors.deepPurpleAccent),
                  foregroundColor: WidgetStateProperty.all(Colors.black)),
              onPressed: () async {
                // Aquí deberías implementar la lógica para actualizar la nota.
                // Puedes utilizar el método NotesService.updateOne para ello.
                String title = titleController.text;
                String content = contentController.text;

                // Actualiza la nota y luego regresa a la pantalla anterior.
                await NotesService.updateOne(
                  note: widget.note,
                  data: {'title': title, 'content': content},
                );
                if (!mounted) return;
                Navigator.of(context).pop();
              },
              child: const Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
