import 'package:flutter/material.dart';
import 'package:mythings/models/note.dart';

class NoteViewSmall extends StatelessWidget {
  const NoteViewSmall({
    super.key,
    required this.note,
    this.onEdit,
    this.onDelete,
  });

  final Note note;
  final Function? onEdit;
  final Function? onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 4, 100, 225),
      child: ListTile(
        title: Text(note.title, style: TextStyle(fontSize: 24),),
        textColor: Colors.white,
        trailing: PopupMenuButton(
            color: Colors.black,
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text('Editar',),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Text('Eliminar'),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                //Editar
                onEdit?.call();
              } else if (value == 1) {
                //Eliminar
                onDelete?.call();
              }
            }),
      ),
    );
  }
}
