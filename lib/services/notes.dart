import 'package:mythings/database/helper.dart';
import 'package:mythings/models/note.dart';

class NotesService {
  static Future<Note> create({
    required String title,
    required String content,
  }) async {
    int id = await DatabaseHelper.instance.insert({
      'title': title,
      'content': content,
    });
    return Note(
      id: id,
      title: title,
      content: content,
    );
  }

  static Future<List<Note>> listAll() async {
    List<Map<String, dynamic>> result =
        await DatabaseHelper.instance.queryAll();
    return result.map((e) => Note.fromMap(e)).toList();
  }

  static Future<int> deleteOne({required Note note}) async {
    return await DatabaseHelper.instance.delete(note.id!);
  }

  static Future<int> updateOne({
    required Note note,
    required Map<String, dynamic> data,
  }) async {
    return await DatabaseHelper.instance.update(note.id!, data);
  }
}
