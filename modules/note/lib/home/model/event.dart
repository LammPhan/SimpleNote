import 'package:floor/floor.dart';

@entity
class Event {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? title;
  final String? content;

  Event({this.id, required this.title, required this.content});
}
