import 'dart:async';
import 'package:floor/floor.dart';
import 'package:note/home/model/event.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Event])
abstract class AppDatabase extends FloorDatabase {
  EventDao get eventDao;
}
