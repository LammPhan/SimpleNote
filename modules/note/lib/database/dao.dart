// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:note/home/model/event.dart';

@dao
abstract class EventDao {
  @Query('SELECT * FROM Event')
  Future<List<Event>> findAllEvent();

  @Query('SELECT * FROM Event WHERE id = :id')
  Stream<Event?> findEventById(int id);

  @insert
  Future<void> insertEvent(Event event);

  @update
  Future<void> updateEvent(Event event);

  @delete
  Future<void> deleteEvent(Event event);
}
